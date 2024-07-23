-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-07-2024 a las 17:47:49
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadencargo`
--

CREATE TABLE `cantidadencargo` (
  `RegistroVenta_idRegistroVenta` smallint(4) NOT NULL,
  `Productos_idProductos` smallint(4) NOT NULL,
  `Cantidad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadpedido`
--

CREATE TABLE `cantidadpedido` (
  `Productos_idProductos` smallint(4) NOT NULL,
  `RegistroPedido_idRegistroPedido` int(4) NOT NULL,
  `Cantidad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cantidadventa`
--

CREATE TABLE `cantidadventa` (
  `RegistroVenta_idRegistroVenta` smallint(4) NOT NULL,
  `Productos_idProductos` smallint(4) NOT NULL,
  `Cantidad` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categoria`
--

CREATE TABLE `categoria` (
  `idCategoria` tinyint(2) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `categoria`
--

INSERT INTO `categoria` (`idCategoria`, `Nombre`) VALUES
(1, 'Lapiceros'),
(2, 'pepe'),
(3, 'Aseo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `fabricante`
--

CREATE TABLE `fabricante` (
  `idFabricante` tinyint(3) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Telefono` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `fabricante`
--

INSERT INTO `fabricante` (`idFabricante`, `Nombre`, `Telefono`) VALUES
(1, 'Danielitos', '123123'),
(2, 'Matel', '1111');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metodosventa`
--

CREATE TABLE `metodosventa` (
  `TiposMetodo_idTiposMetodo` tinyint(2) NOT NULL,
  `RegistroVenta_idRegistroVenta` smallint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `idProductos` smallint(4) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `Cantidad` smallint(3) NOT NULL,
  `ValorCompra` int(7) NOT NULL,
  `ValorVenta` int(7) NOT NULL,
  `Descripcion` varchar(150) NOT NULL,
  `imagen` varchar(50) DEFAULT NULL,
  `Fabricante_idFabricante` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProductos`, `Nombre`, `Cantidad`, `ValorCompra`, `ValorVenta`, `Descripcion`, `imagen`, `Fabricante_idFabricante`) VALUES
(1, 'Arepa', 123, 123, 123, '123', '123', 1),
(2, '123', 123, 123, 123, '123', 'ImgProductos/66967c7c9cc1f.jpeg', 1),
(3, '1231', 1231, 12311, 1231, '123123', 'ImgProductos/66967d8aeb66d.jpeg', 1),
(4, 'Hola', 123, 111111, 1211, '123123131', 'ImgProductos/66967e12801c4.jpg', 1),
(8, '1111', 111, 11, 111, '11', 'ImgProductos/669681ba50e99.jpg', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productoscategoria`
--

CREATE TABLE `productoscategoria` (
  `Productos_idProductos` smallint(4) NOT NULL,
  `Subcategoria_idSubcategoria` tinyint(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroencargo`
--

CREATE TABLE `registroencargo` (
  `idRegistroEncargo` smallint(4) NOT NULL,
  `Valor` int(7) NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registrofalta`
--

CREATE TABLE `registrofalta` (
  `idRegistroFalta` tinyint(3) NOT NULL,
  `NombreProducto` varchar(45) NOT NULL,
  `Contador` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registropedido`
--

CREATE TABLE `registropedido` (
  `idRegistroPedido` int(4) NOT NULL,
  `Fecha` datetime NOT NULL,
  `ValorTotal` int(7) NOT NULL,
  `Observaciones` varchar(200) DEFAULT NULL,
  `Usuario_DocumentoUsuario` bigint(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registroventa`
--

CREATE TABLE `registroventa` (
  `idRegistroVenta` smallint(4) NOT NULL,
  `Valor` int(7) NOT NULL,
  `ValorTotal` int(7) NOT NULL,
  `Fecha` datetime NOT NULL,
  `Usuario_DocumentoAdministrador` bigint(12) NOT NULL,
  `DocumentoCliente` bigint(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `rol`
--

CREATE TABLE `rol` (
  `IdRol` tinyint(2) NOT NULL,
  `Nombre` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

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
  `idSubcategoria` tinyint(3) NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  `idCategoria` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `subcategoria`
--

INSERT INTO `subcategoria` (`idSubcategoria`, `Nombre`, `idCategoria`) VALUES
(1, 'Retractil', 1),
(1, '123131', 2),
(2, 'Redondo', 1),
(3, 'Negro', 1),
(4, 'Triangular', 1),
(6, '123', 1),
(7, '123111', 2),
(8, 'Limpieza', 3),
(9, 'Desinfeccion', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposdocumento`
--

CREATE TABLE `tiposdocumento` (
  `idTiposDocumento` tinyint(2) NOT NULL,
  `Sigla` varchar(4) NOT NULL,
  `Descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `tiposdocumento`
--

INSERT INTO `tiposdocumento` (`idTiposDocumento`, `Sigla`, `Descripcion`) VALUES
(1, 'TI', 'Tarjeta de Identidad'),
(2, 'CC', 'Cedula de Ciudadanía');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposmetodo`
--

CREATE TABLE `tiposmetodo` (
  `idTiposMetodo` tinyint(2) NOT NULL,
  `Nombre` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `Documento` bigint(12) NOT NULL,
  `PrimerNombre` varchar(30) NOT NULL,
  `PrimerApellido` varchar(30) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `Correo` varchar(100) NOT NULL,
  `Contraseña` varchar(100) NOT NULL,
  `TipoDocumento` tinyint(2) NOT NULL,
  `Rol` tinyint(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`Documento`, `PrimerNombre`, `PrimerApellido`, `Telefono`, `Correo`, `Contraseña`, `TipoDocumento`, `Rol`) VALUES
(1231231, '12312', '123123', '1231231', 'juanjos', '123123', 1, 2),
(1011397031, 'Juan', 'Benitez', '3242974388', 'prueba@gmail.com', '5e8667a439c68f5145dd2fcbecf02209', 1, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarioproductofaltante`
--

CREATE TABLE `usuarioproductofaltante` (
  `DocumentoCliente` bigint(12) NOT NULL,
  `IdProductoFaltante` tinyint(3) NOT NULL,
  `Fecha` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tablas volcadas
--

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
-- Indices de la tabla `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indices de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  ADD PRIMARY KEY (`idFabricante`),
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
  ADD PRIMARY KEY (`idProductos`,`Fabricante_idFabricante`),
  ADD KEY `fk_Productos_Fabricante1_idx` (`Fabricante_idFabricante`);

--
-- Indices de la tabla `productoscategoria`
--
ALTER TABLE `productoscategoria`
  ADD KEY `fk_Productos_has_Subcategoria_Subcategoria1_idx` (`Subcategoria_idSubcategoria`),
  ADD KEY `fk_Productos_has_Subcategoria_Productos1_idx` (`Productos_idProductos`);

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
  ADD PRIMARY KEY (`idRegistroPedido`,`Usuario_DocumentoUsuario`),
  ADD KEY `fk_RegistroPedido_Cliente1_idx` (`Usuario_DocumentoUsuario`);

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
  ADD PRIMARY KEY (`idSubcategoria`,`idCategoria`),
  ADD KEY `fk_Subcategoria_Categoria1_idx` (`idCategoria`);

--
-- Indices de la tabla `tiposdocumento`
--
ALTER TABLE `tiposdocumento`
  ADD PRIMARY KEY (`idTiposDocumento`),
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
  ADD PRIMARY KEY (`Documento`,`TipoDocumento`,`Rol`),
  ADD KEY `fk_Administrador_TiposDocumento_idx` (`TipoDocumento`),
  ADD KEY `fk_Usuario_Rol1_idx` (`Rol`);

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
-- AUTO_INCREMENT de la tabla `categoria`
--
ALTER TABLE `categoria`
  MODIFY `idCategoria` tinyint(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `fabricante`
--
ALTER TABLE `fabricante`
  MODIFY `idFabricante` tinyint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProductos` smallint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `registroencargo`
--
ALTER TABLE `registroencargo`
  MODIFY `idRegistroEncargo` smallint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registrofalta`
--
ALTER TABLE `registrofalta`
  MODIFY `idRegistroFalta` tinyint(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registropedido`
--
ALTER TABLE `registropedido`
  MODIFY `idRegistroPedido` int(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registroventa`
--
ALTER TABLE `registroventa`
  MODIFY `idRegistroVenta` smallint(4) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  MODIFY `idSubcategoria` tinyint(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `cantidadencargo`
--
ALTER TABLE `cantidadencargo`
  ADD CONSTRAINT `fk_CantidadVenta_Productos11` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`idProductos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_CantidadVenta_RegistroVenta10` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroencargo` (`idRegistroEncargo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cantidadpedido`
--
ALTER TABLE `cantidadpedido`
  ADD CONSTRAINT `fk_CantidadVenta_Productos10` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`idProductos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_CantidadVenta_copy1_RegistroPedido1` FOREIGN KEY (`RegistroPedido_idRegistroPedido`) REFERENCES `registropedido` (`idRegistroPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `cantidadventa`
--
ALTER TABLE `cantidadventa`
  ADD CONSTRAINT `fk_CantidadVenta_Productos1` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`idProductos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_CantidadVenta_RegistroVenta1` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroventa` (`idRegistroVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `metodosventa`
--
ALTER TABLE `metodosventa`
  ADD CONSTRAINT `fk_MetodosVenta_RegistroVenta1` FOREIGN KEY (`RegistroVenta_idRegistroVenta`) REFERENCES `registroventa` (`idRegistroVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_MetodosVenta_TiposMetodo1` FOREIGN KEY (`TiposMetodo_idTiposMetodo`) REFERENCES `tiposmetodo` (`idTiposMetodo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `fk_Productos_Fabricante1` FOREIGN KEY (`Fabricante_idFabricante`) REFERENCES `fabricante` (`idFabricante`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `productoscategoria`
--
ALTER TABLE `productoscategoria`
  ADD CONSTRAINT `fk_Productos_has_Subcategoria_Productos1` FOREIGN KEY (`Productos_idProductos`) REFERENCES `productos` (`idProductos`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Productos_has_Subcategoria_Subcategoria1` FOREIGN KEY (`Subcategoria_idSubcategoria`) REFERENCES `subcategoria` (`idSubcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registropedido`
--
ALTER TABLE `registropedido`
  ADD CONSTRAINT `fk_RegistroPedido_Cliente1` FOREIGN KEY (`Usuario_DocumentoUsuario`) REFERENCES `usuario` (`Documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `registroventa`
--
ALTER TABLE `registroventa`
  ADD CONSTRAINT `fk_RegistroVenta_Cliente1` FOREIGN KEY (`Usuario_DocumentoAdministrador`) REFERENCES `usuario` (`Documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `subcategoria`
--
ALTER TABLE `subcategoria`
  ADD CONSTRAINT `fk_Subcategoria_Categoria1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `fk_Administrador_TiposDocumento0` FOREIGN KEY (`TipoDocumento`) REFERENCES `tiposdocumento` (`idTiposDocumento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Usuario_Rol1` FOREIGN KEY (`Rol`) REFERENCES `rol` (`IdRol`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Filtros para la tabla `usuarioproductofaltante`
--
ALTER TABLE `usuarioproductofaltante`
  ADD CONSTRAINT `fk_Usuario_has_RegistroFalta_RegistroFalta1` FOREIGN KEY (`IdProductoFaltante`) REFERENCES `registrofalta` (`idRegistroFalta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Usuario_has_RegistroFalta_Usuario1` FOREIGN KEY (`DocumentoCliente`) REFERENCES `usuario` (`Documento`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
