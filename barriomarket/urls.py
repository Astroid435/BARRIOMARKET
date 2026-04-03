"""
URL configuration for barriomarket project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.0/topics/http/urls/
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('apps.productos.urls')),
    path('', include('apps.usuarios.urls')),
    path('', include('apps.pedidos.urls')),
    path('', include('apps.ventas.urls')),
    path('', include('apps.compras.urls')),
    path('', include('apps.faltantes.urls')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

handler400 = 'barriomarket.error_views.bad_request'
handler403 = 'barriomarket.error_views.permission_denied'
handler404 = 'barriomarket.error_views.page_not_found'
handler500 = 'barriomarket.error_views.server_error'