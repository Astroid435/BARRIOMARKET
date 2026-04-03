import json
import os
import uuid

from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.core.files.storage import FileSystemStorage
from django.core.paginator import Paginator
from django.db.models import Q
from django.http import JsonResponse
from django.shortcuts import redirect, get_object_or_404
from django.views.generic import ListView, DetailView, TemplateView, View

ALLOWED_IMAGE_EXTENSIONS = {'.jpg', '.jpeg', '.png', '.gif', '.webp'}
MAX_IMAGE_SIZE = 5 * 1024 * 1024  # 5 MB


def _validar_imagen(archivo):
    """Validate uploaded image file type and size. Returns error string or None."""
    ext = os.path.splitext(archivo.name)[1].lower()
    if ext not in ALLOWED_IMAGE_EXTENSIONS:
        return f"Tipo de archivo no permitido ({ext}). Use: {', '.join(ALLOWED_IMAGE_EXTENSIONS)}"
    if archivo.size > MAX_IMAGE_SIZE:
        return "La imagen no puede superar los 5 MB."
    return None

from .models import Productos, Categoria, Subcategoria, ProductosCategoria, Fabricante
from apps.pedidos.models import Carrito


# ---------- Mixins ----------

class AdminRequeridoMixin(LoginRequiredMixin, UserPassesTestMixin):
    login_url = 'inicio'

    def test_func(self):
        return self.request.user.is_authenticated and self.request.user.rol.Nombre == 'Administrador'


# ---------- Catálogo público ----------

class CatalogoListView(ListView):
    model = Productos
    template_name = 'catalogo.html'
    context_object_name = 'productos'
    paginate_by = 12

    def get_queryset(self):
        qs = Productos.objects.all().distinct()

        categoria_id = self.request.GET.get('categoria')
        if categoria_id:
            qs = qs.filter(
                productoscategoria__Subcategoria__Categoria_id=categoria_id
            ).distinct()

        fabricante_id = self.request.GET.get('fabricante')
        if fabricante_id:
            qs = qs.filter(Fabricante_id=fabricante_id)

        precio_min = self.request.GET.get('precio_min')
        if precio_min:
            qs = qs.filter(ValorVenta__gte=precio_min)

        precio_max = self.request.GET.get('precio_max')
        if precio_max:
            qs = qs.filter(ValorVenta__lte=precio_max)

        if self.request.user.is_authenticated and self.request.user.es_cliente:
            qs = qs.filter(Cantidad__gte=1)

        busqueda = self.request.GET.get('busqueda')
        if busqueda:
            qs = qs.filter(
                Q(Nombre__icontains=busqueda) | Q(Descripcion__icontains=busqueda)
            )

        return qs.select_related('Fabricante').prefetch_related(
            'productoscategoria_set__Subcategoria__Categoria'
        )

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['categorias'] = Categoria.objects.filter(
            subcategoria__productoscategoria__isnull=False
        ).distinct()
        context['fabricantes'] = Fabricante.objects.filter(
            productos__isnull=False
        ).distinct()
        return context


# ---------- Admin: Listado de registros (productos + fabricantes) ----------

