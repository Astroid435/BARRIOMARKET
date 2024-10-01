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
from barriomarket.views import home,registros,AgregarProductos,borrarproductos,register,ActualizarProducto,VistaProducto,Vistacarrito,borrarcarro
from django.contrib.auth.views import LogoutView
from .views import CustomLoginView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('',home),
    path('inicio',home),
    path('registros', registros),
    path('Carrito', Vistacarrito),
    path('Carrito/borrar/<str:idCarro>', borrarcarro),
    path('registro',register),
    path('login', CustomLoginView.as_view(template_name='login.html')),
    path('logout/', LogoutView.as_view(template_name='logout.html'), name='logout'),
    path('Productos/AgregarProductos', AgregarProductos),
    path('Productos/VistaProducto/<str:idProducto>', VistaProducto),
    path('Productos/borrar/<str:idProducto>', borrarproductos),
    path('Productos/Actualizar/<str:idProducto>', ActualizarProducto),

]
