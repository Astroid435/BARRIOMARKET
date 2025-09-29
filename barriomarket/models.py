from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

# -----------------------------------
# Gestión de usuarios y roles
# -----------------------------------

class rol(models.Model):
    Nombre = models.CharField(max_length=15)

    class Meta:
        db_table = 'rol'

class Admin(BaseUserManager):
    def create_user(self, Correo, Contraseña=None, **extra_fields):
        if not Correo:
            raise ValueError('El usuario debe tener un correo electrónico')
        Correo = self.normalize_email(Correo)
        user = self.model(Correo=Correo, **extra_fields)
        user.set_password(Contraseña)
        user.save(using=self._db)
        return user

    def create_superuser(self, Correo, Contraseña=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('El superusuario debe tener is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('El superusuario debe tener is_superuser=True.')

        return self.create_user(Correo, Contraseña, **extra_fields)

class Usuario(AbstractBaseUser):
    id = models.BigAutoField(primary_key=True)
    Documento = models.CharField(unique=True, max_length=12)
    Primer_nombre = models.CharField(max_length=30)
    Primer_apellido = models.CharField(max_length=30)
    Telefono = models.CharField(max_length=15)
    Correo = models.EmailField(unique=True)
    rol = models.ForeignKey(rol, on_delete=models.CASCADE)

    objects = Admin()

    USERNAME_FIELD = 'Correo'
    REQUIRED_FIELDS = ['Primer_nombre', 'Primer_apellido']

    class Meta:
        db_table = 'usuario'

    def __str__(self):
        return self.Correo

# -----------------------------------
# Productos, categorías y fabricantes
# -----------------------------------

class Fabricante(models.Model):
    Nombre = models.CharField(max_length=45)
    Telefono = models.CharField(max_length=15)

    class Meta:
        db_table = 'fabricante'

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
        
    @property
    def categorias(self):
        return Categoria.objects.filter(
            subcategoria__productoscategoria__Productos=self
        ).first()

class Categoria(models.Model):
    Nombre = models.CharField(max_length=45)

    class Meta:
        db_table = 'categoria'

    def productos(self):
        return Productos.objects.filter(
            productoscategoria__Subcategoria__Categoria=self
        ).distinct()

class Subcategoria(models.Model):
    Nombre = models.CharField(max_length=45)
    Categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)

    class Meta:
        db_table = 'subcategoria'

class ProductosCategoria(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Subcategoria = models.ForeignKey(Subcategoria, on_delete=models.CASCADE)

    class Meta:
        unique_together = ('Productos', 'Subcategoria')
        db_table = 'productoscategoria'

# -----------------------------------
# Pedidos, Carrito y Cantidades
# -----------------------------------


class RegistroPedido(models.Model):
    Fecha = models.DateTimeField()
    ValorTotal = models.IntegerField()
    Observaciones = models.CharField(max_length=200)
    Usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    Estado= models.CharField(max_length=45)

    class Meta:
        db_table = 'registropedido'

class Devolucion(models.Model):
    id_devolucion = models.AutoField(primary_key=True)
    pedido = models.ForeignKey(RegistroPedido, on_delete=models.CASCADE, related_name="devoluciones")
    usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)  # quién canceló
    motivo = models.TextField()
    fecha_cancelacion = models.DateTimeField(auto_now_add=True)
    valor = models.IntegerField()  # copia del valor del pedido cancelado

    class Meta:
        db_table = "devoluciones"

    def __str__(self):
        return f"Devolución Pedido {self.pedido.id} - {self.usuario.Correo}"

class CantidadPedido(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    RegistroPedido = models.ForeignKey(RegistroPedido, related_name='CantidadPedido', on_delete=models.CASCADE)
    Cantidad = models.SmallIntegerField()

    class Meta:
        db_table = 'cantidadpedido'

class Carrito(models.Model):
    Cantidad = models.IntegerField()
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)

    class Meta:
        db_table = 'carrito'

# -----------------------------------
# Ventas, Métodos y Faltantes
# -----------------------------------

class RegistroVenta(models.Model):
    id_ventas = models.AutoField(primary_key=True)  # clave primaria real
    Valor = models.IntegerField()
    ValorTotal = models.IntegerField()
    Fecha = models.DateTimeField()
    Usuario_DocumentoAdministrador = models.ForeignKey(Usuario, on_delete=models.CASCADE, related_name='ventas_admin')
    DocumentoCliente = models.BigIntegerField()

    class Meta:
        db_table = 'registroventa'

class CantidadEncargo(models.Model):
    RegistroVenta = models.ForeignKey(RegistroVenta, on_delete=models.CASCADE)
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Cantidad = models.IntegerField()

    class Meta:
        db_table = 'cantidadencargo'

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

class MetodosVenta(models.Model):
    TiposMetodo = models.ForeignKey(TiposMetodo, on_delete=models.CASCADE)
    RegistroVenta = models.ForeignKey(RegistroVenta, on_delete=models.CASCADE)

    class Meta:
        db_table = 'metodosventa'

class RegistroEncargo(models.Model):
    Valor = models.IntegerField()
    Fecha = models.DateTimeField()

    class Meta:
        db_table = 'registroencargo'

class RegistroFalta(models.Model):
    NombreProducto = models.CharField(max_length=45)
    Contador = models.PositiveSmallIntegerField()

    class Meta:
        db_table = 'registrofalta'

class UsuarioProductoFaltante(models.Model):
    DocumentoCliente = models.BigIntegerField()
    IdProductoFaltante = models.ForeignKey(RegistroFalta, on_delete=models.CASCADE)
    Fecha = models.DateTimeField()

    class Meta:
        db_table = 'usuarioproductofaltante'
