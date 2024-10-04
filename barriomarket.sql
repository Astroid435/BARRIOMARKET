-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 04-10-2024 a las 13:45:15
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `barriomarket`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarProducto` (IN `nombre` VARCHAR(45), IN `cantidad` SMALLINT(3), IN `compra` INT(7), IN `venta` INT(7), IN `descripcion` VARCHAR(150), IN `imagen` VARCHAR(50), IN `fabricante` TINYINT(3))   begin

INSERT INTO `productos` (`Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_idFabricante`) VALUES (nombre, cantidad, compra, venta, descripcion, NULL, fabricante);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `AgregarSubcategorias` (IN `producto` SMALLINT(4), IN `subcategoria` TINYINT(3))   begin

INSERT INTO `productoscategoria` (`Productos_idProductos`, `Subcategoria_idSubcategoria`) VALUES (producto, subcategoria);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarProducto` (IN `producto` SMALLINT(4))   begin

delete from productoscategoria where Productos_idProductos = producto;
delete from productos where idProductos = producto;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ConsultarProducto` (IN `producto` SMALLINT(4))   begin

SELECT * FROM productos where idProductos = producto;

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarCategoria` (IN `nombre` VARCHAR(45))   begin

INSERT INTO categoria (Nombre) VALUES (nombre);

end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarFabricante` (IN `nombre` VARCHAR(45), IN `telefono` VARCHAR(15))   begin

INSERT INTO fabricante (Nombre, Telefono) VALUES (nombre,telefono);

end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add rol', 1, 'add_rol'),
(2, 'Can change rol', 1, 'change_rol'),
(3, 'Can delete rol', 1, 'delete_rol'),
(4, 'Can view rol', 1, 'view_rol'),
(5, 'Can add usuario', 2, 'add_usuario'),
(6, 'Can change usuario', 2, 'change_usuario'),
(7, 'Can delete usuario', 2, 'delete_usuario'),
(8, 'Can view usuario', 2, 'view_usuario'),
(9, 'Can add fabricante', 3, 'add_fabricante'),
(10, 'Can change fabricante', 3, 'change_fabricante'),
(11, 'Can delete fabricante', 3, 'delete_fabricante'),
(12, 'Can view fabricante', 3, 'view_fabricante'),
(13, 'Can add productos', 4, 'add_productos'),
(14, 'Can change productos', 4, 'change_productos'),
(15, 'Can delete productos', 4, 'delete_productos'),
(16, 'Can view productos', 4, 'view_productos'),
(17, 'Can add categoria', 5, 'add_categoria'),
(18, 'Can change categoria', 5, 'change_categoria'),
(19, 'Can delete categoria', 5, 'delete_categoria'),
(20, 'Can view categoria', 5, 'view_categoria'),
(21, 'Can add subcategoria', 6, 'add_subcategoria'),
(22, 'Can change subcategoria', 6, 'change_subcategoria'),
(23, 'Can delete subcategoria', 6, 'delete_subcategoria'),
(24, 'Can view subcategoria', 6, 'view_subcategoria'),
(25, 'Can add productos categoria', 7, 'add_productoscategoria'),
(26, 'Can change productos categoria', 7, 'change_productoscategoria'),
(27, 'Can delete productos categoria', 7, 'delete_productoscategoria'),
(28, 'Can view productos categoria', 7, 'view_productoscategoria'),
(29, 'Can add log entry', 8, 'add_logentry'),
(30, 'Can change log entry', 8, 'change_logentry'),
(31, 'Can delete log entry', 8, 'delete_logentry'),
(32, 'Can view log entry', 8, 'view_logentry'),
(33, 'Can add permission', 9, 'add_permission'),
(34, 'Can change permission', 9, 'change_permission'),
(35, 'Can delete permission', 9, 'delete_permission'),
(36, 'Can view permission', 9, 'view_permission'),
(37, 'Can add group', 10, 'add_group'),
(38, 'Can change group', 10, 'change_group'),
(39, 'Can delete group', 10, 'delete_group'),
(40, 'Can view group', 10, 'view_group'),
(41, 'Can add content type', 11, 'add_contenttype'),
(42, 'Can change content type', 11, 'change_contenttype'),
(43, 'Can delete content type', 11, 'delete_contenttype'),
(44, 'Can view content type', 11, 'view_contenttype'),
(45, 'Can add session', 12, 'add_session'),
(46, 'Can change session', 12, 'change_session'),
(47, 'Can delete session', 12, 'delete_session'),
(48, 'Can view session', 12, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadencargo`
--

