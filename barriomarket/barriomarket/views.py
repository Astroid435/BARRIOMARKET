from django.utils import timezone
from datetime import timedelta
import json
import uuid
import random
import re  
from django.db.models import Q
from django.core.paginator import Paginator
from django.utils.timezone import now
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import render,redirect
from django.db import connection
from .forms import MyUserCreationForm
from django.contrib.admin.views.decorators import staff_member_required, user_passes_test
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.views import LoginView
from .models import CantidadPedido, Productos,Categoria,ProductosCategoria, RegistroPedido,Subcategoria,Fabricante,Carrito,Usuario
from django.core.files.storage import FileSystemStorage

def es_admin(user):
    return user.is_authenticated and user.rol.Nombre == 'Administrador' 

def auth(user):
    return user.is_authenticated and user.rol.Nombre == 'Administrador' 

def home(request):
    producto= Productos.objects.all()[:3]
    categorias= Categoria.objects.all()
    context = {
        'productos': producto,
        'categorias': categorias,
    }
    return render(request,'home.html', context)

def generate_code():
    digits = [str(random.randint(0, 9)) for _ in range(4)] 
    repeat_digit = random.choice(digits) 
    code = digits + [repeat_digit, repeat_digit]
    random.shuffle(code) 
    return ''.join(code)

def send_recovery_email(user_email, code):
    subject = 'Recuperación de contraseña'
    message = f'Tu código de recuperación es: {code}. Este código es válido por 10 minutos.'
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [user_email]
    send_mail(subject, message, email_from, recipient_list)

def register(request):
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/inicio')
    else:
        form = MyUserCreationForm()
    return render(request, 'registro.html', {'form': form})

@user_passes_test(es_admin, login_url='inicio')
def registros(request):
    
    if request.method == 'POST':
        if request.POST.get('NombreFabricante') and request.POST.get('TelefonoFabricante'):
            insertar= Fabricante(
                Nombre=request.POST.get('NombreFabricante'),
                Telefono=request.POST.get('TelefonoFabricante')
            )
            insertar.save()
    
    listadoproductos=[]
    listadofabricantes=[]
    
    BProductos = request.GET.get('BProductos', '')
    
    # Filtrar productos si hay un término de búsqueda
    if BProductos:
        productos = Productos.objects.filter(Nombre__icontains=BProductos)
    else:
        productos = Productos.objects.all()
    
    for producto in productos:
        buscarsubcategorias = ProductosCategoria.objects.filter(Productos=producto.id)
        subcategoriasnombres = []
        NombreCategoria = None
        for subcategorias in buscarsubcategorias:
            subcategoriasnombres.append(subcategorias.Subcategoria.Nombre)
            NombreCategoria = subcategorias.Subcategoria.Categoria.Nombre
        
        listadoproductos.append({
            'idProducto': producto.id, 
            'Nombre': producto.Nombre,
            'Cantidad': producto.Cantidad,
            'Descripcion': producto.Descripcion,
            'ValorVenta': producto.ValorVenta,
            'Fabricante': producto.Fabricante.Nombre,
            'Categoria': NombreCategoria,
            'Subcategorias': subcategoriasnombres,
        })
    
    # Si es una petición AJAX, devolver los resultados en JSON
    if request.headers.get('x-requested-with') == 'XMLHttpRequest':
        return JsonResponse({'results': listadoproductos})
      
    fabricantes=Fabricante.objects.all()
    for fabricante in fabricantes:
        ProductosNombres=[]
        buscarproductos=Productos.objects.filter(Fabricante=fabricante.id)
        for producto in buscarproductos:
            ProductosNombres.append(producto.Nombre)
        listadofabricantes.append({
            'idFabricante': fabricante.id,
            'Nombre': fabricante.Nombre,
            'Productos': ProductosNombres
        })
        
    
    
    return render(request,'registros.html',{'listadoproductos':listadoproductos,'listadofabricantes':listadofabricantes})

@user_passes_test(es_admin, login_url='inicio')
def borrarproductos(request, idProducto):
    borrar=Productos.objects.get(id=idProducto)
    borrar.delete()
    return redirect("/registros")

