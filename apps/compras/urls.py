from django.urls import path

from .views import CompraListView, ComprasAjaxView

urlpatterns = [
    path('Compras/', CompraListView.as_view(), name='compras'),
    path('Compras/ajax/', ComprasAjaxView.as_view(), name='ajax_compras'),
]
