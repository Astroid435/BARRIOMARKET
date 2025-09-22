"""
URL configuration for barriomarket project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from barriomarket.views import home,registros,AgregarProductos,borrarproductos,register,ActualizarProducto,VistaProducto,Vistacarrito,SolicutarCorreo, SolicitarCodigo,SolicitarContrasena, catalogo,Pedidos, Perfil, Añadirproducto
from django.contrib.auth.views import LogoutView
from .views import CustomLoginView, GenerarPedido, auth_view, pedidos_ajax, AgregarVenta

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',home),
    path('inicio',home, name='inicio'),
    path('registros', registros),
    path('Carrito', Vistacarrito, name="carrito"),
    path('Perfil', Perfil),
    path('GenerarPedido', GenerarPedido),
    path('registro',register, name="registro"),
    path('auth/', auth_view, name='auth'),
    path('login', CustomLoginView.as_view(template_name='login.html'), name="login"),
    path('logout/', LogoutView.as_view(template_name='logout.html'), name='logout'),
    path('Productos/AgregarProductos', AgregarProductos),
    path('Productos/VistaProducto/<str:idProducto>', VistaProducto, name='detalle_producto'),
    path('Productos/borrar/<str:idProducto>', borrarproductos),
    path('Productos/Actualizar/<str:idProducto>', ActualizarProducto),
    path('productos/', catalogo, name='catalogo'),
    path('CambioContrasena/Correo', SolicutarCorreo, name='password_reset'),
    path('CambioContrasena/Codigo', SolicitarCodigo),
    path('CambioContrasena/Cambio', SolicitarContrasena),
    path('Pedidos/', Pedidos, name='listado_pedidos'),
    path('pedidos/ajax/', pedidos_ajax, name='ajax_pedidos'),
    path('Ventas/AgregarVentas/', AgregarVenta, name="AgregarVenta"),
    path('Ventas/AgregarVentas/<str:idPedido>', AgregarVenta, name="AgregarVentaLink"),
    path('Ventas/añadirproducto', Añadirproducto, name="añadirproducto"),


] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
