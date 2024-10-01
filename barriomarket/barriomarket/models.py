from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.db import models


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
    imagen = models.CharField(max_length=50)
    Fabricante = models.ForeignKey(Fabricante, on_delete=models.CASCADE)
    class Meta:
        db_table = 'productos'

class Categoria(models.Model):
    Nombre = models.CharField(max_length=45)
    class Meta:
        db_table = 'categoria'

class Subcategoria(models.Model):
    Nombre = models.CharField(max_length=45)
    Categoria = models.ForeignKey(Categoria, on_delete=models.CASCADE)
    class Meta:
        db_table = 'subcategoria'

class ProductosCategoria(models.Model):
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Subcategoria = models.ForeignKey(Subcategoria, on_delete=models.CASCADE)
    class Meta:
        db_table = 'productoscategoria'
        
class Carrito(models.Model):
    Cantidad= models.IntegerField()
    Productos = models.ForeignKey(Productos, on_delete=models.CASCADE)
    Usuario = models.ForeignKey(Usuario, on_delete=models.CASCADE)
    class Meta:
        db_table = 'carrito'
