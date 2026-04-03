from django.urls import path

from .views import (
    CarritoView,
    GenerarPedidoView,
    PedidoListView,
    PedidosAjaxView,
    CancelarPedidoView,
)

urlpatterns = [
    path('Carrito', CarritoView.as_view(), name='carrito'),
    path('GenerarPedido', GenerarPedidoView.as_view(), name='generar_pedido'),
    path('Pedidos/', PedidoListView.as_view(), name='listado_pedidos'),
    path('pedidos/ajax/', PedidosAjaxView.as_view(), name='ajax_pedidos'),
    path('cancelar_pedido/', CancelarPedidoView.as_view(), name='cancelar_pedido'),
]
