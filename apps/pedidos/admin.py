from django.contrib import admin
from .models import RegistroPedido, CantidadPedido, Devolucion, Carrito

admin.site.register(RegistroPedido)
admin.site.register(CantidadPedido)
admin.site.register(Devolucion)
admin.site.register(Carrito)
