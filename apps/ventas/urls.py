from django.urls import path

from .views import (
    VentaListView,
    VentaDetailView,
    VentaCreateView,
    VentaAjaxView,
    AñadirProductoView,
    AgregarProductoAVentaView,
)

urlpatterns = [
    path('Ventas/ListadoVentas/', VentaListView.as_view(), name='ListadoVenta'),
    path('Ventas/Detalle/<int:idVenta>/', VentaDetailView.as_view(), name='DetalleVenta'),
    path('Ventas/AgregarVentas/<int:idPedido>', VentaCreateView.as_view(), name='AgregarVenta'),
    path('Ventas/AgregarVentas/<int:idPedido>/ajax', VentaAjaxView.as_view(), name='AgregarVentaAjax'),
    path('Ventas/AgregarVentas/<str:idPedido>', VentaCreateView.as_view(), name='AgregarVentaLink'),
    path('Ventas/añadirproducto/<int:idPedido>/', AñadirProductoView.as_view(), name='añadirproducto'),
    path('Ventas/AgregarVenta/<int:idPedido>/Producto/<int:idProducto>/', AgregarProductoAVentaView.as_view(), name='AgregarProductoAVenta'),
]
