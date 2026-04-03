from django.contrib.auth.views import LogoutView
from django.urls import path

from .views import (
    AuthView,
    RegisterView,
    PerfilView,
    CustomLoginView,
    SolicitarCorreoView,
    SolicitarCodigoView,
    SolicitarContrasenaView,
)

urlpatterns = [
    path('auth/', AuthView.as_view(), name='auth'),
    path('registro', RegisterView.as_view(), name='registro'),
    path('login', CustomLoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(template_name='logout.html'), name='logout'),
    path('Perfil', PerfilView.as_view(), name='perfil'),
    path('CambioContrasena/Correo', SolicitarCorreoView.as_view(), name='password_reset'),
    path('CambioContrasena/Codigo', SolicitarCodigoView.as_view(), name='solicitar_codigo'),
    path('CambioContrasena/Cambio', SolicitarContrasenaView.as_view(), name='solicitar_contrasena'),
]
