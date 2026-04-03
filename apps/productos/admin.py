from django.contrib import admin
from .models import Productos, Categoria, Subcategoria, ProductosCategoria, Fabricante

admin.site.register(Productos)
admin.site.register(Categoria)
admin.site.register(Subcategoria)
admin.site.register(ProductosCategoria)
admin.site.register(Fabricante)
