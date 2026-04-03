from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin


class Rol(models.Model):
    Nombre = models.CharField(max_length=15)

    class Meta:
        db_table = 'rol'

    def __str__(self):
        return self.Nombre


class UsuarioManager(BaseUserManager):
    def create_user(self, Correo, password=None, **extra_fields):
        if not Correo:
            raise ValueError('El usuario debe tener un correo electrónico')

        Correo = self.normalize_email(Correo)

        if not extra_fields.get('rol') and not extra_fields.get('rol_id'):
            rol_cliente, _ = Rol.objects.get_or_create(Nombre='Cliente')
            extra_fields['rol'] = rol_cliente

        user = self.model(Correo=Correo, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, Correo, password=None, **extra_fields):
        rol_admin, _ = Rol.objects.get_or_create(Nombre='Administrador')
        extra_fields.setdefault('rol', rol_admin)
        extra_fields.setdefault('is_active', True)
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)

        if extra_fields.get('is_staff') is not True:
            raise ValueError('El superusuario debe tener is_staff=True.')
        if extra_fields.get('is_superuser') is not True:
            raise ValueError('El superusuario debe tener is_superuser=True.')

        return self.create_user(Correo, password, **extra_fields)


class Usuario(AbstractBaseUser, PermissionsMixin):
    id = models.BigAutoField(primary_key=True)
    Documento = models.CharField(unique=True, max_length=12)
    Primer_nombre = models.CharField(max_length=30)
    Primer_apellido = models.CharField(max_length=30)
    Telefono = models.CharField(max_length=15)
    Correo = models.EmailField(unique=True)
    rol = models.ForeignKey(Rol, on_delete=models.CASCADE)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UsuarioManager()

    USERNAME_FIELD = 'Correo'
    REQUIRED_FIELDS = ['Primer_nombre', 'Primer_apellido']

    class Meta:
        db_table = 'usuario'

    def __str__(self):
        return self.Correo

    @property
    def es_administrador(self):
        return self.rol_id is not None and self.rol.Nombre == 'Administrador'

    @property
    def es_cliente(self):
        return self.rol_id is not None and self.rol.Nombre == 'Cliente'

    def save(self, *args, **kwargs):
        if self.is_superuser:
            self.is_staff = True
            if not self.rol_id:
                self.rol, _ = Rol.objects.get_or_create(Nombre='Administrador')
        elif self.rol_id:
            self.is_staff = self.rol.Nombre == 'Administrador'

        super().save(*args, **kwargs)
