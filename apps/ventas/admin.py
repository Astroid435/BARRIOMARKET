from django.contrib import admin
from .models import RegistroVenta, CantidadVenta, TiposMetodo, MetodosVenta

admin.site.register(RegistroVenta)
admin.site.register(CantidadVenta)
admin.site.register(TiposMetodo)
admin.site.register(MetodosVenta)
