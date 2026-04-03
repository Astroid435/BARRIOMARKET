from django.db import models
from apps.usuarios.models import Usuario
from apps.productos.models import Productos


class RegistroVenta(models.Model):
    id_ventas = models.AutoField(primary_key=True)
    Valor = models.IntegerField()
    ValorTotal = models.IntegerField()
    Fecha = models.DateTimeField()
    Usuario_DocumentoAdministrador = models.ForeignKey(
        Usuario, on_delete=models.CASCADE, related_name='ventas_admin'
    )
    DocumentoCliente = models.BigIntegerField()

    class Meta:
        db_table = 'registroventa'

    def __str__(self):
        return f"Venta #{self.id_ventas}"


class CantidadVenta(models.Model):
    id_cantidadventa = models.AutoField(primary_key=True)
    RegistroVenta = models.ForeignKey(RegistroVenta, on_delete=models.CASCADE)
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Cantidad = models.IntegerField()

    class Meta:
        db_table = 'cantidadventa'


class TiposMetodo(models.Model):
    Nombre = models.CharField(max_length=45)

    class Meta:
        db_table = 'tiposmetodo'

    def __str__(self):
        return self.Nombre


class MetodosVenta(models.Model):
    TiposMetodo = models.ForeignKey(TiposMetodo, on_delete=models.CASCADE)
    RegistroVenta = models.ForeignKey(RegistroVenta, on_delete=models.CASCADE)

    class Meta:
        db_table = 'metodosventa'
