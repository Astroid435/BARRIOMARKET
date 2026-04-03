from django.db import models


class RegistroFalta(models.Model):
    NombreProducto = models.CharField(max_length=45)
    Contador = models.PositiveSmallIntegerField()

    class Meta:
        db_table = 'registrofalta'

    def __str__(self):
        return self.NombreProducto


class UsuarioProductoFaltante(models.Model):
    DocumentoCliente = models.BigIntegerField()
    IdProductoFaltante = models.ForeignKey(RegistroFalta, on_delete=models.CASCADE)
    Fecha = models.DateTimeField()

    class Meta:
        db_table = 'usuarioproductofaltante'