@user_passes_test(es_admin, login_url='inicio')
def AgregarProductos(request):
    
    subcategorias=[]

    if request.method == 'POST':
        if request.POST.get('CategoriaSeleccionadoId'):
            request.session['categoria'] = request.POST.get('CategoriaSeleccionadoId')

        elif request.POST.get('fabricanteSeleccionadoId'):
            request.session['fabricante'] = request.POST.get('fabricanteSeleccionadoId')

        elif request.POST.get('SubcategoriaSeleccionadoId'):
            subcategorias_seleccionadas = json.loads(request.POST['SubcategoriaSeleccionadoId'])
            request.session['subcategorias'] = subcategorias_seleccionadas

        elif request.POST.get('Nombre_subcategoria'):
            categoria = Categoria.objects.get(id=request.session.get('categoria', '0'))
            insertar=Subcategoria(
                Nombre=request.POST.get('Nombre_subcategoria'),
                Categoria=categoria
            )
            insertar.save()
            
        elif request.POST.get('NombreFabricante') and request.POST.get('TelefonoFabricante'):
            insertar= Fabricante(
                Nombre=request.POST.get('NombreFabricante'),
                Telefono=request.POST.get('TelefonoFabricante')
            )
            insertar.save()
        
        elif request.POST.get('NombreCategoria'):
            insertar=Categoria(
                Nombre=request.POST.get('NombreCategoria')
            )
            insertar.save()
        
        elif request.POST.get('Nombre') and request.POST.get('Cantidad') and request.POST.get('ValorVenta') and request.POST.get('ValorCompra') and request.POST.get('Descripcion') and request.FILES['imagen']:
          fabricante = request.session.get('fabricante', 0)
          instancia_fabricante=Fabricante.objects.get(id=fabricante)
          archivo_imagen = request.FILES['imagen']
          extension = archivo_imagen.name.split('.')[-1] 
          nombre_aleatorio = str(uuid.uuid4()) + '.' + extension

          insertarproducto = Productos(
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
          
          insertarproducto.save()
          buscarproducto=Productos.objects.get(Nombre=request.POST.get('Nombre'), Fabricante = fabricante)

          subcategorias = request.session.get('subcategorias', '0')
          for i in subcategorias:
            buscarsubcategoria=Subcategoria.objects.get(id=i)
            SubcategoriasProducto=ProductosCategoria(
                Productos=buscarproducto,
                Subcategoria=buscarsubcategoria
            )
            SubcategoriasProducto.save()
          return redirect("/registros")     

    categoriaidsession = request.session.get('categoria', 0)
    fabricanteidsession = request.session.get('fabricante', 0)
        
    listadofabricante = Fabricante.objects.all()
    listadocategoria= Categoria.objects.all()
    listadosubcategorias = Subcategoria.objects.filter(Categoria=categoriaidsession)
        
    if fabricanteidsession == 0:
        Nombrefabricante = 0
    else:
        FabricanteSeleccionado=Fabricante.objects.get(id=fabricanteidsession)
        Nombrefabricante=FabricanteSeleccionado.Nombre

    if categoriaidsession == 0:
        Nombrecategoria = 0
    else:
        CategoriaSeleccionada=Categoria.objects.get(id=categoriaidsession)
        Nombrecategoria=CategoriaSeleccionada.Nombre
                    
    return render(request,'Productos/AgregarProductos.html',{'fabricantes':listadofabricante, 'categorias':listadocategoria, 'subcategorias': listadosubcategorias, 'Seleccionfabricante': Nombrefabricante, 'Seleccioncategoria': Nombrecategoria})

@user_passes_test(es_admin, login_url='inicio')
def ActualizarProducto(request, idProducto):
    
    Producto=Productos.objects.get(id=idProducto)
    BuscarProducto=Productos.objects.filter(id=idProducto)
    
    if request.method == 'POST':
        
        if request.POST.get('CategoriaSeleccionadoId'):
            request.session['categoria'] = request.POST.get('CategoriaSeleccionadoId')

        elif request.POST.get('fabricanteSeleccionadoId'):
            request.session['fabricante'] = request.POST.get('fabricanteSeleccionadoId')

        elif request.POST.get('SubcategoriaSeleccionadoId'):
            subcategorias_seleccionadas = json.loads(request.POST['SubcategoriaSeleccionadoId'])
            request.session['subcategorias'] = subcategorias_seleccionadas
        
        elif request.POST.get('Nombre') and request.POST.get('Cantidad') and request.POST.get('ValorVenta') and request.POST.get('ValorCompra') and request.POST.get('Descripcion'):
            fabricante = request.session.get('fabricante', 0)
            instancia_fabricante=Fabricante.objects.get(id=fabricante)
            Imagen=""
            Producto.Nombre=request.POST.get('Nombre')
            Producto.Cantidad=request.POST.get('Cantidad')
            Producto.ValorVenta=request.POST.get('ValorVenta')
            Producto.ValorCompra=request.POST.get('ValorCompra')
            Producto.Descripcion=request.POST.get('Descripcion')
            Producto.imagen=Imagen
            Producto.Fabricante=instancia_fabricante
            Producto.save()
            
            subcategorias = request.session.get('subcategorias', 0)
            if subcategorias != 0:
                BuscarSubcategorias=ProductosCategoria.objects.filter(Productos=Producto.id)
                BuscarSubcategorias.delete()
                
                for i in subcategorias:
                    buscarsubcategoria=Subcategoria.objects.get(id=i)
                    AgregarSubcategoriasProducto=ProductosCategoria(
                        Productos=Producto,
                        Subcategoria=buscarsubcategoria
                    )
                    AgregarSubcategoriasProducto.save()
      
            return redirect("/registros")   

    categoriaidsession = request.session.get('categoria', 0)
    fabricanteidsession = request.session.get('fabricante', 0)
    listadofabricante = Fabricante.objects.all()
    listadocategoria= Categoria.objects.all()
    listadosubcategorias = Subcategoria.objects.filter(Categoria=categoriaidsession)
        
    if fabricanteidsession == 0:
        Nombrefabricante = 0
    else:
        FabricanteSeleccionado=Fabricante.objects.get(id=fabricanteidsession)
        Nombrefabricante=FabricanteSeleccionado.Nombre

    if categoriaidsession == 0:
        Nombrecategoria = 0
    else:
        CategoriaSeleccionada=Categoria.objects.get(id=categoriaidsession)
        Nombrecategoria=CategoriaSeleccionada.Nombre
    
    return render(request,'Productos/ActualizarProducto.html',{'fabricantes':listadofabricante, 'categorias':listadocategoria, 'subcategorias': listadosubcategorias, 'Seleccionfabricante': Nombrefabricante, 'Seleccioncategoria': Nombrecategoria, 'Producto': BuscarProducto})

def VistaProducto (request, idProducto):

    listaproducto=[]
    listaerrores=[]
    listarelacionados=[]
    
    producto=Productos.objects.get(id=idProducto)
    
    buscarsubcategorias = ProductosCategoria.objects.filter(Productos=producto.id)
    subcategoriasnombres = []
    NombreCategoria = None
    for subcategorias in buscarsubcategorias:
        subcategoriasnombres.append(subcategorias.Subcategoria.Nombre)
        NombreCategoria = subcategorias.Subcategoria.Categoria.Nombre
        idCategoria = subcategorias.Subcategoria.Categoria.id
        
    listaproducto.append({
            'idProducto': producto.id, 
            'Nombre': producto.Nombre,
            'Cantidad': producto.Cantidad,
            'Descripcion': producto.Descripcion,
            'ValorVenta': producto.ValorVenta,
            'Imagen': producto.imagen,
            'Fabricante': producto.Fabricante.Nombre,
            'Categoria': NombreCategoria,
            'Subcategorias': subcategoriasnombres,
    })
    
    
    categoria = producto.categorias
    productosRelacionados = categoria.productos()

    for prod in productosRelacionados:
        if prod.id != producto.id:  # Evita incluir el producto actual
            listarelacionados.append({
                'idProducto': prod.id,
                'Nombre': prod.Nombre,
                'Descripcion': prod.Descripcion,
                'ValorVenta': prod.ValorVenta,
                'Imagen': prod.imagen,
            })
      
    if request.user.is_authenticated:
        if request.method == 'POST':
            if request.POST.get('Cantidad') and request.POST.get('Producto'):
                user = request.user
                producto = Productos.objects.get(id=request.POST.get('Producto'))
                cantidad = int(request.POST.get('Cantidad'))
                
                if cantidad > 0:
                
                    if cantidad <= producto.Cantidad:
                        
                        # Intentamos obtener el carrito con el producto para este usuario
                        carrito, created = Carrito.objects.get_or_create(
                            Usuario=user,
                            Productos=producto,
                            defaults={'Cantidad': 0}
                        )

                        # Si el carrito ya existía, actualizamos la cantidad
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
                    listaerrores.append("No se puede agregar un producto con cantidad igual o menor a 0")
            
    return  render(request, "Productos/VistaProducto.html", {'Productos': listaproducto,'errores':listaerrores, 'Relacionados':listarelacionados})

def catalogo(request):
    productos = Productos.objects.all().distinct()
    
    # Filtro por categoría (usando la relación a través de ProductosCategoria)
    categoria_id = request.GET.get('categoria')
    if categoria_id:
        productos = productos.filter(
            productoscategoria__Subcategoria__Categoria_id=categoria_id
        ).distinct()
    
    # Filtro por fabricante
    fabricante_id = request.GET.get('fabricante')
    if fabricante_id:
        productos = productos.filter(Fabricante_id=fabricante_id)
    
    # Filtros por precio y búsqueda
    precio_min = request.GET.get('precio_min')
    if precio_min:
        productos = productos.filter(ValorVenta__gte=precio_min)
    
    precio_max = request.GET.get('precio_max')
    if precio_max:
        productos = productos.filter(ValorVenta__lte=precio_max)
    
    busqueda = request.GET.get('busqueda')
    if busqueda:
        productos = productos.filter(
            Q(Nombre__icontains=busqueda) |
            Q(Descripcion__icontains=busqueda)
        )
    
    # Optimización de consultas
    productos = productos.select_related('Fabricante').prefetch_related(
        'productoscategoria_set__Subcategoria__Categoria'
    )
    
    # Paginación
    paginator = Paginator(productos, 12)
    page_number = request.GET.get('page')
    page_obj = paginator.get_page(page_number)
    
    # Categorías disponibles (productos que tienen al menos un producto)
    categorias = Categoria.objects.filter(
        subcategoria__productoscategoria__isnull=False
    ).distinct()
    
    # Fabricantes disponibles (que tienen productos)
    fabricantes = Fabricante.objects.filter(
        productos__isnull=False
    ).distinct()
    
    context = {
        'productos': page_obj,
        'categorias': categorias,
        'fabricantes': fabricantes,
    }
    return render(request, 'catalogo.html', context)

@user_passes_test(auth, login_url='inicio')
def Vistacarrito (request):
    listadocarrito=[]
    ValorTodo=0
    if request.user.is_authenticated:
            user_id = request.user.id
            carrito = Carrito.objects.filter(Usuario=user_id)
            for carro in carrito:
                idcarrito=carro.id
                Cantidadventa=carro.Productos.ValorVenta
                Cantidad=carro.Cantidad
                CantidadTotal=Cantidadventa*Cantidad
                ValorTodo+=CantidadTotal
                Nombre=carro.Productos.Nombre
                fabricante=carro.Productos.Fabricante.Nombre
                listadocarrito.append({
                    'idCarrito':idcarrito,
                    'Nombre':Nombre,
                    'ValorUnitario':Cantidadventa,
                    'ValorTotal': CantidadTotal,
                    'Cantidad':Cantidad,
                    'NombreFabricante':fabricante
                })
        
            if request.method == 'POST':
                if request.POST.get('id') and request.POST.get('menos'):
                    carrito=Carrito.objects.get(id=request.POST.get('id'))
                    if carrito.Cantidad==1:
                        carrito.delete()
                        return redirect("/Carrito")
                    else:
                        carrito.Cantidad-=1
                        carrito.save()
                        return redirect("/Carrito")
                elif request.POST.get('id') and request.POST.get('mas'):
                    carrito=Carrito.objects.get(id=request.POST.get('id'))
                    if carrito.Cantidad<carrito.Productos.Cantidad:
                        carrito.Cantidad+=1
                        carrito.save()
                        return redirect("/Carrito")
                    
            
            return  render(request, "carrito.html",{'listadocarrito':listadocarrito,'ValorTodo':ValorTodo })

@user_passes_test(auth, login_url='inicio')
def borrarcarro(request, idCarro):
    borrar=Carrito.objects.get(id=idCarro)
    borrar.delete()
    return redirect("/Carrito")

@user_passes_test(auth, login_url='inicio')
def GenerarPedido(request):
    if request.user.is_authenticated:
        carrito=Carrito.objects.filter(Usuario=request.user)
        if request.method == 'POST':
            if request.POST.get('Observaciones') and request.POST.get('ValorTotal'):
                pedido=RegistroPedido(
                    Fecha=timezone.now(),
                    Observaciones=request.POST.get('Observaciones'),
                    ValorTotal=request.POST.get('ValorTotal'),
                    Usuario=request.user,
                    Estado="sin_atender"
                )
                pedido.save()
                for carro in carrito:
                    Cantidadpedido=CantidadPedido(
                        Productos=carro.Productos,
                        RegistroPedido=pedido,
                        Cantidad=carro.Cantidad
                    )
                    Cantidadpedido.save()
                    carro.delete()
                    
                return render(request, '/carrito')

def SolicutarCorreo(request):
    if request.method == 'POST':
        email = request.POST['Correo']
        try:            
            user = Usuario.objects.get(Correo=email)
            code = generate_code()
            send_recovery_email(user.Correo, code)
            request.session['reset_code'] = code
            request.session['reset_email'] = email
            request.session['code_generated_time'] = now().timestamp()  # Guardar tiempo de generación
            return redirect('/CambioContrasena/Codigo')  # Redirigir a la página de verificación de código
        except User.DoesNotExist:
            # Manejar el caso cuando el correo no existe
            pass
    return render(request, 'CambioContrasena/SolicitudCorreo.html')
  
def SolicitarCodigo(request):
    if request.method == 'POST':
        entered_code = request.POST['code']
        generated_code = request.session.get('reset_code')
        email = request.session.get('reset_email')
        code_time = request.session.get('code_generated_time')

        if generated_code and email:
            # Verifica si el código coincide y si no ha expirado (ej. 10 minutos)
            if entered_code == generated_code and now().timestamp() - code_time < 600:
                # Código válido, redirigir al formulario de cambio de contraseña
                return redirect('/CambioContrasena/Cambio')
            else:
                pass
    return render(request, 'CambioContrasena/SolicitudCodigo.html')
  
def SolicitarContrasena(request):
  Errores=[]
  if request.method == 'POST':
    if request.POST.get('Contrasena') and request.POST.get('CContrasena'):
      Contrasena=request.POST.get('Contrasena')
      CContrasena=request.POST.get('CContrasena')
      if Contrasena == CContrasena:
        if len(Contrasena) < 8:
            Errores.append("La contraseña debe tener al menos 8 caracteres")

        if not re.search(r'[A-Z]', Contrasena):
            Errores.append("La contraseña debe tener al menos una letra mayúscula")

        if not re.search(r'\d', Contrasena):
            Errores.append("La contraseña debe tener al menos un número")

        if not re.search(r'[@$!%*?&]', Contrasena):
            Errores.append("La contraseña debe tener al menos un carácter especial (@, $, !, %, *, ?, &)")
        
        if not Errores:
          email = request.session.get('reset_email')
          usuario=Usuario.objects.get(Correo=email)
          usuario.set_password(Contrasena)
          usuario.save()
          return redirect('/login')
      else:
        Errores.append("Las contraseñas no coinciden")
  
  return render(request, 'CambioContrasena/SolicitudContrasena.html',{'Errores':Errores})
        
class CustomLoginView(LoginView):
    form_class = AuthenticationForm
    template_name = 'login.html'

    def get_form(self, form_class=None):
        form = super(CustomLoginView, self).get_form(form_class)
        # Añadir clases CSS a los campos del formulario
        form.fields['username'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Correo'})
        form.fields['password'].widget.attrs.update({'class': 'form-control', 'placeholder': 'Contraseña'})
        return form


@user_passes_test(es_admin, login_url='inicio')
def Pedidos(request):
    pedidos = RegistroPedido.objects.prefetch_related('CantidadPedido__Productos').all()
    return render(request, 'pedidos/pedidos.html', {'lista_pedidos': pedidos})

@user_passes_test(es_admin, login_url='inicio')
def pedidos_ajax(request):
    estado = request.GET.get('estado')
    rango = request.GET.get('rango')
    pedidos = RegistroPedido.objects.all()

    if estado in ['atendido', 'sin_atender']:
        pedidos = pedidos.filter(Estado=estado)

    # Rango de fechas
    now = timezone.now()
    if rango == 'hoy':
        pedidos = pedidos.filter(Fecha=now.date())
    elif rango == 'semana':
        start = now - timedelta(days=now.weekday())
        pedidos = pedidos.filter(Fecha__gte=start.date())
    elif rango == 'mes':
        pedidos = pedidos.filter(Fecha__month=now.month, Fecha__year=now.year)

    return render(request, 'pedidos/_parcial_listado.html', {'lista_pedidos': pedidos})