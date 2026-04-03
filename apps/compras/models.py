from django.db import models
from apps.usuarios.models import Usuario
from apps.productos.models import Productos


class RegistroEncargo(models.Model):
    Valor = models.IntegerField()
    Fecha = models.DateTimeField()
    Usuario = models.ForeignKey(
        Usuario, on_delete=models.CASCADE, db_column='Usuario_id'
    )

    class Meta:
        db_table = 'registroencargo'

    def __str__(self):
        return f"Encargo #{self.id} - {self.Fecha}"


class CantidadEncargo(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    RegistroEncargo = models.ForeignKey(
        RegistroEncargo, related_name='CantidadEncargo', on_delete=models.CASCADE
    )
    Cantidad = models.SmallIntegerField()

    class Meta:
        db_table = 'cantidadencargo'
