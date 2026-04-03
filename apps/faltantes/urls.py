from django.urls import path

from .views import RegistrarFaltanteView, ListaFaltantesView

urlpatterns = [
    path('registrar_faltante/', RegistrarFaltanteView.as_view(), name='registrar_faltante'),
    path('lista_faltantes/', ListaFaltantesView.as_view(), name='lista_faltantes'),
]