CREATE TABLE `cantidadencargo` (
  `RegistroVenta_idRegistroVenta` smallint NOT NULL,
  `Productos_idProductos` smallint NOT NULL,
  `Cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadpedido`
--

CREATE TABLE `cantidadpedido` (
  `Productos_idProductos` smallint NOT NULL,
  `RegistroPedido_idRegistroPedido` int NOT NULL,
  `Cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadventa`
--

CREATE TABLE `cantidadventa` (
  `RegistroVenta_idRegistroVenta` smallint NOT NULL,
  `Productos_idProductos` smallint NOT NULL,
  `Cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `carrito`
--

CREATE TABLE `carrito` (
  `id` int NOT NULL,
  `cantidad` int NOT NULL,
  `productos_id` smallint NOT NULL,
  `usuario_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`id`, `Nombre`) VALUES
(1, 'Lapiceros'),
(2, 'pepe'),
(3, 'Aseo'),
(4, 'Pepe ganga');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(8, 'admin', 'logentry'),
(10, 'auth', 'group'),
(9, 'auth', 'permission'),
(5, 'barriomarket', 'categoria'),
(3, 'barriomarket', 'fabricante'),
(4, 'barriomarket', 'productos'),
(7, 'barriomarket', 'productoscategoria'),
(1, 'barriomarket', 'rol'),
(6, 'barriomarket', 'subcategoria'),
(2, 'barriomarket', 'usuario'),
(11, 'contenttypes', 'contenttype'),
(12, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-08-26 18:10:49.444995'),
(2, 'admin', '0001_initial', '2024-08-26 18:10:49.913140'),
(3, 'admin', '0002_logentry_remove_auto_add', '2024-08-26 18:10:49.937270'),
(4, 'admin', '0003_logentry_add_action_flag_choices', '2024-08-26 18:10:49.960513'),
(5, 'contenttypes', '0002_remove_content_type_name', '2024-08-26 18:10:50.111556'),
(6, 'auth', '0001_initial', '2024-08-26 18:10:50.969735'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-08-26 18:10:51.097344'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-08-26 18:10:51.120793'),
(9, 'auth', '0004_alter_user_username_opts', '2024-08-26 18:10:51.135111'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-08-26 18:10:51.223264'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-08-26 18:10:51.243694'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-08-26 18:10:51.262677'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-08-26 18:10:51.286869'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-08-26 18:10:51.301170'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-08-26 18:10:51.368232'),
(16, 'auth', '0011_update_proxy_permissions', '2024-08-26 18:10:51.387847'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-08-26 18:10:51.411814'),
(18, 'sessions', '0001_initial', '2024-08-26 18:10:51.602599');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0kimm3b8qt5kl04vrs9k422epo79irpd', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1siugx:gWOwNrwLDu9kuGzPRPo-oLiN6OYLClfd-7eU6hb3mOY', '2024-08-27 12:08:55.193733'),
('1136032cy7m10f3fgez52fa2ncniygwl', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqAAT:Z9ksAg94VvzF4tG6YZXNrqnVjB4hsNmUXnJ7ShpRWgM', '2024-09-16 12:05:21.521170'),
('1bl4cvqm1peeq5cw6swq1zifgh8gu1ms', '.eJxVjEEOwiAURO_C2hChUsCle09gTPP_B1rU0AToynh3qWmMLufNzHuyAZY6DUvxeYiOHZlku1-GQHef1sLdII0zpznVHJGvE761hZ9n5x-nbfsnmKBM7a2tR6O6TgKgQrCBrOg17VEZ70h3QE4LqXxQThk89ELLPlgkqZ2R2uomDYA5EqTqm080QFD9OOcIWy4LflFhx8sHSnZ9vQEIQEn-:1sqBDd:P0tDVVDp6lsN4Vflt1mreUqJKUuKooYjkNkw7rdzBWQ', '2024-09-16 13:12:41.864793'),
('1g1zoas8ef7cib3ghtd1k2910tdyufb7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svcXs:3-gH9a4SUvpERykwDsEIjETFcF-JQSA9WMd6GTnUUJ0', '2024-10-01 13:24:04.835786'),
('2m9s756ctvptm7jhzvfb3xi4ks97gxpv', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svdyb:yNdDYkPMzgcV2GnAfbw5_ctHIh8gE1sjSmOqTjwEkp8', '2024-10-01 14:55:45.666666'),
('3pt9mo7nbxq6fvn8c0gamcya8qgvce2q', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swgF1:xkMUtoltRphUlUXzTgbvFlQ5ZwhPyUyieKJ-zn7XlsY', '2024-10-04 11:32:59.199791'),
('482r7myo2lracy517y9d5khx2prgz99o', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sttDS:tlQUkH00zCrr58VOE6wB_Am8QMUsXcq1mckLedYURUA', '2024-09-26 18:47:50.077802'),
('548fuhn18njx1n0dra69yvv8gih63kbc', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stvMe:n7rxy1jXGRwfFF3Bl-qPjgef-eG_sKE7prn-xdC9PZM', '2024-09-26 21:05:28.420998'),
('5ctp2ynp5f7uzamhhon7brwni3zswod9', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqXXv:Mi8kTDf3tOq-A63CmI1q6iTjnbhT0jr8AK-S3C4Crt4', '2024-09-17 13:03:07.324196'),
('5fho327nmxkx95ybdfidcvwbrf9xwl3w', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqaaJ:OuSF38UvogQKvJ3chgzgQJd7LGqGC3qbST1Zk0s4VzQ', '2024-09-17 16:17:47.280916'),
('79tfh9d1lqvsj6eb5o1fx9jalf6f67ds', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svb2V:mxUFnhak9tVlJZUr28ChO8otMFTgZcUHLYqlHtMhxZI', '2024-10-01 11:47:35.108044'),
('7qm2n2bu3c7pwk08d0hmtqk6fu51pvnj', '.eJxVjMsOgjAUBf-la9PYYrmtS_d8A7mvCmpKQmFl_HchYaHbM3PmbXpcl6Ffq879KOZqvDn9boT81LIDeWC5T5ansswj2V2xB622m0Rft8P9CwxYh-0NSSmGpvGIFAhT5uRa4DOFqMLQIAs4HzQHCZEurQPf5kTsQaKHBFs0I80jY1l06znz-QLh_j1L:1suFyG:2xZ4lmemC03rMuYadwGS2pwfLsfYu4qqyEE0I_3frHQ', '2024-09-27 19:05:40.990022'),
('8pqu6c17uyouxckbj1ffqoi5q8ak6nyc', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuX9:OnE8izCDYHsyaiEUWiNVQrf9dH52w9ZEprfDczYCu4o', '2024-09-26 20:12:15.784747'),
('8zo75xgq07ceolf0e0buyxfugl8focld', '.eJxVjMEOgjAQRP9lz6SRQtmWo3e_wBiyu22haiChcDL-u5AQo8eZ92ZeEInnJDQuAVqooQChJfTTnGjLest55W-Vob0Cwq2AjtZl6NYc5i75w_zpmOQRxh34O439pGQalzmx2hV10Kwukw_P8-H-HQyUh22NLrA1VaWJ2DC5KK5sUE5sbPCCFYnHUpsQjTeW66ZE3UTHotFbjQ7h_QF8MElm:1svfAt:d37Ny3iuI78TLeWfCSdL5-EYay_XwbyxMmLaWjTKjGU', '2024-10-01 16:12:31.297937'),
('a40z7q6jk2s0fmyogfqqq5g7mr3dw7u9', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stYfF:R-14hK3q_vw4Z9oogAM-5LsoyMkDfuwj6Yu5tt7lapk', '2024-09-25 20:51:09.725359'),
('aoeliesf40v1vap6azq3uj4j4efq7x0p', '.eJxVjkEOwiAQRe_C2hAL0gGX7j2BMc3MQFvUlAToynh3W9MYXf733_zMU3Q417GbS8hd9OIolNj9MkK-h2kt_A2nIUlOU82R5KrIrS3ynHx4nDb3b2DEMi7X4AJZo7VCJEPoenZNC7wnY4Nn0MgeGmVCb7yxdGgbUG3viBV4q8DBMtoj5cg41bC9yVjDkHLEJTdLLjN9URHHyweuohbX1xsv9Eqi:1swNSH:3GrSt67PjMBm2wZN7058E-sBrvcA_HAiQaOA37ivYY4', '2024-10-03 15:29:25.715370'),
('aym074x633eillipqdt4qx3svia88ta4', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1suFSQ:HQyHH9rLYK1XXJK8U31NQ0lq3Mt7Pwaj3d6RpRSke_M', '2024-09-27 18:32:46.201243'),
('bd7xoyxli07ldn6dfrae4vzq8w4p9n38', 'e30:1sieEY:ei4N5mtVGxCymIdcm2K2uX8oj32lYtlSKnqrhN4gdQ8', '2024-08-26 18:34:30.372352'),
('c4ojnna20h0q5tl1w0c5s5274nrm3bw2', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sveof:cxx-YZRieGTvJLTSeYp37muDMsWKu5k6jb-PMAXgNi0', '2024-10-01 15:49:33.331319'),
('dx4zjoe7ffa36tz5ed55hwciifo7ji8y', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sixVM:EUE-lF_gab_GVmFyKNWINz1l8qz2AKxi9-baSIa94Dg', '2024-08-27 15:09:08.870309'),
('ej96s1jjm3lpgxuho9bkvfbfjhplidaj', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sjg84:u4ILqPwaXIR5fWprZt0q0BbD0h1BRKB_FUmYNxQLs7M', '2024-08-29 14:48:04.960316'),
('h10mlwkcyryiuibtcrsvcspw19oaubyv', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sveU2:Kg9DHiXFsk3SCaNmo2HShiK5vaFMKEfuqCcKOxwBXvg', '2024-10-01 15:28:14.807689'),
('hua0lmxvsr9mopi7afoscyydsyh1m1fd', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swL4d:S3g2dcrrvJBk91rVHWCjjq9Hb6B4AkPFE4U9QuGBQYs', '2024-10-03 12:56:51.003930'),
('kapu83jeoo28awgelv3o92w1nqjd9osj', '.eJxVjsEKwjAQRP8lZykmNd2mR-9-gUjZ3SRtVRJI0pP476ZQRK9vZh7zEiOuZR7X7NK4WDEIJQ6_jJAfLmyBvWOYYsMxlLRQs1WaPc3NJVr3PO_dP8GMea5rMI563bYKkTSh8WxkB3wk3TvL0CJbkEo7r63u6dRJUJ03xApsr8BAlXqktDCG4qpPVsBY3BTTgvvtvNIXZTFcBYjb-wPja0lj:1sttrK:22ieyUj7jQtLhVATzJnrPaiVGlnfucmxnew722-ukng', '2024-09-26 19:29:02.061633'),
('kvt5rvrn300mkk235kfq4wp21ue4lhrp', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuCm:yjFpWo_pYNuqUNExUkEM-vNI6-HEDfgCYQMrilQ3OrU', '2024-09-26 19:51:12.918799'),
('l70lp4ytj5cfyr9yuapza6ta2dd73ynh', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sjdzm:RbX1eG_L444LSNCn8XzTZIJdrFQo7_uAkTNgDKzEHmQ', '2024-08-29 12:31:22.838457'),
('ljhcklc5d4xljn08cpgxgn1szna4gi7m', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svdJm:uB0qEoQyWIT5MWjY1Fdbp-kmRkhNjrxRvga0Ewmfmb8', '2024-10-01 14:13:34.364134'),
('m4hx3fiofw62b9q2k5bb7yqgf8m8wgat', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sieFh:dVeJufb3T9FEoKFZo4K8ZOdHh3t8jPSnZNbVF7KLkEk', '2024-08-26 18:35:41.968810'),
('m6wzgcqbarv4akj39hsxkp2fwxt866qr', '.eJxVjEEOgjAQRe_StWlsoQxl6d4TGENmpgWqhia0rIx3txhidDGL__6f9xQ9rnnq1-SXPjjRCS0Ov4yQ737eCnfDeYyS45yXQHKbyL1N8hydf5z27Z9gwjSVb7CeWlNVGpEMoR3Yqgb4SKb1jqFCdqC08YNxpqW6UaCbwRJrcK0GC0U6IC2Bcc6--FQBjNmPcQm457TSFyXRXT6wLqfF9fUGL89Kog:1stY1I:pjL_W9_YYVUD0Q2mEhcteP6gsNfcgCMQJd4N86wUelw', '2024-09-25 20:09:52.594008'),
('n1i83nxavmyuvfasqhcyrx29lbzojev4', '.eJxVjMEOgjAQRP-lZ9NIoWzL0btfYAzZ3bZQNTRp4WT8d8EQo8d5M_OeosdlHvul-NxHJzqhxOGXEfLdT1vhbjgNSXKa5hxJbhO5t0Wek_OP0779E4xYxvUN1pPRda0QSRPawLZqgY-kjXcMNbKDSmkftNOGmrYC1QZLrMAZBRZWaUDKkXGa_eqrVsA4-yHliHsuC31REd3lAxtxfb0BCEhKAA:1ssmLa:OadHggjsABfBE0kF-WaJfsxZT4u1f9vHvZauhRyG1VY', '2024-09-23 17:15:38.734716'),
('o1a1mljrvlmv8zfd8rh3rk33r5ndepfo', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swLOX:MDgdU4F72JQpi0prb-Wv7YVgnRKTQLwDapzawcpZ1u0', '2024-10-03 13:17:25.031443'),
('o8gsi98r8c3n0kdgiuef1sgczo4c72d7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqZXk:f4RWC7FlpZsgnKF6iy6DqKx23ww65i3qsmqyUD0B8xo', '2024-09-17 15:11:04.695406'),
('ohl8l4tsquxig0ti90aimf864838wmqr', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sslY1:KSGNtg7n4LaF-zJb8axElq4pq1N5a-wTRQtK-N61_Y8', '2024-09-23 16:24:25.941973'),
('qb9rntlgfbsqk9izne48pqq9dwh1iaqb', '.eJxVj0EOwiAQRe_C2hCBUsCle09gTDMzQIuakhS6Mt5dmjRGl__9Py-ZFxtgrdOwlrAMybMTk-zwyxDoEeat8HeYx8wpz3VJyLcJ39vCL9mH53nf_gkmKFO7Ni6g1UpJANQILpITvaEjahs8GQXkjZA6RO21xa4XRvbRIUnjrTTONGkEXBLBXEPziQYIahjzkqDlruWy4hcVdroysT0jFLu9P5yISmU:1sqAeb:LtNmKGrSEpITs8j4u-xq68kGpiFonVht5AVYESqyf6U', '2024-09-16 12:36:29.892720'),
('qxu79sg6i9hmar1alzqmuqrepmak7bd0', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1suEyP:V62jG-EmtvqwIuYY-zTV5Rrh7vv9jDUYVgEMgT435lE', '2024-09-27 18:01:45.209939'),
('rggzx9n0zw57f55hpokhqdcnly0rgqx4', '.eJxVjEEOwiAURO_C2hCBUsCle09gTPP_B1rUlKTQlfHu0qQxupw3M-_FBljrNKwlLEPy7MQkO_wyBHqEeSv8HeYxc8pzXRLybcL3tvBL9uF53rd_ggnK1N7GBbRaKQmAGsFFcqI3dERtgyejgLwRUoeovbbY9cLIPjokabyVxpkmjYBLIphraL6uAYIaxrwk2HNZ8YsKO12ZUI0KyW7vD50aSmg:1sivlU:QKuJpw3dZBYKCUFqsHSN-vfCzoLeNEFoZVXf9r-Hqf0', '2024-08-27 13:17:40.580400'),
('rnq0uoqmhlbonw5phz2hfierjvb5luck', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svbXo:2kZIiPWjcO_1GRWpLp41Dsvzq3Lse-Y_bUPMM5UoUjA', '2024-10-01 12:19:56.987718'),
('rxtkz546j4cdv1l14e6zc7cno7coxe5a', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sttWy:7etwh3e8J3DmJW7bQnWbWM3PB6KemoW9KOZmrHUS_gs', '2024-09-26 19:08:00.008723'),
('svxnffdvwvysjl6e56wsvmwynjlzkq4y', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqgoz:RX_QVaalvskXa-fuwIzdcj8YlLiNdruzJABfCvLFxaI', '2024-09-17 22:57:21.277194'),
('szn1iu0jzeqnctz28orbelp180rtegp1', '.eJxVjk0OgjAQhe_StWmkUKZl6d4TGENmpi1UDU1aWBnvLhhidPm-95P3FD0u89gvxec-OtEJJQ6_jJDvftoMd8NpSJLTNOdIcovI3S3ynJx_nPbs38CIZVzbYD0ZXdcKkTShDWyrFvhI2njHUCM7qJT2QTttqGkrUG2wxAqcUWBhHQ1IOTJOs99vMs5-SDniqqtVl4W-qIju8oGNuL7eCHVKAQ:1sugwx:FgphNhCYQewSe7Y35cQ2oOLvggetFPSJtIcccxh4OOM', '2024-09-28 23:54:07.057590'),
('tu3ud5gvw4pae12f2sez7pk0ybu4638t', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqX97:LMHkrT5LXH6q6PmLmrjlil1ETwUtvUC6ewz2tVOYQG8', '2024-09-17 12:37:29.379974'),
('u2g580ksnkjixi9dl6tp5wffzopsfqrq', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stYKn:dndP9rEFYVf0VSt6MCtjN3L8WD7mpHPOfYInWEkAzY4', '2024-09-25 20:30:01.971544'),
('u84lcgtk6jpkjyveamxchg9bzpiiwdoz', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stsmI:gd8lok7-aol1lb-HgBcKDfuE9CMnK5t-ejZDEZdCGNo', '2024-09-26 18:19:46.604085'),
('v55mojr36d147grjplykh4rbeeo3vbus', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swNmH:PwwZRCsLttGvUj79CTpOr3-4PkW8nYE71h_hWXF3fzY', '2024-10-03 15:50:05.417242'),
('veeotlbjmbeh4p37hyh4f299al20lfdy', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1siszc:L4BvpaI2jyOzB3YKbDMwBR7vZ1RBsV7ZRemoxw5a2UI', '2024-08-27 10:20:04.069983'),
('w5v8pn790rx2d6c97yodyre8yo5kdjq6', '.eJxVjktqxDAMhu-SdTGxE0V2V6X7nsFItvJqEkPirErvPjYMQ7sTn_7XT-PpzrO_Lzn9Epv3xjRvfxlT-JajPuJKx5RUSEc-F1ZVop7fS32lKNvnU_svYKZrLm50wha6zhAxMLkxOD1gaBmsxIAdhYjagIwQwXI_aDTD6DgYjNagwxJ6yiXZh9JUZwL0Hbyo7LRsBa_3mli25D6mSsravWiqx09yyElZos_LXiJKg217q3FQrcZy_T4Ai9ZW8Q:1swiGm:YkKK-hOMDWRG3e5cwiiPC9Rms2RFo-A3iunBsS7bHCs', '2024-10-04 13:42:56.024615'),
('wrsu8w9zk2obshnt7gdwpish38kjmtf7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stsSq:P5i9LSsxqXv1TxKda-uWhvin1h96eBXtZr87Omd8S5g', '2024-09-26 17:59:40.038079'),
('xi3nohgok8gmv8ugsq371jp90j12mcl0', '.eJxVjDEOwjAQBP_iGlkO2L5ASZ83WHfeMwmgRIqTCvF3iJQC2p2ZfZnE69KnteqcBpiL8ebwuwnnh44bwJ3H22TzNC7zIHZT7E6r7Sbo87q7fwc91_5bM4K4EM5FcwHa2ChlRYlZJYLp5EhIvJTiScmDA2lLCMqEo4tozPsDMAw5mA:1sqBsv:sveKvDjIWcivs8P3Nqs8aI4eh4B2eij791LkPGk9IXY', '2024-09-16 13:55:21.684068'),
('y3ji89eeu4avdzhvm72sdazhcqoa5wsh', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuqZ:VTIt2TVk895p7B0SMffdWXlwnQC3Zp_MincIPzpb2vw', '2024-09-26 20:32:19.590082'),
('zmzm4iwvfsretsmyd8bwri8qlkcwwarb', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swKkO:hPuTiDrdwDan6HJdkfMyJAqH0gDT1_wKq1MINFahASE', '2024-10-03 12:35:56.760174'),
('zo2xl2z21u0mmx391o4sap5zgsl972vb', '.eJxVj0EOwiAQRe_C2hCBUsCle09gTDMzQIuakhS6Mt5dmjRGl__9Py-ZFxtgrdOwlrAMybMTk-zwyxDoEeat8HeYx8wpz3VJyLcJ39vCL9mH53nf_gkmKFO7Ni6g1UpJANQILpITvaEjahs8GQXkjZA6RO21xa4XRvbRIUnjrTTONGkEXBLBXEPziQYIahjzkqDlruWy4hcVdroysT0jFLu9P5yISmU:1sqhUs:RJTOUKVawNAIiqCVNzcuauAKDi_HrVyBSTacwxGTVtc', '2024-09-17 23:40:38.203905'),
('zxemrshn0m8vmsbuwtl4gx52g3wm6zes', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1soiXT:KsAfBR_t9y5InQxeu9nyIgRHZVaREdA0ypZ-anva540', '2024-09-12 12:23:07.613055');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fabricante`
--

CREATE TABLE `fabricante` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `fabricante`
--

INSERT INTO `fabricante` (`id`, `Nombre`, `Telefono`) VALUES
(1, 'Danielitos', '123123'),
(2, 'Matel', '1111'),
(3, 'Gomitas', '2222'),
(4, 'bombombun', '12222');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodosventa`
--

CREATE TABLE `metodosventa` (
  `TiposMetodo_idTiposMetodo` tinyint NOT NULL,
  `RegistroVenta_idRegistroVenta` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id` smallint NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Cantidad` smallint NOT NULL,
  `ValorCompra` int NOT NULL,
  `ValorVenta` int NOT NULL,
  `Descripcion` varchar(150) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `Fabricante_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_id`) VALUES
(39, '1', 123, 123, 123, 'utiles escolares*', '', 2),
(41, 'Empanada', 20, 35000, 60000, 'aksjdlajsldkahs dalkjsdhkajshd kashd k jashd kajsh dkjhaskjdh aksjdh kjas hdkjas hdkjash dkjhaskjdh akshd kjashdkas dk ahskjdhkajshd kash dkjahdkjashd', 'e0e8c1ef-52a4-40a3-b1db-b92332a55dce.jpg', 1),
(42, '1', 1, 1, 1, '1', '392c2597-cb79-4d62-9059-971eb46cb38e.jpg', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoscategoria`
--

CREATE TABLE `productoscategoria` (
  `id` int NOT NULL,
  `Productos_id` smallint NOT NULL,
  `Subcategoria_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `productoscategoria`
--

INSERT INTO `productoscategoria` (`id`, `Productos_id`, `Subcategoria_id`) VALUES
(19, 41, 7),
(20, 42, 1),
(21, 42, 4),
(25, 39, 1),
(26, 39, 2),
(27, 39, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroencargo`
--

CREATE TABLE `registroencargo` (
  `idRegistroEncargo` smallint NOT NULL,
  `Valor` int NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrofalta`
--

CREATE TABLE `registrofalta` (
  `idRegistroFalta` tinyint NOT NULL,
  `NombreProducto` varchar(45) NOT NULL,
  `Contador` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registropedido`
--

CREATE TABLE `registropedido` (
  `idRegistroPedido` int NOT NULL,
  `Fecha` datetime NOT NULL,
  `ValorTotal` int NOT NULL,
  `Observaciones` varchar(200) DEFAULT NULL,
  `Usuario_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroventa`
--

CREATE TABLE `registroventa` (
  `idRegistroVenta` smallint NOT NULL,
  `Valor` int NOT NULL,
  `ValorTotal` int NOT NULL,
  `Fecha` datetime NOT NULL,
  `Usuario_DocumentoAdministrador` bigint NOT NULL,
  `DocumentoCliente` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IdRol` tinyint NOT NULL,
  `Nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `rol`
--

INSERT INTO `rol` (`IdRol`, `Nombre`) VALUES
(2, 'Administrador'),
(1, 'Cliente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `subcategoria`
--

CREATE TABLE `subcategoria` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Categoria_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`id`, `Nombre`, `Categoria_id`) VALUES
(1, 'Retractil', 1),
(2, 'Redondo', 1),
(3, 'Negro', 1),
(4, 'Triangular', 1),
(6, '123', 1),
(7, '123111', 2),
(8, 'Limpieza', 3),
(9, 'Desinfeccion', 3),
(10, '22', 1),
(11, '3', 1),
(12, 'Libro', 4),
(13, 'Sacapunta', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdocumento`
--

CREATE TABLE `tiposdocumento` (
  `id` tinyint NOT NULL,
  `Sigla` varchar(4) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `tiposdocumento`
--

INSERT INTO `tiposdocumento` (`id`, `Sigla`, `Descripcion`) VALUES
(1, 'TI', 'Tarjeta de Identidad'),
(2, 'CC', 'Cedula de Ciudadanía');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposmetodo`
--

CREATE TABLE `tiposmetodo` (
  `idTiposMetodo` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` bigint NOT NULL,
  `Documento` bigint NOT NULL,
  `Primer_nombre` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Primer_apellido` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `rol_id` tinyint NOT NULL,
  `last_login` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `Documento`, `Primer_nombre`, `Primer_apellido`, `Telefono`, `Correo`, `password`, `rol_id`, `last_login`) VALUES
(2, 1011397031, 'juan', 'benitez', '3242974388', 'jujobelo9@gmail.com', 'pbkdf2_sha256$870000$bYkD1Dn4GMgJslIG6jzBas$WaxYVJOCVNoUzFoh93GI6gYlTWeX9zV27x9kxHs0gEg=', 2, '2024-10-04 13:03:55'),
(3, 222222, 'juan', 'es', '123123', 'juanes@gmail.com', 'pbkdf2_sha256$870000$J50QFKsEsJhgfRVKsucoER$4Pu/G6NY6DuMNLqKLiRCW8qWzOIeXuf+fvw3RKlrDIQ=', 1, '2024-08-27 14:38:42'),
(4, 1011397032, 'Astroid', '435', '3242974388', 'usuario@gmail.com', 'pbkdf2_sha256$870000$elTM5hva0mD4PhtZIwAKUT$bRDfixETPgvroetdihXczTl8PHPAv7MAVUsEab/krOg=', 1, '2024-09-16 13:35:22'),
(5, 1, '1', '1', '1', 'alanscg10@gmail.com', 'pbkdf2_sha256$870000$gwx7ooaKGkL2yly7R8SpRf$EFMy0BItwBeNGJkspIi0sfSne9WJ+qVgL5vsuPEK0p0=', 1, NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarioproductofaltante`
--

CREATE TABLE `usuarioproductofaltante` (
  `DocumentoCliente` bigint NOT NULL,
  `IdProductoFaltante` tinyint NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `cantidadencargo`
--
ALTER TABLE `cantidadencargo`
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_idProductos`),
  ADD KEY `fk_CantidadVenta_RegistroVenta10` (`RegistroVenta_idRegistroVenta`);

--
-- Indices de la tabla `cantidadpedido`
--
ALTER TABLE `cantidadpedido`
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_idProductos`),
  ADD KEY `fk_CantidadVenta_copy1_RegistroPedido1_idx` (`RegistroPedido_idRegistroPedido`);

--
-- Indices de la tabla `cantidadventa`
--
ALTER TABLE `cantidadventa`
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_idProductos`),
  ADD KEY `fk_CantidadVenta_RegistroVenta1` (`RegistroVenta_idRegistroVenta`);

--
-- Indices de la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_id` (`productos_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Telefono_UNIQUE` (`Telefono`);

--
-- Indices de la tabla `metodosventa`
--
ALTER TABLE `metodosventa`
  ADD KEY `fk_MetodosVenta_RegistroVenta1_idx` (`RegistroVenta_idRegistroVenta`),
  ADD KEY `fk_MetodosVenta_TiposMetodo1` (`TiposMetodo_idTiposMetodo`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`,`Fabricante_id`),
  ADD KEY `fk_Productos_Fabricante1_idx` (`Fabricante_id`);

--
-- Indices de la tabla `productoscategoria`
--
ALTER TABLE `productoscategoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Productos_has_Subcategoria_Subcategoria1_idx` (`Subcategoria_id`),
  ADD KEY `fk_Productos_has_Subcategoria_Productos1_idx` (`Productos_id`);

--
-- Indices de la tabla `registroencargo`
--
ALTER TABLE `registroencargo`
  ADD PRIMARY KEY (`idRegistroEncargo`);

--
-- Indices de la tabla `registrofalta`
--
ALTER TABLE `registrofalta`
  ADD PRIMARY KEY (`idRegistroFalta`);

--
-- Indices de la tabla `registropedido`
--
ALTER TABLE `registropedido`
  ADD PRIMARY KEY (`idRegistroPedido`,`Usuario_id`),
  ADD KEY `fk_RegistroPedido_Cliente1_idx` (`Usuario_id`) USING BTREE;

--
-- Indices de la tabla `registroventa`
--
ALTER TABLE `registroventa`
  ADD PRIMARY KEY (`idRegistroVenta`,`Usuario_DocumentoAdministrador`),
  ADD KEY `fk_RegistroVenta_Cliente1_idx` (`Usuario_DocumentoAdministrador`);

--
-- Indices de la tabla `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`IdRol`),
  ADD UNIQUE KEY `Descripcion_UNIQUE` (`Nombre`);

--
-- Indices de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`id`,`Categoria_id`),
  ADD KEY `fk_Subcategoria_Categoria1_idx` (`Categoria_id`);

--
-- Indices de la tabla `tiposdocumento`
--
ALTER TABLE `tiposdocumento`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Sigla_UNIQUE` (`Sigla`);

--
-- Indices de la tabla `tiposmetodo`
--
ALTER TABLE `tiposmetodo`
  ADD PRIMARY KEY (`idTiposMetodo`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_Usuario_Rol1_idx` (`rol_id`) USING BTREE;

--
-- Indices de la tabla `usuarioproductofaltante`
--
ALTER TABLE `usuarioproductofaltante`
  ADD KEY `fk_Usuario_has_RegistroFalta_RegistroFalta1_idx` (`IdProductoFaltante`),
  ADD KEY `fk_Usuario_has_RegistroFalta_Usuario1_idx` (`DocumentoCliente`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT de la tabla `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT de la tabla `productoscategoria`
--
ALTER TABLE `productoscategoria`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de la tabla `registroencargo`
--
ALTER TABLE `registroencargo`
  MODIFY `idRegistroEncargo` smallint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registrofalta`
--
ALTER TABLE `registrofalta`
  MODIFY `idRegistroFalta` tinyint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registropedido`
--
ALTER TABLE `registropedido`
  MODIFY `idRegistroPedido` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registroventa`
--
ALTER TABLE `registroventa`
  MODIFY `idRegistroVenta` smallint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `cantidadencargo`
--
ALTER TABLE `cantidadencargo`
  ADD CONSTRAINT `fk_CantidadVenta_Productos11` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_CantidadVenta_RegistroVenta10` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroencargo` (`idRegistroEncargo`);

--
-- Filtros para la tabla `cantidadpedido`
--
ALTER TABLE `cantidadpedido`
  ADD CONSTRAINT `fk_CantidadVenta_copy1_RegistroPedido1` FOREIGN KEY (`RegistroPedido_idRegistroPedido`) REFERENCES `registropedido` (`idRegistroPedido`),
  ADD CONSTRAINT `fk_CantidadVenta_Productos10` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `cantidadventa`
--
ALTER TABLE `cantidadventa`
  ADD CONSTRAINT `fk_CantidadVenta_Productos1` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_CantidadVenta_RegistroVenta1` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroventa` (`idRegistroVenta`);

--
-- Filtros para la tabla `carrito`
--
ALTER TABLE `carrito`
  ADD CONSTRAINT `carrito_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`),
  ADD CONSTRAINT `carrito_ibfk_2` FOREIGN KEY (`productos_id`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `usuario` (`id`);

--
-- Filtros para la tabla `metodosventa`
--
ALTER TABLE `metodosventa`
  ADD CONSTRAINT `fk_MetodosVenta_RegistroVenta1` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroventa` (`idRegistroVenta`),
  ADD CONSTRAINT `fk_MetodosVenta_TiposMetodo1` FOREIGN KEY (`TiposMetodo_idTiposMetodo`) REFERENCES `tiposmetodo` (`idTiposMetodo`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_Productos_Fabricante1` FOREIGN KEY (`Fabricante_id`) REFERENCES `fabricante` (`id`);

--
-- Filtros para la tabla `productoscategoria`
--
ALTER TABLE `productoscategoria`
  ADD CONSTRAINT `fk_Productos_has_Subcategoria_Productos1` FOREIGN KEY (`Productos_id`) REFERENCES `productos` (`id`),
  ADD CONSTRAINT `fk_Productos_has_Subcategoria_Subcategoria1` FOREIGN KEY (`Subcategoria_id`) REFERENCES `subcategoria` (`id`);

--
-- Filtros para la tabla `registropedido`
--
ALTER TABLE `registropedido`
  ADD CONSTRAINT `registropedido_ibfk_1` FOREIGN KEY (`Usuario_id`) REFERENCES `usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
