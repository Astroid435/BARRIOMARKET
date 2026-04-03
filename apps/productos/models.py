from django.db import models


class Fabricante(models.Model):
    Nombre = models.CharField(max_length=45)
    Telefono = models.CharField(max_length=15)

    class Meta:
        db_table = 'fabricante'

    def __str__(self):
        return self.Nombre


class Productos(models.Model):
    Nombre = models.CharField(max_length=45)
    Cantidad = models.SmallIntegerField()
    ValorCompra = models.IntegerField()
    ValorVenta = models.IntegerField()
    Descripcion = models.CharField(max_length=150)
    imagen = models.ImageField(upload_to='productos/')
    Fabricante = models.ForeignKey(Fabricante, on_delete=models.CASCADE)

    class Meta:
        db_table = 'productos'

    def __str__(self):
        return self.Nombre

    @property
    def categorias(self):
        return Categoria.objects.filter(
            subcategoria__productoscategoria__Productos=self
        ).first()


class Categoria(models.Model):
    Nombre = models.CharField(max_length=45)

    class Meta:
        db_table = 'categoria'

    def __str__(self):
        return self.Nombre

    def productos(self):
        return Productos.objects.filter(
            productoscategoria__Subcategoria__Categoria=self
        ).distinct()


class Subcategoria(models.Model):
    Nombre = models.CharField(max_length=45)
    Categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)

    class Meta:
        db_table = 'subcategoria'

    def __str__(self):
        return self.Nombre


class ProductosCategoria(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Subcategoria = models.ForeignKey(Subcategoria, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('Productos', 'Subcategoria')
        db_table = 'productoscategoria'
