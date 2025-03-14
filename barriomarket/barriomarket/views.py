import json
import uuid
import random
import re  
from django.utils.timezone import now
from django.contrib.auth.models import User
from django.core.mail import send_mail
from django.conf import settings
from django.http import JsonResponse
from django.shortcuts import render,redirect
from django.db import connection
from .forms import MyUserCreationForm
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.views import LoginView
from .models import CantidadPedido, Productos,Categoria,ProductosCategoria, RegistroPedido,Subcategoria,Fabricante,Carrito,Usuario
from django.core.files.storage import FileSystemStorage

def home(request):
    listadoproductos = connection.cursor()
    listadocategorias = connection.cursor()
    listadocategoriasall = connection.cursor()
    listadoproductos.execute("SELECT * FROM productos LIMIT 6")
    listadocategorias.execute("SELECT * FROM categoria LIMIT 3")
    listadocategoriasall.execute("SELECT * FROM categoria")
    return render(request,'home.html',{'listadoproductos':listadoproductos, 'listadocategorias':listadocategorias, 'listadocategoriasall':listadocategoriasall})

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

def borrarproductos(request, idProducto):
    borrar=Productos.objects.get(id=idProducto)
    borrar.delete()
    return redirect("/registros")

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
    
    subcategorias=Subcategoria.objects.filter(Categoria_id=idCategoria)
    idproductos=[]
    for subcategoria in subcategorias:
      categoriasproducto = ProductosCategoria.objects.filter(Subcategoria_id=subcategoria.id)
      for productos in categoriasproducto:
        if not productos.Productos.id in idproductos:
          if producto.id in idproductos:
            idproductos.append(productos.Productos.id)
    
    for idproducto in idproductos:
      productos=Productos.objects.get(id=idproducto)
      listarelacionados.append({
              'idProducto': productos.id, 
              'Nombre': productos.Nombre,
              'Descripcion': productos.Descripcion,
              'ValorVenta': productos.ValorVenta,
              'Imagen': productos.imagen,
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
    
def borrarcarro(request, idCarro):
    borrar=Carrito.objects.get(id=idCarro)
    borrar.delete()
    return redirect("/Carrito")

def GenerarPedido(request):
    if request.user.is_authenticated:
        carrito=Carrito.objects.filter(Usuario=request.user)
        if request.method == 'POST':
            if request.POST.get('Observaciones') and request.POST.get('ValorTotal'):
                pedido=RegistroPedido(
                    Fecha=now(),
                    Observaciones=request.POST.get('Observaciones'),
                    ValorTotal=request.POST.get('ValorTotal'),
                    Usuario=request.user
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
                    
                return render(request, '/carrito.html')

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


