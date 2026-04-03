from django.db import migrations


def seed_roles_and_sync_users(apps, schema_editor):
    Rol = apps.get_model('usuarios', 'Rol')
    Usuario = apps.get_model('usuarios', 'Usuario')

    rol_cliente, _ = Rol.objects.get_or_create(Nombre='Cliente')
    rol_admin, _ = Rol.objects.get_or_create(Nombre='Administrador')

    for usuario in Usuario.objects.all():
        if usuario.is_superuser:
            if usuario.rol_id != rol_admin.id:
                usuario.rol_id = rol_admin.id
            usuario.is_staff = True
        else:
            if not usuario.rol_id:
                usuario.rol_id = rol_cliente.id
            if usuario.rol_id == rol_admin.id:
                usuario.is_staff = True
            else:
                usuario.is_staff = False
        usuario.save(update_fields=['rol', 'is_staff'])


def noop(apps, schema_editor):
    pass


class Migration(migrations.Migration):

    dependencies = [
        ('usuarios', '0002_usuario_groups_usuario_is_active_usuario_is_staff_and_more'),
    ]

    operations = [
        migrations.RunPython(seed_roles_and_sync_users, noop),
    ]
