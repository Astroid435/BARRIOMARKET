# Generated by Django 5.1.6 on 2025-05-07 14:21

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Usuario',
            fields=[
                ('password', models.CharField(max_length=128, verbose_name='password')),
                ('last_login', models.DateTimeField(blank=True, null=True, verbose_name='last login')),
                ('id', models.BigAutoField(primary_key=True, serialize=False)),
                ('Documento', models.CharField(max_length=12, unique=True)),
                ('Primer_nombre', models.CharField(max_length=30)),
                ('Primer_apellido', models.CharField(max_length=30)),
                ('Telefono', models.CharField(max_length=15)),
                ('Correo', models.EmailField(max_length=254, unique=True)),
            ],
            options={
                'db_table': 'usuario',
            },
        ),
        migrations.CreateModel(
            name='Categoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=45)),
            ],
            options={
                'db_table': 'categoria',
            },
        ),
        migrations.CreateModel(
            name='Fabricante',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=45)),
                ('Telefono', models.CharField(max_length=15)),
            ],
            options={
                'db_table': 'fabricante',
            },
        ),
        migrations.CreateModel(
            name='RegistroEncargo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Valor', models.IntegerField()),
                ('Fecha', models.DateTimeField()),
            ],
            options={
                'db_table': 'registroencargo',
            },
        ),
        migrations.CreateModel(
            name='RegistroFalta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('NombreProducto', models.CharField(max_length=45)),
                ('Contador', models.PositiveSmallIntegerField()),
            ],
            options={
                'db_table': 'registrofalta',
            },
        ),
        migrations.CreateModel(
            name='rol',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=15)),
            ],
            options={
                'db_table': 'rol',
            },
        ),
        migrations.CreateModel(
            name='TiposMetodo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=45)),
            ],
            options={
                'db_table': 'tiposmetodo',
            },
        ),
        migrations.CreateModel(
            name='Productos',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=45)),
                ('Cantidad', models.SmallIntegerField()),
                ('ValorCompra', models.IntegerField()),
                ('ValorVenta', models.IntegerField()),
                ('Descripcion', models.CharField(max_length=150)),
                ('imagen', models.ImageField(upload_to='productos/')),
                ('Fabricante', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.fabricante')),
            ],
            options={
                'db_table': 'productos',
            },
        ),
        migrations.CreateModel(
            name='Carrito',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Cantidad', models.IntegerField()),
                ('Usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('Productos', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.productos')),
            ],
            options={
                'db_table': 'carrito',
            },
        ),
        migrations.CreateModel(
            name='RegistroPedido',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Fecha', models.DateField()),
                ('ValorTotal', models.IntegerField()),
                ('Observaciones', models.CharField(max_length=200)),
                ('Estado', models.CharField(max_length=45)),
                ('Usuario', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'registropedido',
            },
        ),
        migrations.CreateModel(
            name='CantidadPedido',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Cantidad', models.SmallIntegerField()),
                ('Productos', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.productos')),
                ('RegistroPedido', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.registropedido')),
            ],
            options={
                'db_table': 'cantidadpedido',
            },
        ),
        migrations.CreateModel(
            name='RegistroVenta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Valor', models.IntegerField()),
                ('ValorTotal', models.IntegerField()),
                ('Fecha', models.DateTimeField()),
                ('DocumentoCliente', models.BigIntegerField()),
                ('Usuario_DocumentoAdministrador', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='ventas_admin', to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'registroventa',
            },
        ),
        migrations.CreateModel(
            name='CantidadVenta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Cantidad', models.IntegerField()),
                ('Productos', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.productos')),
                ('RegistroVenta', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.registroventa')),
            ],
            options={
                'db_table': 'cantidadventa',
            },
        ),
        migrations.CreateModel(
            name='CantidadEncargo',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Cantidad', models.IntegerField()),
                ('Productos', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.productos')),
                ('RegistroVenta', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.registroventa')),
            ],
            options={
                'db_table': 'cantidadencargo',
            },
        ),
        migrations.AddField(
            model_name='usuario',
            name='rol',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.rol'),
        ),
        migrations.CreateModel(
            name='Subcategoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Nombre', models.CharField(max_length=45)),
                ('Categoria', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.categoria')),
            ],
            options={
                'db_table': 'subcategoria',
            },
        ),
        migrations.CreateModel(
            name='MetodosVenta',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('RegistroVenta', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.registroventa')),
                ('TiposMetodo', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.tiposmetodo')),
            ],
            options={
                'db_table': 'metodosventa',
            },
        ),
        migrations.CreateModel(
            name='UsuarioProductoFaltante',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('DocumentoCliente', models.BigIntegerField()),
                ('Fecha', models.DateTimeField()),
                ('IdProductoFaltante', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.registrofalta')),
            ],
            options={
                'db_table': 'usuarioproductofaltante',
            },
        ),
        migrations.CreateModel(
            name='ProductosCategoria',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('Productos', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.productos')),
                ('Subcategoria', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='barriomarket.subcategoria')),
            ],
            options={
                'db_table': 'productoscategoria',
                'unique_together': {('Productos', 'Subcategoria')},
            },
        ),
    ]