class RegistrosListView(AdminRequeridoMixin, TemplateView):
    template_name = 'registros.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        b_productos = self.request.GET.get('BProductos', '')

        if b_productos:
            productos = Productos.objects.filter(Nombre__icontains=b_productos)
        else:
            productos = Productos.objects.all()

        listadoproductos = []
        for producto in productos:
            buscarsubcategorias = ProductosCategoria.objects.filter(Productos=producto.id)
            subcategoriasnombres = []
            nombre_categoria = None
            for sc in buscarsubcategorias:
                subcategoriasnombres.append(sc.Subcategoria.Nombre)
                nombre_categoria = sc.Subcategoria.Categoria.Nombre

            listadoproductos.append({
                'idProducto': producto.id,
                'Nombre': producto.Nombre,
                'Cantidad': producto.Cantidad,
                'Descripcion': producto.Descripcion,
                'ValorVenta': producto.ValorVenta,
                'Fabricante': producto.Fabricante.Nombre,
                'Categoria': nombre_categoria,
                'Subcategorias': subcategoriasnombres,
            })

        listadofabricantes = []
        for fabricante in Fabricante.objects.all():
            productos_nombres = list(
                Productos.objects.filter(Fabricante=fabricante.id).values_list('Nombre', flat=True)
            )
            listadofabricantes.append({
                'idFabricante': fabricante.id,
                'Nombre': fabricante.Nombre,
                'Productos': productos_nombres,
            })

        context['listadoproductos'] = listadoproductos
        context['listadofabricantes'] = listadofabricantes
        return context

    def get(self, request, *args, **kwargs):
        if request.headers.get('x-requested-with') == 'XMLHttpRequest':
            context = self.get_context_data(**kwargs)
            return JsonResponse({'results': context['listadoproductos']})
        return super().get(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        if request.POST.get('NombreFabricante') and request.POST.get('TelefonoFabricante'):
            Fabricante.objects.create(
                Nombre=request.POST.get('NombreFabricante'),
                Telefono=request.POST.get('TelefonoFabricante')
            )
        return redirect('/registros')


# ---------- Admin: Crear producto ----------

class ProductoCreateView(AdminRequeridoMixin, TemplateView):
    template_name = 'Productos/AgregarProductos.html'

    def _get_base_context(self, request):
        categoriaidsession = request.session.get('categoria', 0)
        fabricanteidsession = request.session.get('fabricante', 0)

        listadofabricante = Fabricante.objects.all()
        listadocategoria = Categoria.objects.all()
        listadosubcategorias = Subcategoria.objects.filter(Categoria=categoriaidsession)

        if fabricanteidsession == 0:
            nombrefabricante = 0
        else:
            nombrefabricante = Fabricante.objects.get(id=fabricanteidsession).Nombre

        if categoriaidsession == 0:
            nombrecategoria = 0
        else:
            nombrecategoria = Categoria.objects.get(id=categoriaidsession).Nombre

        return {
            'fabricantes': listadofabricante,
            'categorias': listadocategoria,
            'subcategorias': listadosubcategorias,
            'Seleccionfabricante': nombrefabricante,
            'Seleccioncategoria': nombrecategoria,
            'errores': [],
        }

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context.update(self._get_base_context(self.request))
        return context

    def post(self, request, *args, **kwargs):
        if request.POST.get('CategoriaSeleccionadoId'):
            request.session['categoria'] = request.POST.get('CategoriaSeleccionadoId')

        elif request.POST.get('fabricanteSeleccionadoId'):
            request.session['fabricante'] = request.POST.get('fabricanteSeleccionadoId')

        elif request.POST.get('SubcategoriaSeleccionadoId'):
            subcategorias_seleccionadas = json.loads(request.POST['SubcategoriaSeleccionadoId'])
            request.session['subcategorias'] = subcategorias_seleccionadas

        elif request.POST.get('Nombre_subcategoria'):
            categoria = Categoria.objects.get(id=request.session.get('categoria', '0'))
            Subcategoria.objects.create(
                Nombre=request.POST.get('Nombre_subcategoria'),
                Categoria=categoria
            )

        elif request.POST.get('NombreFabricante') and request.POST.get('TelefonoFabricante'):
            Fabricante.objects.create(
                Nombre=request.POST.get('NombreFabricante'),
                Telefono=request.POST.get('TelefonoFabricante')
            )

        elif request.POST.get('NombreCategoria'):
            Categoria.objects.create(Nombre=request.POST.get('NombreCategoria'))

        elif (request.POST.get('Nombre') and request.POST.get('Cantidad')
              and request.POST.get('ValorVenta') and request.POST.get('ValorCompra')
              and request.POST.get('Descripcion') and request.FILES.get('imagen')):

            fabricante_id = request.session.get('fabricante', 0)
            instancia_fabricante = Fabricante.objects.get(id=fabricante_id)
            errores = []

            if Productos.objects.filter(
                Nombre=request.POST.get('Nombre'), Fabricante_id=fabricante_id
            ).exists():
                errores.append("Ya existe un producto con ese nombre para este fabricante.")

            try:
                valor_venta = float(request.POST.get('ValorVenta'))
                valor_compra = float(request.POST.get('ValorCompra'))
                cantidad = float(request.POST.get('Cantidad'))
                if valor_compra > valor_venta:
                    errores.append("El precio de compra no puede ser mayor al de venta.")
                if valor_compra < 1:
                    errores.append("El valor de compra no puede ser menor a 0")
                if valor_venta < 1:
                    errores.append("El valor de venta no puede ser menor a 0")
                if cantidad < 0:
                    errores.append("La cantidad no puede ser menor a 0")
            except ValueError:
                errores.append("Los valores de compra, venta y cantidad deben ser numéricos.")

            archivo_imagen = request.FILES['imagen']
            error_imagen = _validar_imagen(archivo_imagen)
            if error_imagen:
                errores.append(error_imagen)

            if errores:
                context = self._get_base_context(request)
                context['errores'] = errores
                return self.render_to_response(context)

            extension = os.path.splitext(archivo_imagen.name)[1].lower()
            nombre_aleatorio = str(uuid.uuid4()) + extension

            producto = Productos(
                Nombre=request.POST.get('Nombre'),
                Cantidad=request.POST.get('Cantidad'),
                ValorVenta=request.POST.get('ValorVenta'),
                ValorCompra=request.POST.get('ValorCompra'),
                Descripcion=request.POST.get('Descripcion'),
                imagen=nombre_aleatorio,
                Fabricante=instancia_fabricante
            )

            imagen_storage = FileSystemStorage()
            imagen_storage.save(nombre_aleatorio, archivo_imagen)
            producto.save()

            buscarproducto = Productos.objects.get(
                Nombre=request.POST.get('Nombre'), Fabricante=fabricante_id
            )
            subcategorias = request.session.get('subcategorias', '0')
            for i in subcategorias:
                buscarsubcategoria = Subcategoria.objects.get(id=i)
                ProductosCategoria.objects.create(
                    Productos=buscarproducto,
                    Subcategoria=buscarsubcategoria
                )
            return redirect('/registros')

        return redirect(request.path)


# ---------- Admin: Actualizar producto ----------

class ProductoUpdateView(AdminRequeridoMixin, TemplateView):
    template_name = 'Productos/ActualizarProducto.html'

    def _get_base_context(self, request, producto_qs):
        categoriaidsession = request.session.get('categoria', 0)
        fabricanteidsession = request.session.get('fabricante', 0)

        listadofabricante = Fabricante.objects.all()
        listadocategoria = Categoria.objects.all()
        listadosubcategorias = Subcategoria.objects.filter(Categoria=categoriaidsession)

        if fabricanteidsession == 0:
            nombrefabricante = 0
        else:
            nombrefabricante = Fabricante.objects.get(id=fabricanteidsession).Nombre

        if categoriaidsession == 0:
            nombrecategoria = 0
        else:
            nombrecategoria = Categoria.objects.get(id=categoriaidsession).Nombre

        return {
            'fabricantes': listadofabricante,
            'categorias': listadocategoria,
            'subcategorias': listadosubcategorias,
            'Seleccionfabricante': nombrefabricante,
            'Seleccioncategoria': nombrecategoria,
            'Producto': producto_qs,
            'errores': [],
        }

    def get(self, request, idProducto, *args, **kwargs):
        producto_qs = Productos.objects.filter(id=idProducto)
        context = self._get_base_context(request, producto_qs)
        return self.render_to_response(context)

    def post(self, request, idProducto, *args, **kwargs):
        producto = Productos.objects.get(id=idProducto)
        producto_qs = Productos.objects.filter(id=idProducto)

        if request.POST.get('CategoriaSeleccionadoId'):
            request.session['categoria'] = request.POST.get('CategoriaSeleccionadoId')

        elif request.POST.get('fabricanteSeleccionadoId'):
            request.session['fabricante'] = request.POST.get('fabricanteSeleccionadoId')

        elif request.POST.get('SubcategoriaSeleccionadoId'):
            subcategorias_seleccionadas = json.loads(request.POST['SubcategoriaSeleccionadoId'])
            request.session['subcategorias'] = subcategorias_seleccionadas

        elif (request.POST.get('Nombre') and request.POST.get('Cantidad')
              and request.POST.get('ValorVenta') and request.POST.get('ValorCompra')
              and request.POST.get('Descripcion')):

            fabricante_id = request.session.get('fabricante', 0)
            instancia_fabricante = Fabricante.objects.get(id=fabricante_id)
            errores = []

            if Productos.objects.filter(
                Nombre=request.POST.get('Nombre'), Fabricante_id=fabricante_id
            ).exclude(id=idProducto).exists():
                errores.append("Ya existe un producto con ese nombre para este fabricante.")

            try:
                valor_venta = float(request.POST.get('ValorVenta'))
                valor_compra = float(request.POST.get('ValorCompra'))
                if valor_compra > valor_venta:
                    errores.append("El precio de compra no puede ser mayor al de venta.")
            except ValueError:
                errores.append("Los valores de compra y venta deben ser numéricos.")

            archivo_imagen = request.FILES.get('imagen')
            if archivo_imagen:
                error_imagen = _validar_imagen(archivo_imagen)
                if error_imagen:
                    errores.append(error_imagen)

            if errores:
                context = self._get_base_context(request, producto_qs)
                context['errores'] = errores
                return self.render_to_response(context)

            if archivo_imagen:
                extension = os.path.splitext(archivo_imagen.name)[1].lower()
                nombre_aleatorio = str(uuid.uuid4()) + extension
                imagen_storage = FileSystemStorage()
                imagen_storage.save(nombre_aleatorio, archivo_imagen)
                producto.imagen = nombre_aleatorio

            producto.Nombre = request.POST.get('Nombre')
            producto.Cantidad = request.POST.get('Cantidad')
            producto.ValorVenta = request.POST.get('ValorVenta')
            producto.ValorCompra = request.POST.get('ValorCompra')
            producto.Descripcion = request.POST.get('Descripcion')
            producto.Fabricante = instancia_fabricante
            producto.save()

            subcategorias = request.session.get('subcategorias', 0)
            if subcategorias != 0:
                ProductosCategoria.objects.filter(Productos=producto.id).delete()
                for i in subcategorias:
                    buscarsubcategoria = Subcategoria.objects.get(id=i)
                    ProductosCategoria.objects.create(
                        Productos=producto,
                        Subcategoria=buscarsubcategoria
                    )
            return redirect('/registros')

        return redirect(request.path)


# ---------- Admin: Eliminar producto ----------

class ProductoDeleteView(AdminRequeridoMixin, View):
    def get(self, request, idProducto, *args, **kwargs):
        return self._delete(request, idProducto)

    def post(self, request, idProducto, *args, **kwargs):
        return self._delete(request, idProducto)

    def _delete(self, request, idProducto):
        producto = get_object_or_404(Productos, id=idProducto)
        producto.delete()
        return redirect('/registros')


# ---------- Detalle de producto ----------

class ProductoDetailView(DetailView):
    model = Productos
    template_name = 'Productos/VistaProducto.html'
    pk_url_kwarg = 'idProducto'
    context_object_name = 'producto_obj'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        producto = self.object

        buscarsubcategorias = ProductosCategoria.objects.filter(Productos=producto.id)
        subcategoriasnombres = []
        nombre_categoria = None
        for sc in buscarsubcategorias:
            subcategoriasnombres.append(sc.Subcategoria.Nombre)
            nombre_categoria = sc.Subcategoria.Categoria.Nombre

        listaproducto = [{
            'idProducto': producto.id,
            'Nombre': producto.Nombre,
            'Cantidad': producto.Cantidad,
            'Descripcion': producto.Descripcion,
            'ValorVenta': producto.ValorVenta,
            'Imagen': producto.imagen,
            'Fabricante': producto.Fabricante.Nombre,
            'Categoria': nombre_categoria,
            'Subcategorias': subcategoriasnombres,
        }]

        listarelacionados = []
        categoria = producto.categorias
        if categoria:
            productosRelacionados = categoria.productos()
            for prod in productosRelacionados:
                if prod.id != producto.id and prod.Cantidad > 0:
                    listarelacionados.append({
                        'idProducto': prod.id,
                        'Nombre': prod.Nombre,
                        'Descripcion': prod.Descripcion,
                        'ValorVenta': prod.ValorVenta,
                        'Imagen': prod.imagen,
                    })

        context['Productos'] = listaproducto
        context['errores'] = []
        context['Relacionados'] = listarelacionados
        return context

    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        listaerrores = []

        if request.user.is_authenticated:
            if request.POST.get('Cantidad') and request.POST.get('Producto'):
                user = request.user
                producto = Productos.objects.get(id=request.POST.get('Producto'))
                cantidad = int(request.POST.get('Cantidad'))

                if cantidad > 0:
                    if request.user.es_cliente:
                        if cantidad <= producto.Cantidad:
                            carrito, created = Carrito.objects.get_or_create(
                                Usuario=user, Productos=producto, defaults={'Cantidad': 0}
                            )
                            if not created:
                                nueva_cantidad = carrito.Cantidad + cantidad
                                if nueva_cantidad <= producto.Cantidad:
                                    carrito.Cantidad = nueva_cantidad
                                    carrito.save()
                                    return redirect("/Carrito")
                                else:
                                    listaerrores.append("No hay suficiente stock")
                            else:
                                carrito.Cantidad = cantidad
                                carrito.save()
                                return redirect("/Carrito")
                        else:
                            listaerrores.append("No hay suficiente stock")
                    else:
                        carrito, created = Carrito.objects.get_or_create(
                            Usuario=user, Productos=producto, defaults={'Cantidad': 0}
                        )
                        if not created:
                            nueva_cantidad = carrito.Cantidad + cantidad
                            carrito.Cantidad = nueva_cantidad
                            carrito.save()
                            return redirect("/Carrito")
                        else:
                            carrito.Cantidad = cantidad
                            carrito.save()
                            return redirect("/Carrito")
                else:
                    listaerrores.append(
                        "No se puede agregar un producto con cantidad igual o menor a 0"
                    )

        context = self.get_context_data()
        context['errores'] = listaerrores
        return self.render_to_response(context)


# ---------- Vista Home ----------

class HomeView(TemplateView):
    template_name = 'home.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['productos'] = Productos.objects.filter(Cantidad__gte=1)[:3]
        context['categoria'] = Categoria.objects.all()[:5]
        context['categorias'] = Categoria.objects.all()
        return context
