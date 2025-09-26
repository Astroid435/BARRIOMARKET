-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 23, 2025 at 02:49 PM
-- Server version: 8.4.3
-- PHP Version: 8.3.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `barriomarket`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `auth_permission`
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
-- Table structure for table `cantidadencargo`
--

CREATE TABLE `cantidadencargo` (
  `RegistroEncargo_id` smallint NOT NULL,
  `Productos_id` smallint NOT NULL,
  `Cantidad` int NOT NULL,
  `Id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `cantidadencargo`
--

INSERT INTO `cantidadencargo` (`RegistroEncargo_id`, `Productos_id`, `Cantidad`, `Id`) VALUES
(1, 39, 117, 1),
(1, 41, 1, 2),
(2, 41, 38, 3),
(3, 41, 4, 4),
(4, 41, 2, 5),
(5, 41, 9, 6),
(6, 48, 2950, 7);

-- --------------------------------------------------------

--
-- Table structure for table `cantidadpedido`
--

CREATE TABLE `cantidadpedido` (
  `Productos_id` smallint NOT NULL,
  `RegistroPedido_id` int NOT NULL,
  `Cantidad` int NOT NULL,
  `Id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `cantidadpedido`
--

INSERT INTO `cantidadpedido` (`Productos_id`, `RegistroPedido_id`, `Cantidad`, `Id`) VALUES
(41, 3, 3, 1),
(42, 3, 1, 2),
(41, 4, 1, 3),
(41, 5, 3, 4),
(39, 5, 40, 5),
(41, 6, 4, 6),
(41, 7, 2, 7),
(42, 7, 1, 8);

-- --------------------------------------------------------

--
-- Table structure for table `cantidadventa`
--

CREATE TABLE `cantidadventa` (
  `RegistroVenta_id` smallint NOT NULL,
  `Productos_id` smallint NOT NULL,
  `Cantidad` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `carrito`
--

CREATE TABLE `carrito` (
  `id` int NOT NULL,
  `cantidad` int NOT NULL,
  `productos_id` smallint NOT NULL,
  `usuario_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`id`, `Nombre`) VALUES
(1, 'Lapiceros'),
(2, 'pepe'),
(3, 'Aseo'),
(4, 'Pepe ganga');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
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
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_content_type`
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
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_migrations`
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
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('08oeguul5cit2opd8km44roiu7il8r0e', '.eJxVjDsOwjAQBe_iGlm2k_WHkj5nsNafxQFkS3FSIe5OIqWA9s28eTOP21r81vPi58SuTLHL7xYwPnM9QHpgvTceW12XOfBD4SftfGopv26n-xco2Mv-RhiJUBoprVZZDQ4CWZFIaBU1Ridgbw0wSAc4phyFEWSdAaEpUtKOfb7eVzfX:1v13Ws:nn0Cs4lQadF7yHx9lI6CrXJDqeACVN51WCNeL7xGjAw', '2025-09-23 14:18:02.739538'),
('0kimm3b8qt5kl04vrs9k422epo79irpd', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1siugx:gWOwNrwLDu9kuGzPRPo-oLiN6OYLClfd-7eU6hb3mOY', '2024-08-27 12:08:55.193733'),
('1136032cy7m10f3fgez52fa2ncniygwl', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqAAT:Z9ksAg94VvzF4tG6YZXNrqnVjB4hsNmUXnJ7ShpRWgM', '2024-09-16 12:05:21.521170'),
('1bl4cvqm1peeq5cw6swq1zifgh8gu1ms', '.eJxVjEEOwiAURO_C2hChUsCle09gTPP_B1rU0AToynh3qWmMLufNzHuyAZY6DUvxeYiOHZlku1-GQHef1sLdII0zpznVHJGvE761hZ9n5x-nbfsnmKBM7a2tR6O6TgKgQrCBrOg17VEZ70h3QE4LqXxQThk89ELLPlgkqZ2R2uomDYA5EqTqm080QFD9OOcIWy4LflFhx8sHSnZ9vQEIQEn-:1sqBDd:P0tDVVDp6lsN4Vflt1mreUqJKUuKooYjkNkw7rdzBWQ', '2024-09-16 13:12:41.864793'),
('1g1zoas8ef7cib3ghtd1k2910tdyufb7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svcXs:3-gH9a4SUvpERykwDsEIjETFcF-JQSA9WMd6GTnUUJ0', '2024-10-01 13:24:04.835786'),
('2m9s756ctvptm7jhzvfb3xi4ks97gxpv', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svdyb:yNdDYkPMzgcV2GnAfbw5_ctHIh8gE1sjSmOqTjwEkp8', '2024-10-01 14:55:45.666666'),
('3pt9mo7nbxq6fvn8c0gamcya8qgvce2q', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swgF1:xkMUtoltRphUlUXzTgbvFlQ5ZwhPyUyieKJ-zn7XlsY', '2024-10-04 11:32:59.199791'),
('3wykshikojqjptn9h3vexzozr8st3s4r', '.eJxVjkEOwiAURO_C2jRAC5Qu3XsCY5rPB1rUQAJ0Zby7NGmMbt_MvMyLzLDVdd6Ky3OwZCKcnH6ZAXy4uAf2DnFJHaZYczDdXumOtHSXZN3zfHT_BCuUta1BDN4DU4yNkjvea2H8SK2nkqME1FQ0Vy96pgUM1iFV1I9aCSo9eit1k3owOSDE6ppvaAChuiXlAMftspkvKmS6EkVu7w-6JUkg:1v11R8:8rvXFL-nAoyJa5H4x3eCDcWIxSjwmT7UidBVE_YTW00', '2025-09-23 12:03:58.363100'),
('482r7myo2lracy517y9d5khx2prgz99o', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sttDS:tlQUkH00zCrr58VOE6wB_Am8QMUsXcq1mckLedYURUA', '2024-09-26 18:47:50.077802'),
('4nan8nnmkzpqqed8oii16u1it6necufu', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0N4l:R36UrIbMRYF45qBNYjusZX4OIJZB-zETXxPd5RpBcDs', '2025-04-03 16:25:55.428199'),
('548fuhn18njx1n0dra69yvv8gih63kbc', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stvMe:n7rxy1jXGRwfFF3Bl-qPjgef-eG_sKE7prn-xdC9PZM', '2024-09-26 21:05:28.420998'),
('5ctp2ynp5f7uzamhhon7brwni3zswod9', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqXXv:Mi8kTDf3tOq-A63CmI1q6iTjnbhT0jr8AK-S3C4Crt4', '2024-09-17 13:03:07.324196'),
('5fho327nmxkx95ybdfidcvwbrf9xwl3w', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqaaJ:OuSF38UvogQKvJ3chgzgQJd7LGqGC3qbST1Zk0s4VzQ', '2024-09-17 16:17:47.280916'),
('6dtoaq3fpbf2po7kzwrt6bhtd3t3gjfh', '.eJxVjMsOwiAQRf-FtSHA8GhduvcbyMBMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJM4mz8OL0uyXMD647oDvWW5O51XWZk9wVedAur434eTncv4OCvXxrTEAQBiIETYjakkWPamBrHDhmjWwpG0heMdCoNIEbeZpCSKjBBPH-AAcIOHk:1u0MhH:75JEt4G2peH8UgqJmCIyDumtkG7bVCtXVsQc-ukAXSw', '2025-04-03 16:01:39.118589'),
('6fhe3wqanl07h57z6jas72hcuebfwkip', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0JsR:FFczTj18M6qwDzRbPLHDZ4eyGwY9o_AlOG9ICPKIxvo', '2025-04-03 13:00:59.736870'),
('6hg1icuh7tcz88kor0itjveun37v06eb', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1tt5lO:TiCPAQfyEuRlN6BFqsPZYvQ7Om-3KybNMhAq2am7leM', '2025-03-14 14:31:50.811716'),
('79tfh9d1lqvsj6eb5o1fx9jalf6f67ds', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svb2V:mxUFnhak9tVlJZUr28ChO8otMFTgZcUHLYqlHtMhxZI', '2024-10-01 11:47:35.108044'),
('7qm2n2bu3c7pwk08d0hmtqk6fu51pvnj', '.eJxVjMsOgjAUBf-la9PYYrmtS_d8A7mvCmpKQmFl_HchYaHbM3PmbXpcl6Ffq879KOZqvDn9boT81LIDeWC5T5ansswj2V2xB622m0Rft8P9CwxYh-0NSSmGpvGIFAhT5uRa4DOFqMLQIAs4HzQHCZEurQPf5kTsQaKHBFs0I80jY1l06znz-QLh_j1L:1suFyG:2xZ4lmemC03rMuYadwGS2pwfLsfYu4qqyEE0I_3frHQ', '2024-09-27 19:05:40.990022'),
('87mjojd73im3dtoi5df247iy7l5o4m4i', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0N1q:_Em3VjmuKokI14dbVFhm9h7Q__QP2JdCwxgkNEj6oHs', '2025-04-03 16:22:54.373276'),
('8d6yqo9t0hal5de77eft6pdu3t73e0bp', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1tt6jQ:q8_BusEJb2CutVLpzGYnZXu9sXYdqavm4AieD-oGPD8', '2025-03-14 15:33:52.160766'),
('8pqu6c17uyouxckbj1ffqoi5q8ak6nyc', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuX9:OnE8izCDYHsyaiEUWiNVQrf9dH52w9ZEprfDczYCu4o', '2024-09-26 20:12:15.784747'),
('8r661zwxwmul96r8dgrquzkrppsrhx0i', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u2UyE:rMPIuUdb2t76tombmeYAel1pUiAXaX_1SqJrlqI7oxs', '2025-04-09 13:15:58.428879'),
('8zo75xgq07ceolf0e0buyxfugl8focld', '.eJxVjMEOgjAQRP9lz6SRQtmWo3e_wBiyu22haiChcDL-u5AQo8eZ92ZeEInnJDQuAVqooQChJfTTnGjLest55W-Vob0Cwq2AjtZl6NYc5i75w_zpmOQRxh34O439pGQalzmx2hV10Kwukw_P8-H-HQyUh22NLrA1VaWJ2DC5KK5sUE5sbPCCFYnHUpsQjTeW66ZE3UTHotFbjQ7h_QF8MElm:1svfAt:d37Ny3iuI78TLeWfCSdL5-EYay_XwbyxMmLaWjTKjGU', '2024-10-01 16:12:31.297937'),
('a40z7q6jk2s0fmyogfqqq5g7mr3dw7u9', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stYfF:R-14hK3q_vw4Z9oogAM-5LsoyMkDfuwj6Yu5tt7lapk', '2024-09-25 20:51:09.725359'),
('aoeliesf40v1vap6azq3uj4j4efq7x0p', '.eJxVjkEOwiAQRe_C2hAL0gGX7j2BMc3MQFvUlAToynh3W9MYXf733_zMU3Q417GbS8hd9OIolNj9MkK-h2kt_A2nIUlOU82R5KrIrS3ynHx4nDb3b2DEMi7X4AJZo7VCJEPoenZNC7wnY4Nn0MgeGmVCb7yxdGgbUG3viBV4q8DBMtoj5cg41bC9yVjDkHLEJTdLLjN9URHHyweuohbX1xsv9Eqi:1swNSH:3GrSt67PjMBm2wZN7058E-sBrvcA_HAiQaOA37ivYY4', '2024-10-03 15:29:25.715370'),
('asfvomvowvjjcba1nf37wjnq48f21b9p', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1tzzY0:x4BClPxtbiaeSWEBj9UQnvKz0ZZt18RomvoSZJGmULw', '2025-04-02 15:18:32.295677'),
('aym074x633eillipqdt4qx3svia88ta4', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1suFSQ:HQyHH9rLYK1XXJK8U31NQ0lq3Mt7Pwaj3d6RpRSke_M', '2024-09-27 18:32:46.201243'),
('bd7xoyxli07ldn6dfrae4vzq8w4p9n38', 'e30:1sieEY:ei4N5mtVGxCymIdcm2K2uX8oj32lYtlSKnqrhN4gdQ8', '2024-08-26 18:34:30.372352'),
('bps5re11xpbf09ap0g5rcd4jpv2borbf', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0fdQ:t_jJK9KcV0_TNo9JgTF41QfQisT32E9-g2-PQqv4yBU', '2025-04-04 12:14:56.655112'),
('c4ojnna20h0q5tl1w0c5s5274nrm3bw2', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sveof:cxx-YZRieGTvJLTSeYp37muDMsWKu5k6jb-PMAXgNi0', '2024-10-01 15:49:33.331319'),
('dczuw63v3ku8yt50144c677tr2wyk8tg', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u2Vyt:-ZA-bjK3IN0DF_PFXS2f21adfFRHa6GxY3w1zhKSdrg', '2025-04-09 14:20:43.468141'),
('de9mpw6d6urtnpyqgz8aov2hihu4yxrl', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u6sFx:e_4BABqctsCRuZCpQ8tDxFBe7tM-jp_UQRN2Ra4T8QM', '2025-04-21 14:56:21.041904'),
('dulupxg7bkkz8ktclmsyw2jo1gxmkmpo', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u2UkA:5xeyv57f0p-5umOwN65c2zBKkBIifNHp1lUKKoiSSyI', '2025-04-09 13:01:26.911485'),
('dx4zjoe7ffa36tz5ed55hwciifo7ji8y', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sixVM:EUE-lF_gab_GVmFyKNWINz1l8qz2AKxi9-baSIa94Dg', '2024-08-27 15:09:08.870309'),
('e9pdqs5g8d0thgj5ttdcgou7lkpchyq1', '.eJxVjDsOwjAQBe_iGlm2k_WHkj5nsNafxQFkS3FSIe5OIqWA9s28eTOP21r81vPi58SuTLHL7xYwPnM9QHpgvTceW12XOfBD4SftfGopv26n-xco2Mv-RhiJUBoprVZZDQ4CWZFIaBU1Ridgbw0wSAc4phyFEWSdAaEpUtKOfb7eVzfX:1v12Mq:qkVFEBRXfYLJnM77t6w6HuXDFUN7m4D8woGZV6hR8tE', '2025-09-23 13:03:36.116705'),
('ej96s1jjm3lpgxuho9bkvfbfjhplidaj', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sjg84:u4ILqPwaXIR5fWprZt0q0BbD0h1BRKB_FUmYNxQLs7M', '2024-08-29 14:48:04.960316'),
('fkuqx6k7p33jt854k8dhtmbzjy516sav', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1uzjDY:w2XxAkDaeMb6aor7xZ2CX98RlRwXd4zl91VRZ80P3uQ', '2025-09-19 22:24:36.166085'),
('h10mlwkcyryiuibtcrsvcspw19oaubyv', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sveU2:Kg9DHiXFsk3SCaNmo2HShiK5vaFMKEfuqCcKOxwBXvg', '2024-10-01 15:28:14.807689'),
('horyu0p8cn21b1dykdn3kc3j29q7o8ve', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1v01o5:-Oo9ZfSzUx8mCq6u5DnYJ9JGI5ikH5Cy5B51s0cmRVU', '2025-09-20 18:15:33.127853'),
('hua0lmxvsr9mopi7afoscyydsyh1m1fd', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swL4d:S3g2dcrrvJBk91rVHWCjjq9Hb6B4AkPFE4U9QuGBQYs', '2024-10-03 12:56:51.003930'),
('iz14w19m7p9do34zhgc0t39weeqd5n1e', '.eJxVjMEKwyAQBf_FcxGjIWqOvfcLSgnruia2xYCaU-m_10Ao7fHNG-bFJtjqMm2F8hQ9G5lkp1_mAB-U9sPfIc0rxzXVHB3fFX68hV9WT8_z4f4FFijLnkWlle8QNIreS2uCIgJyQUkXCIQnocEGYwYvBz14bQVZpTFoMGgNtGgAlyNCqtR6qgGESvOaI7Tdt10290WFjVfWSXZ7fwBm_EpR:1u2WMF:MTwa6wVqEXHir1qwZlMbW_V3afNsRbehkHS3CpEm-AU', '2025-04-09 14:44:51.901745'),
('j8fq1p5tmlx6vf90jotqljhc0l06bdvy', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1uzhwv:ZkV51hqV5tJOVN9L8_iOh1K5eY7_STCXIZEQdhR6CAY', '2025-09-19 21:03:21.069365'),
('kapu83jeoo28awgelv3o92w1nqjd9osj', '.eJxVjsEKwjAQRP8lZykmNd2mR-9-gUjZ3SRtVRJI0pP476ZQRK9vZh7zEiOuZR7X7NK4WDEIJQ6_jJAfLmyBvWOYYsMxlLRQs1WaPc3NJVr3PO_dP8GMea5rMI563bYKkTSh8WxkB3wk3TvL0CJbkEo7r63u6dRJUJ03xApsr8BAlXqktDCG4qpPVsBY3BTTgvvtvNIXZTFcBYjb-wPja0lj:1sttrK:22ieyUj7jQtLhVATzJnrPaiVGlnfucmxnew722-ukng', '2024-09-26 19:29:02.061633'),
('kvt5rvrn300mkk235kfq4wp21ue4lhrp', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuCm:yjFpWo_pYNuqUNExUkEM-vNI6-HEDfgCYQMrilQ3OrU', '2024-09-26 19:51:12.918799'),
('l70lp4ytj5cfyr9yuapza6ta2dd73ynh', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sjdzm:RbX1eG_L444LSNCn8XzTZIJdrFQo7_uAkTNgDKzEHmQ', '2024-08-29 12:31:22.838457'),
('ljhcklc5d4xljn08cpgxgn1szna4gi7m', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svdJm:uB0qEoQyWIT5MWjY1Fdbp-kmRkhNjrxRvga0Ewmfmb8', '2024-10-01 14:13:34.364134'),
('m4hx3fiofw62b9q2k5bb7yqgf8m8wgat', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sieFh:dVeJufb3T9FEoKFZo4K8ZOdHh3t8jPSnZNbVF7KLkEk', '2024-08-26 18:35:41.968810'),
('m6wzgcqbarv4akj39hsxkp2fwxt866qr', '.eJxVjEEOgjAQRe_StWlsoQxl6d4TGENmpgWqhia0rIx3txhidDGL__6f9xQ9rnnq1-SXPjjRCS0Ov4yQ737eCnfDeYyS45yXQHKbyL1N8hydf5z27Z9gwjSVb7CeWlNVGpEMoR3Yqgb4SKb1jqFCdqC08YNxpqW6UaCbwRJrcK0GC0U6IC2Bcc6--FQBjNmPcQm457TSFyXRXT6wLqfF9fUGL89Kog:1stY1I:pjL_W9_YYVUD0Q2mEhcteP6gsNfcgCMQJd4N86wUelw', '2024-09-25 20:09:52.594008'),
('mqp8xshbbigx2e2jkm0c4pf4aikys6td', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0fGf:FlDI_9yixka4ABR4L5qJrxRenamwzi1lJ9Ne5Zp4MZI', '2025-04-04 11:51:25.512267'),
('mqzhbmaiidpu40l7srkiw2bll6vg0wq1', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1uzihy:1axUHpOWRA8qBqRYhHbom_HuOKbSEaaRZmeHOTZZYAc', '2025-09-19 21:51:58.218823'),
('n1i83nxavmyuvfasqhcyrx29lbzojev4', '.eJxVjMEOgjAQRP-lZ9NIoWzL0btfYAzZ3bZQNTRp4WT8d8EQo8d5M_OeosdlHvul-NxHJzqhxOGXEfLdT1vhbjgNSXKa5hxJbhO5t0Wek_OP0779E4xYxvUN1pPRda0QSRPawLZqgY-kjXcMNbKDSmkftNOGmrYC1QZLrMAZBRZWaUDKkXGa_eqrVsA4-yHliHsuC31REd3lAxtxfb0BCEhKAA:1ssmLa:OadHggjsABfBE0kF-WaJfsxZT4u1f9vHvZauhRyG1VY', '2024-09-23 17:15:38.734716'),
('n22tu00m1pc825awrzlkwuiff30kaiye', '.eJxVjb2OwyAQBt-FOkI2YBZSRenzDGiBxT9nG8nG1ene_UByk3a-2dlfdtBJxYUciT2ZUkronj1uShvOa8XLtWRPa7avsREe8ladduNG2unAQtGVeauJHpQcLGgYuDKD6OHBHF5lctdJh5tjrQn2xTyGH9rbEBfcx1zrezlmz5vC7_Xkn_ptfd_uV2DCc2rZIEHGPiCETkVhTZJESD5J4RNhF6kDtMkYHYUGHcF2ZCWEBGiCNcj-_gHxYFe9:1tzxQw:NfFS8M1NXaItE6a8FN1dosLxhPMTeOwtgBPOq9OAXrg', '2025-04-02 13:03:06.858107'),
('ncv7huu8i6ndusmtc06mm5w3aoutl8rr', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u6tfz:skzkwR7v3EjeKySvpggYeAhmOwXBocaOhh5KhP0Hcg0', '2025-04-21 16:27:19.674552'),
('nt8uudu2cu33ofe9vfsaew3c2kdc0axr', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u00mD:qb3vvZP78renmSaz2_H7sQuazwaviBhL6OgpPW3T-Hc', '2025-04-02 16:37:17.700971'),
('o1a1mljrvlmv8zfd8rh3rk33r5ndepfo', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swLOX:MDgdU4F72JQpi0prb-Wv7YVgnRKTQLwDapzawcpZ1u0', '2024-10-03 13:17:25.031443'),
('o8gsi98r8c3n0kdgiuef1sgczo4c72d7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqZXk:f4RWC7FlpZsgnKF6iy6DqKx23ww65i3qsmqyUD0B8xo', '2024-09-17 15:11:04.695406'),
('ohl8l4tsquxig0ti90aimf864838wmqr', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sslY1:KSGNtg7n4LaF-zJb8axElq4pq1N5a-wTRQtK-N61_Y8', '2024-09-23 16:24:25.941973'),
('q08jnv0jdd1zhop7pskg0s2v5g2ubu85', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1tt73D:UHUnAlktnzacuEmK4z-jM5OwKraLY7BpUOMXxMlpCKs', '2025-03-14 15:54:19.978795'),
('qb9rntlgfbsqk9izne48pqq9dwh1iaqb', '.eJxVj0EOwiAQRe_C2hCBUsCle09gTDMzQIuakhS6Mt5dmjRGl__9Py-ZFxtgrdOwlrAMybMTk-zwyxDoEeat8HeYx8wpz3VJyLcJ39vCL9mH53nf_gkmKFO7Ni6g1UpJANQILpITvaEjahs8GQXkjZA6RO21xa4XRvbRIUnjrTTONGkEXBLBXEPziQYIahjzkqDlruWy4hcVdroysT0jFLu9P5yISmU:1sqAeb:LtNmKGrSEpITs8j4u-xq68kGpiFonVht5AVYESqyf6U', '2024-09-16 12:36:29.892720'),
('qxu79sg6i9hmar1alzqmuqrepmak7bd0', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1suEyP:V62jG-EmtvqwIuYY-zTV5Rrh7vv9jDUYVgEMgT435lE', '2024-09-27 18:01:45.209939'),
('rggzx9n0zw57f55hpokhqdcnly0rgqx4', '.eJxVjEEOwiAURO_C2hCBUsCle09gTPP_B1rUlKTQlfHu0qQxupw3M-_FBljrNKwlLEPy7MQkO_wyBHqEeSv8HeYxc8pzXRLybcL3tvBL9uF53rd_ggnK1N7GBbRaKQmAGsFFcqI3dERtgyejgLwRUoeovbbY9cLIPjokabyVxpkmjYBLIphraL6uAYIaxrwk2HNZ8YsKO12ZUI0KyW7vD50aSmg:1sivlU:QKuJpw3dZBYKCUFqsHSN-vfCzoLeNEFoZVXf9r-Hqf0', '2024-08-27 13:17:40.580400'),
('rnq0uoqmhlbonw5phz2hfierjvb5luck', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1svbXo:2kZIiPWjcO_1GRWpLp41Dsvzq3Lse-Y_bUPMM5UoUjA', '2024-10-01 12:19:56.987718'),
('rxtkz546j4cdv1l14e6zc7cno7coxe5a', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sttWy:7etwh3e8J3DmJW7bQnWbWM3PB6KemoW9KOZmrHUS_gs', '2024-09-26 19:08:00.008723'),
('svxnffdvwvysjl6e56wsvmwynjlzkq4y', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqgoz:RX_QVaalvskXa-fuwIzdcj8YlLiNdruzJABfCvLFxaI', '2024-09-17 22:57:21.277194'),
('szn1iu0jzeqnctz28orbelp180rtegp1', '.eJxVjk0OgjAQhe_StWmkUKZl6d4TGENmpi1UDU1aWBnvLhhidPm-95P3FD0u89gvxec-OtEJJQ6_jJDvftoMd8NpSJLTNOdIcovI3S3ynJx_nPbs38CIZVzbYD0ZXdcKkTShDWyrFvhI2njHUCM7qJT2QTttqGkrUG2wxAqcUWBhHQ1IOTJOs99vMs5-SDniqqtVl4W-qIju8oGNuL7eCHVKAQ:1sugwx:FgphNhCYQewSe7Y35cQ2oOLvggetFPSJtIcccxh4OOM', '2024-09-28 23:54:07.057590'),
('tu3ud5gvw4pae12f2sez7pk0ybu4638t', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1sqX97:LMHkrT5LXH6q6PmLmrjlil1ETwUtvUC6ewz2tVOYQG8', '2024-09-17 12:37:29.379974'),
('tznfatwg75wbudy78husxzgwxlkwntjg', '.eJxVjDsOwjAQBe_iGlm2k_WHkj5nsNafxQFkS3FSIe5OIqWA9s28eTOP21r81vPi58SuTLHL7xYwPnM9QHpgvTceW12XOfBD4SftfGopv26n-xco2Mv-RhiJUBoprVZZDQ4CWZFIaBU1Ridgbw0wSAc4phyFEWSdAaEpUtKOfb7eVzfX:1v149K:Lid2E0Sx1nDYN3FaNBq_f--earVrYoyS9Z8Fx4V3g9o', '2025-09-23 14:57:46.373299'),
('u126gttkt0o16mn7d7pm9f1i303jth3v', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1uziHs:PLyBL3UVNgDtUBUjVK23yVrGS3ZG3-QUjS8N-9AnNXc', '2025-09-19 21:25:00.958020'),
('u2g580ksnkjixi9dl6tp5wffzopsfqrq', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stYKn:dndP9rEFYVf0VSt6MCtjN3L8WD7mpHPOfYInWEkAzY4', '2024-09-25 20:30:01.971544'),
('u84lcgtk6jpkjyveamxchg9bzpiiwdoz', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stsmI:gd8lok7-aol1lb-HgBcKDfuE9CMnK5t-ejZDEZdCGNo', '2024-09-26 18:19:46.604085'),
('uord7nq1w7bjjj5j0btfmcf5vt19wy30', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u0JCM:9FMMcLdaEgS8ilm4KTGeT1yNRe3GiU2tdm9iWtGM4Kw', '2025-04-03 12:17:30.313270'),
('upsz5sv0i2y8ldiar20aocatdbbyyb1h', '.eJxVjEEOwiAQAP_C2RAEw4JH776BLLuLVA1NSntq_Lsh6UGvM5PZVcJtrWnrsqSJ1VVZdfplGeklbQh-YnvMmua2LlPWI9GH7fo-s7xvR_s3qNjr2JIDx2dCIHNhG0NxIii5OJuLoGExgLGE4Nl68AzRSHRABTBQDKg-Xwl2ONs:1u7FeG:B2Io_-_XxTpORISrbJ6r8b3kytVtrOtV2VzOWbIhEBs', '2025-04-22 15:55:00.299801'),
('v55mojr36d147grjplykh4rbeeo3vbus', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swNmH:PwwZRCsLttGvUj79CTpOr3-4PkW8nYE71h_hWXF3fzY', '2024-10-03 15:50:05.417242'),
('veeotlbjmbeh4p37hyh4f299al20lfdy', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1siszc:L4BvpaI2jyOzB3YKbDMwBR7vZ1RBsV7ZRemoxw5a2UI', '2024-08-27 10:20:04.069983'),
('vxootc2yo5vewvt944mksw53vwdbxnx6', '.eJxVjMsOwiAURP-FtSE8Ci1duvcLjGkuF2hRA0mhK-O_S5PG6HLOzJwXmWCry7QVv07RkZEIcvplFvDh0164O6Q5U8yprtHSfUKPttBLdv55PrZ_ggXK0t6guhCA95wPWnghjbJhYC4wLVADGqaaSyrJjYLOeWQ9C4PpFdMBg9OmSQPYNSKk6puvawCh-jmvEY5cNvtFhYxXwiW5vT8DOklP:1v121h:_c-DEup0U_GhNKAQ6wHb42RxjhiV9i6M1MxqB47mNQI', '2025-09-23 12:41:45.325838'),
('w5v8pn790rx2d6c97yodyre8yo5kdjq6', '.eJxVjktqxDAMhu-SdTGxE0V2V6X7nsFItvJqEkPirErvPjYMQ7sTn_7XT-PpzrO_Lzn9Epv3xjRvfxlT-JajPuJKx5RUSEc-F1ZVop7fS32lKNvnU_svYKZrLm50wha6zhAxMLkxOD1gaBmsxIAdhYjagIwQwXI_aDTD6DgYjNagwxJ6yiXZh9JUZwL0Hbyo7LRsBa_3mli25D6mSsravWiqx09yyElZos_LXiJKg217q3FQrcZy_T4Ai9ZW8Q:1swiGm:YkKK-hOMDWRG3e5cwiiPC9Rms2RFo-A3iunBsS7bHCs', '2024-10-04 13:42:56.024615'),
('wrsu8w9zk2obshnt7gdwpish38kjmtf7', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stsSq:P5i9LSsxqXv1TxKda-uWhvin1h96eBXtZr87Omd8S5g', '2024-09-26 17:59:40.038079'),
('xi3nohgok8gmv8ugsq371jp90j12mcl0', '.eJxVjDEOwjAQBP_iGlkO2L5ASZ83WHfeMwmgRIqTCvF3iJQC2p2ZfZnE69KnteqcBpiL8ebwuwnnh44bwJ3H22TzNC7zIHZT7E6r7Sbo87q7fwc91_5bM4K4EM5FcwHa2ChlRYlZJYLp5EhIvJTiScmDA2lLCMqEo4tozPsDMAw5mA:1sqBsv:sveKvDjIWcivs8P3Nqs8aI4eh4B2eij791LkPGk9IXY', '2024-09-16 13:55:21.684068'),
('xte1qfc6cog18ve5746l6ago6xg2ruoh', '.eJyrVipKLU4tiU_OT0lVslIysTAxNDBR0oGKpuYmZuYAhbNKs_KTUnPyLR3SQSJ6yfm5QDUgPfHpqXmpRYklqSnxJZm5QCMMzU2MTS1Nzc3M9CwtgQyTWgBlvB-8:1tzwuN:ByWlgJ7H5O1JWShjmLgX0eFR5XFc0x1zAvb6UjAZMrA', '2025-04-02 12:29:27.013323'),
('y3ji89eeu4avdzhvm72sdazhcqoa5wsh', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1stuqZ:VTIt2TVk895p7B0SMffdWXlwnQC3Zp_MincIPzpb2vw', '2024-09-26 20:32:19.590082'),
('zmzm4iwvfsretsmyd8bwri8qlkcwwarb', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1swKkO:hPuTiDrdwDan6HJdkfMyJAqH0gDT1_wKq1MINFahASE', '2024-10-03 12:35:56.760174'),
('zo2xl2z21u0mmx391o4sap5zgsl972vb', '.eJxVj0EOwiAQRe_C2hCBUsCle09gTDMzQIuakhS6Mt5dmjRGl__9Py-ZFxtgrdOwlrAMybMTk-zwyxDoEeat8HeYx8wpz3VJyLcJ39vCL9mH53nf_gkmKFO7Ni6g1UpJANQILpITvaEjahs8GQXkjZA6RO21xa4XRvbRIUnjrTTONGkEXBLBXEPziQYIahjzkqDlruWy4hcVdroysT0jFLu9P5yISmU:1sqhUs:RJTOUKVawNAIiqCVNzcuauAKDi_HrVyBSTacwxGTVtc', '2024-09-17 23:40:38.203905'),
('zxemrshn0m8vmsbuwtl4gx52g3wm6zes', '.eJxVjMsOwiAUBf-FtSEC0gsu3fsN5D5AqqYkpV0Z_12bdKHbMzPnpRKuS01rz3MaRZ2VVYffjZAfedqA3HG6Nc1tWuaR9KbonXZ9bZKfl939O6jY67eGmCl45ywiecJYOJoB-Eg-ZGFwyALG-ly8-ECnwYAdSiS2IMFCBPX-APkOOB0:1soiXT:KsAfBR_t9y5InQxeu9nyIgRHZVaREdA0ypZ-anva540', '2024-09-12 12:23:07.613055'),
('zy0hjipheat0p0a0cqtk2cz0wu0dhopy', '.eJxVjMsOwiAQRf-FtSHA8GhduvcbyMBMpWogKe3K-O_apAvd3nPOfYmI21ri1nmJM4mz8OL0uyXMD647oDvWW5O51XWZk9wVedAur434eTncv4OCvXxrTEAQBiIETYjakkWPamBrHDhmjWwpG0heMdCoNIEbeZpCSKjBBPH-AAcIOHk:1u2TyQ:UH42i2WdiT5qH33jAhPljJRdNxPR6tWmROXkZIUeJXg', '2025-04-09 12:12:06.221565');

-- --------------------------------------------------------

--
-- Table structure for table `fabricante`
--

CREATE TABLE `fabricante` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `fabricante`
--

INSERT INTO `fabricante` (`id`, `Nombre`, `Telefono`) VALUES
(1, 'Danielitos', '123123'),
(2, 'Matel', '1111'),
(3, 'Gomitas', '2222'),
(4, 'bombombun', '12222');

-- --------------------------------------------------------

--
-- Table structure for table `metodosventa`
--

CREATE TABLE `metodosventa` (
  `TiposMetodo_idTiposMetodo` tinyint NOT NULL,
  `RegistroVenta_idRegistroVenta` smallint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `productos`
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
-- Dumping data for table `productos`
--

INSERT INTO `productos` (`id`, `Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_id`) VALUES
(39, '1', 240, 123, 123, 'utiles escolares*', '', 2),
(41, 'Empanada', 74, 35000, 60000, 'aksjdlajsldkahs dalkjsdhkajshd kashd k jashd kajsh dkjhaskjdh aksjdh kjas hdkjas hdkjash dkjhaskjdh akshd kjashdkas dk ahskjdhkajshd kash dkjahdkjashd', 'e0e8c1ef-52a4-40a3-b1db-b92332a55dce.jpg', 1),
(42, '1', 1, 1, 1, '1', '392c2597-cb79-4d62-9059-971eb46cb38e.jpg', 2),
(43, '123', 123, 123, 123, '123', 'fe6ad94f-87b9-4973-b549-7b8515218519.png', 3),
(44, '   ', 6, 40000, 30000, 'hahahah', '0cb00c4c-233c-4689-9268-69209ec2b694.png', 1),
(45, 'juan', 200, 1000, 2000, 'Hola', '83543540-0749-4cf9-8f67-9de77d240742.png', 4),
(48, 'alante', 3150, 3000, 2000, 'Hola', '37ddf6e4-6709-4405-851b-0f86092f5fd7.png', 4);

-- --------------------------------------------------------

--
-- Table structure for table `productoscategoria`
--

CREATE TABLE `productoscategoria` (
  `id` int NOT NULL,
  `Productos_id` smallint NOT NULL,
  `Subcategoria_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `productoscategoria`
--

INSERT INTO `productoscategoria` (`id`, `Productos_id`, `Subcategoria_id`) VALUES
(19, 41, 7),
(20, 42, 1),
(21, 42, 4),
(25, 39, 1),
(26, 39, 2),
(27, 39, 3),
(28, 43, 12),
(29, 44, 13),
(30, 45, 7),
(31, 48, 7);

-- --------------------------------------------------------

--
-- Table structure for table `registroencargo`
--

CREATE TABLE `registroencargo` (
  `id` smallint NOT NULL,
  `Valor` int NOT NULL,
  `Fecha` datetime NOT NULL,
  `Usuario_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `registroencargo`
--

INSERT INTO `registroencargo` (`id`, `Valor`, `Fecha`, `Usuario_id`) VALUES
(1, 74391, '2025-09-19 21:33:47', 2),
(2, 2280000, '2025-09-19 22:05:29', 2),
(3, 60000, '2025-09-20 17:57:03', 2),
(4, 60000, '2025-09-20 17:58:46', 2),
(5, 60000, '2025-09-20 17:59:23', 2),
(6, 6000000, '2025-09-23 12:46:54', 2);

-- --------------------------------------------------------

--
-- Table structure for table `registrofalta`
--

CREATE TABLE `registrofalta` (
  `idRegistroFalta` tinyint NOT NULL,
  `NombreProducto` varchar(45) NOT NULL,
  `Contador` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `registropedido`
--

CREATE TABLE `registropedido` (
  `id` int NOT NULL,
  `Fecha` datetime NOT NULL,
  `ValorTotal` int NOT NULL,
  `Observaciones` varchar(200) DEFAULT NULL,
  `Usuario_id` bigint NOT NULL,
  `Estado` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `registropedido`
--

INSERT INTO `registropedido` (`id`, `Fecha`, `ValorTotal`, `Observaciones`, `Usuario_id`, `Estado`) VALUES
(3, '2025-03-14 00:00:00', 180001, 'dasdasda', 2, ''),
(4, '2025-04-02 00:00:00', 60000, 'Hola que mas', 2, ''),
(5, '2025-04-02 00:00:00', 184920, 'adasd', 6, ''),
(6, '2025-04-03 00:00:00', 240000, '453453', 2, 'atendido'),
(7, '2025-04-09 00:00:00', 120001, '123123', 6, '');

-- --------------------------------------------------------

--
-- Table structure for table `registroventa`
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
-- Table structure for table `rol`
--

CREATE TABLE `rol` (
  `Id` tinyint NOT NULL,
  `Nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `rol`
--

INSERT INTO `rol` (`Id`, `Nombre`) VALUES
(2, 'Administrador'),
(1, 'Cliente');

-- --------------------------------------------------------

--
-- Table structure for table `subcategoria`
--

CREATE TABLE `subcategoria` (
  `id` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Categoria_id` tinyint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `subcategoria`
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
-- Table structure for table `tiposmetodo`
--

CREATE TABLE `tiposmetodo` (
  `idTiposMetodo` tinyint NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
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
-- Dumping data for table `usuario`
--

INSERT INTO `usuario` (`id`, `Documento`, `Primer_nombre`, `Primer_apellido`, `Telefono`, `Correo`, `password`, `rol_id`, `last_login`) VALUES
(2, 1011397031, 'juan', 'benitez', '3242974388', 'jujobelo9@gmail.com', 'pbkdf2_sha256$1000000$QQb5Ej05jRQ34xvI73PXjD$p1v+WhO3XCuVyCxTa/BmszBXdeR9Ks/AoNo52H+JvVo=', 2, '2025-09-23 14:37:46'),
(3, 222222, 'juan', 'es', '123123', 'juanes@gmail.com', 'pbkdf2_sha256$870000$J50QFKsEsJhgfRVKsucoER$4Pu/G6NY6DuMNLqKLiRCW8qWzOIeXuf+fvw3RKlrDIQ=', 1, '2024-08-27 14:38:42'),
(4, 1011397032, 'Astroid', '435', '3242974388', 'usuario@gmail.com', 'pbkdf2_sha256$870000$elTM5hva0mD4PhtZIwAKUT$bRDfixETPgvroetdihXczTl8PHPAv7MAVUsEab/krOg=', 1, '2024-09-16 13:35:22'),
(5, 1, '1', '1', '1', 'alanscg10@gmail.com', 'pbkdf2_sha256$870000$gwx7ooaKGkL2yly7R8SpRf$EFMy0BItwBeNGJkspIi0sfSne9WJ+qVgL5vsuPEK0p0=', 1, NULL),
(6, 101010101, 'Juan', 'benitez', '32429121', 'juan@gmail.com', 'pbkdf2_sha256$870000$hdwuIPhhhhzExSo1gMn3de$DxxY8Azqhz/5H62tXUbbY1w8FRzbisGhaKlCj90Mj4Q=', 1, '2025-04-09 11:52:06');

-- --------------------------------------------------------

--
-- Table structure for table `usuarioproductofaltante`
--

CREATE TABLE `usuarioproductofaltante` (
  `DocumentoCliente` bigint NOT NULL,
  `IdProductoFaltante` tinyint NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `cantidadencargo`
--
ALTER TABLE `cantidadencargo`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_id`),
  ADD KEY `fk_CantidadVenta_RegistroVenta10` (`RegistroEncargo_id`);

--
-- Indexes for table `cantidadpedido`
--
ALTER TABLE `cantidadpedido`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_id`),
  ADD KEY `fk_CantidadVenta_copy1_RegistroPedido1_idx` (`RegistroPedido_id`);

--
-- Indexes for table `cantidadventa`
--
ALTER TABLE `cantidadventa`
  ADD KEY `fk_CantidadVenta_Productos1_idx` (`Productos_id`),
  ADD KEY `fk_CantidadVenta_RegistroVenta1` (`RegistroVenta_id`);

--
-- Indexes for table `carrito`
--
ALTER TABLE `carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productos_id` (`productos_id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_usuario_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Telefono_UNIQUE` (`Telefono`);

--
-- Indexes for table `metodosventa`
--
ALTER TABLE `metodosventa`
  ADD KEY `fk_MetodosVenta_RegistroVenta1_idx` (`RegistroVenta_idRegistroVenta`),
  ADD KEY `fk_MetodosVenta_TiposMetodo1` (`TiposMetodo_idTiposMetodo`);

--
-- Indexes for table `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`,`Fabricante_id`),
  ADD KEY `fk_Productos_Fabricante1_idx` (`Fabricante_id`);

--
-- Indexes for table `productoscategoria`
--
ALTER TABLE `productoscategoria`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Productos_has_Subcategoria_Subcategoria1_idx` (`Subcategoria_id`),
  ADD KEY `fk_Productos_has_Subcategoria_Productos1_idx` (`Productos_id`);

--
-- Indexes for table `registroencargo`
--
ALTER TABLE `registroencargo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `registrofalta`
--
ALTER TABLE `registrofalta`
  ADD PRIMARY KEY (`idRegistroFalta`);

--
-- Indexes for table `registropedido`
--
ALTER TABLE `registropedido`
  ADD PRIMARY KEY (`id`,`Usuario_id`) USING BTREE,
  ADD KEY `fk_RegistroPedido_Cliente1_idx` (`Usuario_id`) USING BTREE;

--
-- Indexes for table `registroventa`
--
ALTER TABLE `registroventa`
  ADD PRIMARY KEY (`idRegistroVenta`,`Usuario_DocumentoAdministrador`),
  ADD KEY `fk_RegistroVenta_Cliente1_idx` (`Usuario_DocumentoAdministrador`);

--
-- Indexes for table `rol`
--
ALTER TABLE `rol`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `Descripcion_UNIQUE` (`Nombre`);

--
-- Indexes for table `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD PRIMARY KEY (`id`,`Categoria_id`),
  ADD KEY `fk_Subcategoria_Categoria1_idx` (`Categoria_id`);

--
-- Indexes for table `tiposmetodo`
--
ALTER TABLE `tiposmetodo`
  ADD PRIMARY KEY (`idTiposMetodo`);

--
-- Indexes for table `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `fk_Usuario_Rol1_idx` (`rol_id`) USING BTREE;

--
-- Indexes for table `usuarioproductofaltante`
--
ALTER TABLE `usuarioproductofaltante`
  ADD KEY `fk_Usuario_has_RegistroFalta_RegistroFalta1_idx` (`IdProductoFaltante`),
  ADD KEY `fk_Usuario_has_RegistroFalta_Usuario1_idx` (`DocumentoCliente`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `cantidadencargo`
--
ALTER TABLE `cantidadencargo`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `cantidadpedido`
--
ALTER TABLE `cantidadpedido`
  MODIFY `Id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `carrito`
--
ALTER TABLE `carrito`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `categoria`
--
ALTER TABLE `categoria`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `fabricante`
--
ALTER TABLE `fabricante`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `productos`
--
ALTER TABLE `productos`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `productoscategoria`
--
ALTER TABLE `productoscategoria`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `registroencargo`
--
ALTER TABLE `registroencargo`
  MODIFY `id` smallint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `registrofalta`
--
ALTER TABLE `registrofalta`
  MODIFY `idRegistroFalta` tinyint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registropedido`
--
ALTER TABLE `registropedido`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `registroventa`
--
ALTER TABLE `registroventa`
  MODIFY `idRegistroVenta` smallint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rol`
--
ALTER TABLE `rol`
  MODIFY `Id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `id` tinyint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
