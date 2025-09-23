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
from django.shortcuts import get_object_or_404, render,redirect
from django.db import connection
from .forms import MyUserCreationForm
from django.contrib.admin.views.decorators import staff_member_required, user_passes_test
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.views import LoginView
from .models import CantidadEncargo, CantidadPedido, Productos,Categoria,ProductosCategoria, RegistroEncargo, RegistroPedido,Subcategoria,Fabricante,Carrito,Usuario
from django.core.files.storage import FileSystemStorage
from django.contrib import messages
from django.contrib.auth import login as auth_login

def no_iniciado(user):
    if user.is_authenticated:
        return False
    else:
        return True

def es_admin(user):
    return user.is_authenticated and user.rol.Nombre == 'Administrador' 

def auth(user):
    return user.is_authenticated 

def home(request):
    producto= Productos.objects.all()
    producto = producto.filter(Cantidad__gte=1)[:3]
    categoria= Categoria.objects.all()[:5]
    categorias= Categoria.objects.all()
    context = {
        'productos': producto,
        'categoria': categoria,
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

    # Cuerpo del mensaje en formato HTML con un diseño más atractivo y la fuente Poppins
    message = f"""
    <html>
    <head>
        <style>
            /* Importando la fuente Poppins desde Google Fonts */
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap');

            body {{
                font-family: 'Poppins', sans-serif;
                background-color: #f8f8f8;
                color: #333333;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }}
            .email-container {{
                width: 100%;
                max-width: 600px;
                background-color: #ffffff;
                padding: 40px;
                border-radius: 12px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
                text-align: center;
                border: 1px solid #e1e1e1;
            }}
            h1 {{
                font-size: 32px;
                color: #333333;
                font-weight: 600;
                margin-bottom: 20px;
            }}
            p {{
                font-size: 16px;
                color: #666666;
                line-height: 1.6;
                margin-bottom: 20px;
            }}
            .code {{
                font-size: 28px;
                font-weight: 600;
                color: #ffffff;
                background-color: #333333;
                padding: 15px;
                border-radius: 8px;
                display: inline-block;
                margin-top: 20px;
                letter-spacing: 1px;
            }}
            .footer {{
                margin-top: 30px;
                font-size: 14px;
                color: #999999;
            }}
            .footer a {{
                color: #333333;
                text-decoration: none;
            }}
        </style>
    </head>
    <body>
        <div class="email-container">
            <h1>Recuperación de Contraseña</h1>
            <p>Hola,</p>
            <p>Hemos recibido una solicitud para recuperar tu contraseña. Tu código de recuperación es:</p>
            <p class="code">{code}</p>
            <p>Este código es válido por 10 minutos.</p>
            <p class="footer">Si no solicitaste este cambio, por favor ignora este mensaje.</p>
        </div>
    </body>
    </html>
    """
    
    email_from = settings.EMAIL_HOST_USER
    recipient_list = [user_email]
    send_mail(subject, message, email_from, recipient_list, html_message=message)

@user_passes_test(no_iniciado, login_url='inicio')
def auth_view(request):
    login_form = AuthenticationForm()
    register_form = MyUserCreationForm()

    # Personalización de campos login
    login_form.fields['username'].widget.attrs.update({
        'class': 'form-control', 'placeholder': 'Correo'
    })
    login_form.fields['password'].widget.attrs.update({
        'class': 'form-control', 'placeholder': 'Contraseña'
    })

    # Si se envió login
    if 'btn_login' in request.POST:
        login_form = AuthenticationForm(request, data=request.POST)
        if login_form.is_valid():
            auth_login(request, login_form.get_user())
            return redirect('/inicio')

    # Si se envió registro
    elif 'btn_register' in request.POST:
        register_form = MyUserCreationForm(request.POST)
        if register_form.is_valid():
            register_form.save()
            return redirect('/inicio')

    return render(request, 'auth.html', {
        'login_form': login_form,
        'register_form': register_form
    })

@user_passes_test(no_iniciado, login_url='inicio')
def register(request):
    if request.method == 'POST':
        form = MyUserCreationForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('/inicio')
    else:
        form = MyUserCreationForm()
    return render(request, 'registro.html', {'form': form})

def Perfil(request):
    rol = request.user.rol.id
    
    if request.method == 'POST':

        nombre = request.POST.get('nombre')
        apellido = request.POST.get('apellido')
        telefono = request.POST.get('Telefono')
        documento = request.POST.get('Documento')
        
        if not all([nombre, apellido, telefono, documento]):
            messages.error(request, "Por favor, completa todos los campos.")
            return redirect('/Perfil')
        
        errors = []
        
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', nombre):
            errors.append("El nombre solo puede contener letras y espacios.")
        
        if not re.match(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', apellido):
            errors.append("El apellido solo puede contener letras y espacios.")
            
        if len(nombre) < 2:
            errors.append("El nombre debe tener al menos 2 caracteres.")
            
        if len(apellido) < 2:
            errors.append("El apellido debe tener al menos 2 caracteres.")
        
        if not telefono.isdigit():
            errors.append("El teléfono solo puede contener números.")
            
        if len(telefono) < 7 or len(telefono) > 15:
            errors.append("El teléfono debe tener entre 7 y 15 dígitos.")
        
        # Validar documento (solo números)
        if not documento.isdigit():
            errors.append("El documento solo puede contener números.")
            
        if len(documento) < 6:
            errors.append("El documento debe tener al menos 6 dígitos.")
        
        if Usuario.objects.filter(Correo=correo).exclude(id=request.user.id).exists():
            errors.append("Este correo electrónico ya está registrado por otro usuario.")
        
        if Usuario.objects.filter(Documento=documento).exclude(id=request.user.id).exists():
            errors.append("Este documento ya está registrado por otro usuario.")
        
        if errors:
            for error in errors:
                messages.error(request, error)
            return redirect('/Perfil')
        
        try:
            usuario = Usuario.objects.get(id=request.user.id)
            usuario.Primer_nombre = nombre.strip()
            usuario.Primer_apellido = apellido.strip()
            usuario.Telefono = telefono
            usuario.Documento = documento
            usuario.save()
            messages.success(request, "Datos actualizados correctamente.")
        except Exception as e:
            messages.error(request, f"Error al actualizar los datos: {str(e)}")
        
        return redirect('/Perfil')
    
    # GET request
    if rol == 2:
        usuarios = Usuario.objects.all()
        return render(request, 'Perfil.html', {'usuarios': usuarios})
    else:
        return render(request, 'Perfil.html')
    
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

            archivo_imagen = request.FILES['imagen']
            extension = archivo_imagen.name.split('.')[-1] 
            nombre_aleatorio = str(uuid.uuid4()) + '.' + extension

            imagen_storage = FileSystemStorage()
            imagen_storage.save(nombre_aleatorio, archivo_imagen)

            Producto.Nombre=request.POST.get('Nombre')
            Producto.Cantidad=request.POST.get('Cantidad')
            Producto.ValorVenta=request.POST.get('ValorVenta')
            Producto.ValorCompra=request.POST.get('ValorCompra')
            Producto.Descripcion=request.POST.get('Descripcion')
            Producto.imagen=nombre_aleatorio
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
        if prod.id != producto.id:
            if not prod.Cantidad <= 0:  # Evita incluir el producto actual
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
                    if request.user.id==1:
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
                        # Intentamos obtener el carrito con el producto para este usuario
                        carrito, created = Carrito.objects.get_or_create(
                            Usuario=user,
                            Productos=producto,
                            defaults={'Cantidad': 0}
                        )
                        # Si el carrito ya existía, actualizamos la cantidad
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

    if productos:
        if request.user.id==1:
            productos = productos.filter(Cantidad__gte=1)
    
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

def compras(request):
    return render(request, 'compras/Compras.html')
@user_passes_test(auth, login_url='inicio')

def Vistacarrito(request):
    listadocarrito = []
    ValorTodo = 0

    if request.user.is_authenticated:
        user_id = request.user.id
        carrito = Carrito.objects.filter(Usuario=user_id)

        for carro in carrito:
            idcarrito = carro.id
            Cantidadventa = carro.Productos.ValorVenta
            Cantidad = carro.Cantidad
            CantidadTotal = Cantidadventa * Cantidad
            ValorTodo += CantidadTotal
            Nombre = carro.Productos.Nombre
            fabricante = carro.Productos.Fabricante.Nombre
            listadocarrito.append({
                'idCarrito': idcarrito,
                'Nombre': Nombre,
                'ValorUnitario': Cantidadventa,
                'ValorTotal': CantidadTotal,
                'Cantidad': Cantidad,
                'NombreFabricante': fabricante
            })


        if request.method == 'POST' and request.headers.get('x-requested-with') == 'XMLHttpRequest':
            carrito_id = request.POST.get('id')
            try:
                carrito = Carrito.objects.get(id=carrito_id, Usuario=request.user)
            except Carrito.DoesNotExist:
                return JsonResponse({'status': 'error', 'message': 'No encontrado'}, status=404)

            producto = carrito.Productos

            if request.user.id == 1:
                if request.POST.get('mas'):
                    producto.Cantidad += 1  
                    producto.save()
                    return JsonResponse({'status': 'stock_added', 'nuevo_stock': producto.Cantidad})

                elif request.POST.get('menos'):
                    if producto.Cantidad > 0:
                        producto.Cantidad -= 1
                        producto.save()
                        return JsonResponse({'status': 'stock_removed', 'nuevo_stock': producto.Cantidad})
                    else:
                        return JsonResponse({'status': 'no_stock'})

                elif request.POST.get('borrar'):
                    carrito.delete()
                    return JsonResponse({'status': 'deleted'})

            else:
                if request.POST.get('menos'):
                    if carrito.Cantidad == 1:
                        carrito.delete()
                        return JsonResponse({'status': 'deleted'})
                    else:
                        carrito.Cantidad -= 1
                        carrito.save()
                        return JsonResponse({'status': 'updated', 'cantidad': carrito.Cantidad})
                
                elif request.POST.get('mas'):
                    if carrito.Cantidad < producto.Cantidad:
                        carrito.Cantidad += 1
                        carrito.save()
                        return JsonResponse({'status': 'updated', 'cantidad': carrito.Cantidad})
                    else:
                        return JsonResponse({'status': 'limit'})
                
                elif request.POST.get('borrar'):
                    carrito.delete()
                    return JsonResponse({'status': 'deleted'})

            return JsonResponse({'status': 'error'})

    return render(request, "carrito.html", {'listadocarrito': listadocarrito, 'ValorTodo': ValorTodo})

@user_passes_test(auth, login_url='inicio')
def GenerarPedido(request):
    if request.user.is_authenticated:
        carrito=Carrito.objects.filter(Usuario=request.user)
        if request.method == 'POST':
            if request.user.rol.Nombre =="Cliente":
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
                        producto= Productos.objects.get(id=carro.Productos.id)
                        producto.Cantidad-= carro.Cantidad
                        producto.save()
                        carro.delete()
                        
                    return redirect('/Pedidos/')
            else:
                if request.POST.get('ValorTotal'):
                    encargo=RegistroEncargo(
                        Fecha=timezone.now(),
                        Valor=request.POST.get('ValorTotal'),
                        Usuario=request.user,
                    )
                    encargo.save()
                    for carro in carrito:
                        Cantidadencargo=CantidadEncargo(
                            Productos=carro.Productos,
                            RegistroEncargo=encargo,
                            Cantidad=carro.Cantidad
                        )
                        Cantidadencargo.save()
                        producto= Productos.objects.get(id=carro.Productos.id)
                        producto.Cantidad+= carro.Cantidad
                        producto.save()
                        carro.delete()
                    
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

@user_passes_test(auth, login_url='inicio')
def Pedidos(request):
    # Admin ve todos los pedidos, usuario normal solo los suyos
    if request.user.rol.Nombre=="Administrador":
        pedidos = RegistroPedido.objects.prefetch_related('CantidadPedido__Productos').all().order_by('-Fecha')
    else:
        pedidos = RegistroPedido.objects.prefetch_related('CantidadPedido__Productos').filter(Usuario=request.user).order_by('-Fecha')

    if request.method == 'POST' and request.user.rol.Nombre == "Administrador":
        pedido_id = request.POST.get('id')
        pedido = get_object_or_404(RegistroPedido, id=pedido_id)

        if 'aceptar' in request.POST:
            pedido.Estado = 'atendido'
            pedido.save()
        elif 'rechazar' in request.POST:
            CantidadPedido.objects.filter(RegistroPedido=pedido).delete()
            pedido.delete()

        return redirect('/Pedidos')

    return render(request, 'pedidos/pedidos.html', {'lista_pedidos': pedidos})

@user_passes_test(auth, login_url='inicio')
def pedidos_ajax(request):
    estado = request.GET.get('estado')

    # Admin ve todos, usuario solo los suyos
    if request.user.rol.Nombre == "Administrador":
        pedidos = RegistroPedido.objects.all().order_by('-Fecha')
    else:
        pedidos = RegistroPedido.objects.filter(Usuario=request.user).order_by('-Fecha')

    if estado in ['atendido', 'sin_atender']:
        pedidos = pedidos.filter(Estado=estado)

    return render(request, 'pedidos/_parcial_listado.html', {'lista_pedidos': pedidos})

@user_passes_test(es_admin, login_url="inicio")
def AgregarVenta(request, idPedido=None):
    ProductosTodos = Productos.objects.all()
    contexto = {'ProductosTodos': ProductosTodos}

    if idPedido:
        pedido = get_object_or_404(
            RegistroPedido.objects.prefetch_related('CantidadPedido__Productos'),
            id=idPedido
        )

        # Calcula el total por producto
        for item in pedido.CantidadPedido.all():
            item.total = item.Productos.ValorVenta * item.Cantidad

        contexto['pedido'] = pedido

    return render(request, 'Ventas/AgregarVentas.html', contexto)
