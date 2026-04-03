from django.db import models
from apps.usuarios.models import Usuario
from apps.productos.models import Productos


class RegistroPedido(models.Model):
    Fecha = models.DateTimeField()
    ValorTotal = models.IntegerField()
    Observaciones = models.CharField(max_length=200)
    Usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    Estado = models.CharField(max_length=45)

    class Meta:
        db_table = 'registropedido'

    def __str__(self):
        return f"Pedido #{self.id} - {self.Usuario}"


class CantidadPedido(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    RegistroPedido = models.ForeignKey(
        RegistroPedido, related_name='CantidadPedido', on_delete=models.CASCADE
    )
    Cantidad = models.SmallIntegerField()

    class Meta:
        db_table = 'cantidadpedido'


class Devolucion(models.Model):
    id_devolucion = models.AutoField(primary_key=True)
    pedido = models.ForeignKey(
        RegistroPedido, on_delete=models.SET_NULL, null=True, blank=True,
        db_column='pedido_id'
    )
    usuario = models.ForeignKey(
        Usuario, on_delete=models.CASCADE, db_column='usuario_id'
    )
    motivo = models.TextField()
    fecha_cancelacion = models.DateTimeField(auto_now_add=True)
    valor = models.IntegerField()

    class Meta:
        db_table = 'devoluciones'

    def __str__(self):
        return f"Devolución Pedido {self.pedido_id} - {self.usuario.Correo}"


class Carrito(models.Model):
    Cantidad = models.IntegerField()
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)

    class Meta:
        db_table = 'carrito'
