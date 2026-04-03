from django.urls import path

from .views import (
    HomeView,
    CatalogoListView,
    RegistrosListView,
    ProductoCreateView,
    ProductoUpdateView,
    ProductoDeleteView,
    ProductoDetailView,
)

urlpatterns = [
    path('', HomeView.as_view(), name='inicio'),
    path('inicio', HomeView.as_view(), name='home'),
    path('productos/', CatalogoListView.as_view(), name='catalogo'),
    path('registros', RegistrosListView.as_view(), name='registros'),
    path('Productos/AgregarProductos', ProductoCreateView.as_view(), name='agregar_producto'),
    path('Productos/Actualizar/<str:idProducto>', ProductoUpdateView.as_view(), name='actualizar_producto'),
    path('Productos/borrar/<str:idProducto>', ProductoDeleteView.as_view(), name='borrar_producto'),
    path('Productos/VistaProducto/<str:idProducto>', ProductoDetailView.as_view(), name='detalle_producto'),
]
