# Barrio Market

Aplicación web construida con Django para la gestión de un marketplace con catálogo de productos, carrito, pedidos, ventas, compras, faltantes y administración de usuarios por roles.

## Tecnologías

- Python
- Django
- SQLite para desarrollo local
- MySQL opcional para entornos que lo requieran
- Pillow para manejo de imágenes
- Docker y Docker Compose

## Funcionalidades principales

- Autenticación con modelo de usuario personalizado
- Roles de usuario: Cliente y Administrador
- Catálogo público de productos
- Carrito de compras
- Gestión de pedidos y devoluciones
- Gestión de ventas
- Gestión de compras
- Registro de productos faltantes
- Panel administrativo de Django
- Páginas de error personalizadas 400, 403, 404 y 500

## Estructura del proyecto

```text
BARRIOMARKET/
├── apps/
│   ├── usuarios/
│   ├── productos/
│   ├── pedidos/
│   ├── ventas/
│   ├── compras/
│   └── faltantes/
├── barriomarket/
├── manage.py
├── requirements.txt
├── Dockerfile
└── docker-compose.yml
```

## Requisitos

- Python 3.11 o superior
- pip
- MySQL opcional si se desea usar esa base de datos en lugar de SQLite

## Instalación local

1. Clona el repositorio.
3. Instala las dependencias.
4. Ejecuta las migraciones.
5. Inicia el servidor.

```bash
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

La aplicación quedará disponible en:

```text
http://127.0.0.1:8000/
```

## Base de datos

El proyecto está configurado para usar SQLite por defecto en desarrollo local. Esto permite ejecutar el sistema sin necesidad de instalar MySQL.

Si deseas usar MySQL, configura las variables de entorno correspondientes y activa `USE_MYSQL=1`.

### Variables de entorno soportadas

```env
DJANGO_SECRET_KEY=tu_clave_secreta
DJANGO_DEBUG=True
USE_MYSQL=0
DB_NAME=barriomarket
DB_USER=root
DB_PASSWORD=
DB_HOST=localhost
DB_PORT=3306
EMAIL_USER=correo@example.com
EMAIL_PASSWORD=tu_password
```

## Crear un usuario administrador

El proyecto usa un modelo de usuario personalizado cuyo campo principal es `Correo`.

```bash
python manage.py createsuperuser
```

Después podrás ingresar al panel de administración en:

```text
http://127.0.0.1:8000/admin/
```

## Ejecución con Docker

El repositorio incluye un `Dockerfile` y un `docker-compose.yml` para levantar la aplicación web.

```bash
docker compose up --build
```

Por defecto el contenedor ejecuta:

```bash
python manage.py runserver 0.0.0.0:8000
```

Nota: el archivo `docker-compose.yml` actual levanta el servicio web. Si deseas correr MySQL en contenedores, debes agregar ese servicio o conectarte a una base de datos externa mediante variables de entorno.

## Aplicaciones Django

### `apps.usuarios`
Gestiona autenticación, registro, perfiles, recuperación de contraseña y roles.

### `apps.productos`
Gestiona catálogo, fabricantes, categorías, subcategorías y CRUD de productos.

### `apps.pedidos`
Gestiona carrito, pedidos, detalle de cantidades y devoluciones.

### `apps.ventas`
Gestiona el registro y detalle de ventas.

### `apps.compras`
Gestiona compras o encargos asociados al flujo administrativo.

### `apps.faltantes`
Permite registrar productos solicitados que no están disponibles.

## Archivos estáticos y multimedia

- Los archivos estáticos se sirven desde `barriomarket/public`
- Las imágenes de productos se almacenan en `barriomarket/public/image/Productos/productos`

## Comandos útiles

```bash
python manage.py makemigrations
python manage.py migrate
python manage.py check
python manage.py runserver
```

## Consideraciones

- El proyecto usa un modelo de usuario personalizado definido en `apps.usuarios.models.Usuario`.
- Para desarrollo local se recomienda mantener SQLite.
- Para producción se debe configurar correctamente `DJANGO_SECRET_KEY`, `DJANGO_DEBUG=False`, hosts permitidos y credenciales reales de correo/base de datos.

## Estado actual del proyecto

El proyecto fue reorganizado por apps siguiendo una separación modular de responsabilidades y vistas basadas en clases para los principales flujos del sistema.
