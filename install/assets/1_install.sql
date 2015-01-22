/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : db_billingsof_v1_02_dev

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2015-01-08 06:48:42
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for billing_auxidasientocontable
-- ----------------------------
DROP TABLE IF EXISTS `billing_auxidasientocontable`;
CREATE TABLE `billing_auxidasientocontable` (
  `idasientocontable` int(11) NOT NULL AUTO_INCREMENT,
  `nota` varchar(25) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`idasientocontable`)
) ENGINE=InnoDB AUTO_INCREMENT=3105 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_banco
-- ----------------------------
DROP TABLE IF EXISTS `billing_banco`;
CREATE TABLE `billing_banco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(128) COLLATE utf8_bin NOT NULL,
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `saldo_inicial` double(255,2) NOT NULL,
  `saldo_inicial_cta_cont` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `direccion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `ciudad` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `estaactivo` tinyint(1) DEFAULT '1',
  `nrocuenta` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `bancotipocuenta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_bancos_contacuentasplan1_idx` (`contacuentasplan_cod`) USING BTREE,
  KEY `fk_bancotipocuenta_id1` (`bancotipocuenta_id`) USING BTREE,
  CONSTRAINT `billing_banco_ibfk_1` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_banco_ibfk_2` FOREIGN KEY (`bancotipocuenta_id`) REFERENCES `billing_bancotipocuenta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_bancotipocuenta
-- ----------------------------
DROP TABLE IF EXISTS `billing_bancotipocuenta`;
CREATE TABLE `billing_bancotipocuenta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipocuenta` varchar(25) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_bodega
-- ----------------------------
DROP TABLE IF EXISTS `billing_bodega`;
CREATE TABLE `billing_bodega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `orden` int(3) NOT NULL DEFAULT '1',
  `vistaweb` tinyint(1) DEFAULT '1',
  `descuentomaxporcent` double(255,5) NOT NULL DEFAULT '0.00000',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_capacidad
-- ----------------------------
DROP TABLE IF EXISTS `billing_capacidad`;
CREATE TABLE `billing_capacidad` (
  `capacidad` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(128) COLLATE utf8_bin NOT NULL,
  `fechaModificacion` datetime DEFAULT NULL,
  `estaActiva` tinyint(1) DEFAULT '1',
  `imagen` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `orden` tinyint(2) NOT NULL DEFAULT '1',
  `modulovisible` tinyint(1) NOT NULL DEFAULT '1',
  `ubicacion` varchar(128) COLLATE utf8_bin NOT NULL,
  `tabid` varchar(100) COLLATE utf8_bin NOT NULL,
  `interno` tinyint(1) NOT NULL DEFAULT '1',
  `acceso` varchar(25) COLLATE utf8_bin NOT NULL DEFAULT 'enroled',
  `tipo` varchar(25) COLLATE utf8_bin NOT NULL DEFAULT 'module' COMMENT 'pude ser module(pestania) o function',
  `icon` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`capacidad`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_cargosempleado
-- ----------------------------
DROP TABLE IF EXISTS `billing_cargosempleado`;
CREATE TABLE `billing_cargosempleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombreCargo` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `numorden` int(3) NOT NULL DEFAULT '1',
  `fCreacion` date DEFAULT NULL,
  `estaActivo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_centroscosto
-- ----------------------------
DROP TABLE IF EXISTS `billing_centroscosto`;
CREATE TABLE `billing_centroscosto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `fechacreacion` date DEFAULT NULL,
  `empleadocreacion` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_centroscosto_empleado1_idx` (`empleadocreacion`) USING BTREE,
  CONSTRAINT `billing_centroscosto_ibfk_1` FOREIGN KEY (`empleadocreacion`) REFERENCES `billing_empleado` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_cliente
-- ----------------------------
DROP TABLE IF EXISTS `billing_cliente`;
CREATE TABLE `billing_cliente` (
  `es_pasaporte` tinyint(1) NOT NULL DEFAULT '0',
  `PersonaComercio_cedulaRuc` varchar(45) COLLATE utf8_bin NOT NULL,
  `nombres` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `apellidos` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `razonsocial` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `diasCredito` int(11) DEFAULT NULL,
  `pais` varchar(255) CHARACTER SET utf16 DEFAULT NULL,
  `ciudad` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `comentarios` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `clientetipo_idclientetipo` int(11) NOT NULL,
  `descuentomaxporcent` float NOT NULL DEFAULT '0',
  `cupocredito` float NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `telefonos` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `celular` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `docidentificacion_id` int(11) DEFAULT NULL,
  `vendedor_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `clave` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`PersonaComercio_cedulaRuc`),
  KEY `fk_Cliente_PersonaComercio1` (`PersonaComercio_cedulaRuc`) USING BTREE,
  KEY `fk_cliente_clientetipo1` (`clientetipo_idclientetipo`) USING BTREE,
  KEY `fk_docidentificacion_id` (`docidentificacion_id`) USING BTREE,
  KEY `fk_vendedor_id` (`vendedor_id`) USING BTREE,
  CONSTRAINT `billing_cliente_ibfk_1` FOREIGN KEY (`clientetipo_idclientetipo`) REFERENCES `billing_clientetipo` (`idclientetipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_cliente_ibfk_2` FOREIGN KEY (`docidentificacion_id`) REFERENCES `billing_docidentificaciontipo` (`iddocidentificaciontipo`),
  CONSTRAINT `billing_cliente_ibfk_3` FOREIGN KEY (`vendedor_id`) REFERENCES `billing_empleado` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_clientetipo
-- ----------------------------
DROP TABLE IF EXISTS `billing_clientetipo`;
CREATE TABLE `billing_clientetipo` (
  `idclientetipo` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT '0',
  `descuento` double(255,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`idclientetipo`),
  UNIQUE KEY `tipo_UNIQUE` (`tipo`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_clientetipotiposprecio
-- ----------------------------
DROP TABLE IF EXISTS `billing_clientetipotiposprecio`;
CREATE TABLE `billing_clientetipotiposprecio` (
  `clientetipo_idclientetipo` int(11) NOT NULL,
  `tiposprecio_tipoprecio` varchar(28) COLLATE utf8_bin NOT NULL,
  `maxdescuentoenfact` float DEFAULT NULL,
  PRIMARY KEY (`clientetipo_idclientetipo`,`tiposprecio_tipoprecio`),
  KEY `fk_clientetipo_has_tiposprecio_tiposprecio1` (`tiposprecio_tipoprecio`) USING BTREE,
  KEY `fk_clientetipo_has_tiposprecio_clientetipo1` (`clientetipo_idclientetipo`) USING BTREE,
  CONSTRAINT `billing_clientetipotiposprecio_ibfk_1` FOREIGN KEY (`clientetipo_idclientetipo`) REFERENCES `billing_clientetipo` (`idclientetipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_clientetipotiposprecio_ibfk_2` FOREIGN KEY (`tiposprecio_tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contaasientocontable
-- ----------------------------
DROP TABLE IF EXISTS `billing_contaasientocontable`;
CREATE TABLE `billing_contaasientocontable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idasientocontable` varchar(20) COLLATE utf8_bin DEFAULT NULL,
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin NOT NULL,
  `debe` double(255,2) DEFAULT NULL,
  `haber` double(255,2) DEFAULT NULL,
  `descripcion` varchar(1000) COLLATE utf8_bin DEFAULT NULL,
  `empleado_cedulaRuc` varchar(128) COLLATE utf8_bin NOT NULL COMMENT 'U',
  `fecha` date DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin DEFAULT NULL,
  `tipotransaccion_cod` varchar(2) COLLATE utf8_bin DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `cerradoencaja` int(1) NOT NULL DEFAULT '0',
  `fechacierre` date DEFAULT NULL,
  `horacierre` time DEFAULT NULL,
  `docid` int(11) NOT NULL,
  `tipo` int(1) DEFAULT '1' COMMENT '1->ventas para cierre de caja, 2->costo ventas para resultados, 3->compras',
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_facturacompra_has_contacuentasplan_contacuentasplan1` (`contacuentasplan_cod`) USING BTREE,
  KEY `fk_contaasientocontable_empleado1` (`empleado_cedulaRuc`) USING BTREE,
  KEY `fk_contaasientocontable_tiposcomprobante1` (`tiposcomprobante_cod`) USING BTREE,
  KEY `fk_contaasientocontable_tipotransaccion1` (`tipotransaccion_cod`) USING BTREE,
  KEY `billing_contaasientocontable_ibfk_5` (`tipo`) USING BTREE,
  CONSTRAINT `billing_contaasientocontable_ibfk_1` FOREIGN KEY (`empleado_cedulaRuc`) REFERENCES `billing_empleado` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontable_ibfk_2` FOREIGN KEY (`tiposcomprobante_cod`) REFERENCES `billing_tiposcomprobante` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontable_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontable_ibfk_4` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontable_ibfk_5` FOREIGN KEY (`tipo`) REFERENCES `bill_contasientotipo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7896 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contaasientocontablefacturacompra
-- ----------------------------
DROP TABLE IF EXISTS `billing_contaasientocontablefacturacompra`;
CREATE TABLE `billing_contaasientocontablefacturacompra` (
  `contaasientocontable_id` int(11) NOT NULL COMMENT 'Guarda los asientos generados por las facturas de compra',
  `facturacompra_codigo` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `fechavencimiento` date DEFAULT NULL,
  `fechavencecuota` date DEFAULT NULL,
  PRIMARY KEY (`contaasientocontable_id`,`facturacompra_codigo`),
  KEY `fk_contaasientocontable_has_facturacompra_facturacompra1` (`facturacompra_codigo`) USING BTREE,
  KEY `fk_contaasientocontable_has_facturacompra_contaasientocontable1` (`contaasientocontable_id`) USING BTREE,
  CONSTRAINT `billing_contaasientocontablefacturacompra_ibfk_1` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontablefacturacompra_ibfk_2` FOREIGN KEY (`facturacompra_codigo`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contaasientocontablefacturaventa
-- ----------------------------
DROP TABLE IF EXISTS `billing_contaasientocontablefacturaventa`;
CREATE TABLE `billing_contaasientocontablefacturaventa` (
  `contaasientocontable_id` int(11) NOT NULL,
  `facturaventa_codigofactventa` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `fechavencimiento` date DEFAULT NULL,
  `fechavencecuota` date DEFAULT NULL,
  `anulada` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`contaasientocontable_id`,`facturaventa_codigofactventa`),
  KEY `fk_contaasientocontable_has_facturaventa_facturaventa1` (`facturaventa_codigofactventa`) USING BTREE,
  KEY `fk_contaasientocontable_has_facturaventa_contaasientocontable1` (`contaasientocontable_id`) USING BTREE,
  CONSTRAINT `billing_contaasientocontablefacturaventa_ibfk_1` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_contaasientocontablefacturaventa_ibfk_2` FOREIGN KEY (`facturaventa_codigofactventa`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contaconfigcuentas
-- ----------------------------
DROP TABLE IF EXISTS `billing_contaconfigcuentas`;
CREATE TABLE `billing_contaconfigcuentas` (
  `cod` varchar(3) COLLATE utf8_bin NOT NULL COMMENT '001 --> Transporte en compras, 002->otrosgastos en compras',
  `nombre` varchar(128) COLLATE utf8_bin DEFAULT NULL COMMENT 'Por. Ejm. Transporte en compras, otros gastos en compras',
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin NOT NULL,
  `estado` tinyint(255) NOT NULL DEFAULT '1',
  PRIMARY KEY (`cod`),
  KEY `fk_contaconfigcuentas_contacuentasplan1` (`contacuentasplan_cod`) USING BTREE,
  CONSTRAINT `billing_contaconfigcuentas_ibfk_1` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contacuentas
-- ----------------------------
DROP TABLE IF EXISTS `billing_contacuentas`;
CREATE TABLE `billing_contacuentas` (
  `cod` varchar(12) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(256) COLLATE utf8_bin NOT NULL,
  `seccion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `formula` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_contacuentasplan
-- ----------------------------
DROP TABLE IF EXISTS `billing_contacuentasplan`;
CREATE TABLE `billing_contacuentasplan` (
  `cod` varchar(12) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(256) COLLATE utf8_bin NOT NULL,
  `seccion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `formula` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `contacuentas_cod` varchar(12) COLLATE utf8_bin NOT NULL,
  `parent` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `esdetalle` tinyint(1) DEFAULT '0',
  `visible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`cod`),
  KEY `fk_contcuentasplan_contacuentas1` (`contacuentas_cod`) USING BTREE,
  CONSTRAINT `billing_contacuentasplan_ibfk_1` FOREIGN KEY (`contacuentas_cod`) REFERENCES `billing_contacuentas` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_departamento
-- ----------------------------
DROP TABLE IF EXISTS `billing_departamento`;
CREATE TABLE `billing_departamento` (
  `idDepartamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL,
  `ubicacion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `numorden` int(1) DEFAULT '1',
  `eliminado` tinyint(1) DEFAULT '0',
  `fechacreacion` date DEFAULT NULL,
  PRIMARY KEY (`idDepartamento`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_detallefacturacompra
-- ----------------------------
DROP TABLE IF EXISTS `billing_detallefacturacompra`;
CREATE TABLE `billing_detallefacturacompra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FacturaCompra_codigo` int(11) NOT NULL,
  `Producto_codigo` bigint(20) NOT NULL,
  `itemcantidad` int(11) NOT NULL,
  `itemcostobruto` double(255,2) NOT NULL,
  `itemdescuentoval` double(255,2) DEFAULT NULL COMMENT 'Descuento que el proveedor aplica unicamente a ese producto de la factura',
  `itemcostoneto` double(255,2) NOT NULL,
  `itemcostonetofinal` double(255,2) NOT NULL,
  `itemcostoxcantidadbruto` double(255,2) NOT NULL,
  `descuentoglobalporcent` double(255,2) DEFAULT NULL,
  `descuentoglobalvalor` double(255,2) DEFAULT NULL,
  `recargoglobalporcent` double(255,2) DEFAULT NULL,
  `recargoglobalvalor` double(255,2) DEFAULT NULL,
  `itemcostoxcantidadneto` double(255,2) NOT NULL,
  `ivaporcent` double(255,2) DEFAULT NULL,
  `ivaval` double(255,2) DEFAULT NULL,
  `itemcostoiva` double(255,2) DEFAULT NULL,
  `estaAnulada` int(11) DEFAULT '0',
  `bodega_id` int(11) NOT NULL,
  `itembaseiva` double(255,5) NOT NULL DEFAULT '0.00000' COMMENT 'base del producto sobre la cual se le aplica el iva ( precioneto + ice )',
  `totitembaseiva` double(255,5) NOT NULL DEFAULT '0.00000',
  `iceporcent` double(255,5) NOT NULL DEFAULT '0.00000',
  `iceval` double(255,5) NOT NULL,
  `priceice` double(255,5) NOT NULL DEFAULT '0.00000',
  `totalpriceice` double(255,5) NOT NULL DEFAULT '0.00000',
  `totivaval` double(255,5) NOT NULL DEFAULT '0.00000',
  `priceiva` double(255,5) NOT NULL DEFAULT '0.00000',
  `totalpriceiva` double(255,5) NOT NULL DEFAULT '0.00000',
  `detalle` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_FacturaCompra_has_Producto_FacturaCompra1` (`FacturaCompra_codigo`) USING BTREE,
  KEY `fk_DetalleFacturaCompra_Producto1` (`Producto_codigo`) USING BTREE,
  KEY `fk_detallefacturacompra_bodega1` (`bodega_id`) USING BTREE,
  CONSTRAINT `billing_detallefacturacompra_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_detallefacturacompra_ibfk_2` FOREIGN KEY (`Producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_detallefacturacompra_ibfk_3` FOREIGN KEY (`FacturaCompra_codigo`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=407 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_docidentificaciontipo
-- ----------------------------
DROP TABLE IF EXISTS `billing_docidentificaciontipo`;
CREATE TABLE `billing_docidentificaciontipo` (
  `iddocidentificaciontipo` int(11) NOT NULL,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL COMMENT '\n',
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `cod` varchar(3) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`iddocidentificaciontipo`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_empleado
-- ----------------------------
DROP TABLE IF EXISTS `billing_empleado`;
CREATE TABLE `billing_empleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `PersonaComercio_cedulaRuc` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `username` varchar(16) COLLATE utf8_bin NOT NULL,
  `clave` varchar(256) COLLATE utf8_bin NOT NULL,
  `nombres` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `apellidos` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `telefonos` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `celular` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `cargosempleado_id` int(11) DEFAULT NULL,
  `Departamento_idPerteneciente` int(11) DEFAULT NULL,
  `fechaIngreso` date NOT NULL,
  `fechaSalida` date DEFAULT NULL,
  `sueldo` float DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estaActivo` tinyint(1) NOT NULL DEFAULT '1',
  `accesoSistema` tinyint(1) NOT NULL DEFAULT '1',
  `esSuperUsuario` tinyint(1) NOT NULL DEFAULT '0',
  `soloAdmin` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`) USING BTREE,
  KEY `fk_Empleado_Departamento2` (`Departamento_idPerteneciente`) USING BTREE,
  KEY `fk_Empleado_PersonaComercio1` (`PersonaComercio_cedulaRuc`) USING BTREE,
  KEY `fk_empleado_cargosempleado1` (`cargosempleado_id`) USING BTREE,
  CONSTRAINT `billing_empleado_ibfk_1` FOREIGN KEY (`cargosempleado_id`) REFERENCES `billing_cargosempleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_empleado_ibfk_2` FOREIGN KEY (`Departamento_idPerteneciente`) REFERENCES `billing_departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_empleadocapacidad
-- ----------------------------
DROP TABLE IF EXISTS `billing_empleadocapacidad`;
CREATE TABLE `billing_empleadocapacidad` (
  `empleado_id` int(11) NOT NULL,
  `Capacidades_capacidad` varchar(45) COLLATE utf8_bin NOT NULL,
  `fecha` date DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `priority` int(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`empleado_id`,`Capacidades_capacidad`) USING BTREE,
  KEY `fk_Empleado_has_Capacidades_Capacidades1` (`Capacidades_capacidad`) USING BTREE,
  KEY `fk_Empleado_has_Capacidades_Empleado1` (`empleado_id`) USING BTREE,
  CONSTRAINT `billing_empleadocapacidad_ibfk_1` FOREIGN KEY (`Capacidades_capacidad`) REFERENCES `billing_capacidad` (`capacidad`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_empresa
-- ----------------------------
DROP TABLE IF EXISTS `billing_empresa`;
CREATE TABLE `billing_empresa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruc` varchar(128) COLLATE utf8_bin NOT NULL,
  `razonSocial` varchar(128) COLLATE utf8_bin NOT NULL,
  `nombreComercial` varchar(128) COLLATE utf8_bin NOT NULL,
  `representanteLegal` varchar(128) COLLATE utf8_bin NOT NULL,
  `ciudad` varchar(56) COLLATE utf8_bin DEFAULT NULL,
  `direccion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `iva` float NOT NULL,
  `mision` blob,
  `vision` blob,
  `logo` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `contribuyente_id` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`ruc`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_facturacompra
-- ----------------------------
DROP TABLE IF EXISTS `billing_facturacompra`;
CREATE TABLE `billing_facturacompra` (
  `codigoFacturaCompra` int(11) NOT NULL AUTO_INCREMENT,
  `nroAutorizacion` varchar(45) COLLATE utf8_bin NOT NULL,
  `fvenceautorizacion` date DEFAULT NULL,
  `noFacturaCompra` varchar(12) COLLATE utf8_bin NOT NULL,
  `descuentoporcent` float NOT NULL DEFAULT '0',
  `descuentovalor` double(255,2) NOT NULL DEFAULT '0.00',
  `recargoporcent` float NOT NULL DEFAULT '0',
  `recargovalor` double(255,2) NOT NULL DEFAULT '0.00',
  `fechaemisionfactura` date DEFAULT NULL,
  `fechaImpresion` datetime DEFAULT NULL,
  `fechaCreacion` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `fechavencefact` date DEFAULT NULL,
  `subtotalBruto` double(255,2) NOT NULL DEFAULT '0.00',
  `impuestoImportacion` float DEFAULT '0',
  `subtotalNeto` double(255,2) NOT NULL,
  `iva` double(255,2) DEFAULT NULL,
  `totalCompra` double(255,2) NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estaAnulada` tinyint(1) NOT NULL DEFAULT '0',
  `fechaAnulacion` datetime DEFAULT NULL,
  `userIDAnulacion` varchar(13) COLLATE utf8_bin DEFAULT NULL,
  `userIDUsuario` varchar(13) COLLATE utf8_bin NOT NULL,
  `cuotasnum` int(3) DEFAULT NULL,
  `tipopago_cod` varchar(3) COLLATE utf8_bin DEFAULT NULL COMMENT 'Por el momento no se toma en cuenta el tipo de pago . ya que se selecciona la cuenta configurada para el proveedor, se la deja para posible cambio en el futuro',
  `estapendiente` tinyint(1) NOT NULL DEFAULT '0',
  `estaarchivada` tinyint(1) NOT NULL DEFAULT '1',
  `bodega_id` int(11) NOT NULL,
  `pa_PersonaComercio_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL COMMENT 'Id del proveedor',
  `pa_sriautorizaciondocs_establecimiento` varchar(3) COLLATE utf8_bin NOT NULL,
  `pa_sriautorizaciondocs_puntoemision` varchar(3) COLLATE utf8_bin NOT NULL,
  `pa_sriautorizaciondocs_tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `sustento_cod` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `esgasto` tinyint(1) NOT NULL DEFAULT '0',
  `esactivofijo` tinyint(1) NOT NULL DEFAULT '0',
  `intervalocuotasdias` int(3) DEFAULT NULL,
  `tarifacerobruto` double(255,2) DEFAULT NULL,
  `tarifaceroneto` double(255,2) DEFAULT NULL,
  `tarifadocebruto` double(255,2) DEFAULT NULL,
  `tarifadoceneto` double(255,2) DEFAULT NULL,
  `otrosgastosdoce` double(255,2) NOT NULL DEFAULT '0.00' COMMENT 'otros gastos tarifa 12%',
  `otrosgastoscero` double(255,2) NOT NULL DEFAULT '0.00',
  `transportedoce` double(255,2) NOT NULL DEFAULT '0.00',
  `transportecero` double(255,2) NOT NULL DEFAULT '0.00',
  `ivatransportedoce` float NOT NULL DEFAULT '0',
  `iceval` double(255,2) NOT NULL DEFAULT '0.00',
  `impverdeval` float NOT NULL DEFAULT '0',
  `ivaporcent` double(255,2) NOT NULL DEFAULT '12.00',
  `ivagastosdoce` double(255,2) NOT NULL DEFAULT '0.00',
  `baseiva` double(255,2) NOT NULL DEFAULT '0.00',
  `subtbrutobienes` double(255,2) NOT NULL DEFAULT '0.00',
  `subtbrutoservicios` double(255,2) NOT NULL DEFAULT '0.00',
  `subtnetobienes` double(255,2) NOT NULL DEFAULT '0.00',
  `subtnetoservicios` double(255,2) NOT NULL DEFAULT '0.00',
  `tipo` int(11) NOT NULL DEFAULT '1' COMMENT '1 = compra normal (carga a inventarios), 2 = Gastos, 3 = activo fijo',
  `cta_entrada` varchar(12) COLLATE utf8_bin DEFAULT NULL COMMENT 'identifica a q cuenta entra -> Mercaderia, gastos, o activo fijo',
  `proveedor_id` int(11) DEFAULT NULL,
  `estado` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1 = pendiente, 2 = archivada, -1 = pendiente anulada, -2 = archivada anulada',
  `fechaarchivada` date DEFAULT NULL,
  `horaarchivada` time DEFAULT NULL,
  `estado_observ` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estado_fecha` date DEFAULT NULL,
  `estado_user` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `tot_bienes_tarif_cero` double(255,2) DEFAULT NULL,
  `tot_bienes_tarif_doce` double(255,2) DEFAULT NULL,
  `tot_serv_tarif_cero` double(255,2) DEFAULT NULL,
  `tot_serv_tarif_doce` double(255,2) DEFAULT NULL,
  `iva_bienes` double(255,2) DEFAULT NULL,
  `iva_servicios` double(255,2) DEFAULT NULL,
  `retencion_id` int(11) DEFAULT NULL,
  `reversada_id` int(11) DEFAULT NULL COMMENT 'id de la factura reversada',
  `compra_id` int(11) DEFAULT NULL COMMENT 'id de esta misma tabla, usada cuando es una nota de credito, para saber a que factura ha sido aplicada',
  `cobrada` int(1) DEFAULT NULL,
  `cobrada_detalle` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `aplica_retencion` tinyint(1) NOT NULL DEFAULT '1',
  `ndc_tipo_cobro` int(11) DEFAULT NULL,
  `anticipo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`codigoFacturaCompra`),
  UNIQUE KEY `idx_fact` (`pa_PersonaComercio_cedulaRuc`,`pa_sriautorizaciondocs_tiposcomprobante_cod`,`pa_sriautorizaciondocs_puntoemision`,`pa_sriautorizaciondocs_establecimiento`,`noFacturaCompra`,`reversada_id`) USING BTREE,
  KEY `fk_facturacompra_tipopago1` (`tipopago_cod`) USING BTREE,
  KEY `fk_facturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_facturacompra_sustento1` (`sustento_cod`) USING BTREE,
  KEY `billing_facturacompra_ibfk_4` (`proveedor_id`) USING BTREE,
  KEY `billing_facturacompra_ibfk_5` (`cta_entrada`) USING BTREE,
  KEY `billing_facturacompra_ibfk_6` (`tipo`) USING BTREE,
  CONSTRAINT `billing_facturacompra_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturacompra_ibfk_2` FOREIGN KEY (`sustento_cod`) REFERENCES `billing_sustento` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturacompra_ibfk_3` FOREIGN KEY (`tipopago_cod`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturacompra_ibfk_4` FOREIGN KEY (`proveedor_id`) REFERENCES `billing_proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturacompra_ibfk_5` FOREIGN KEY (`cta_entrada`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturacompra_ibfk_6` FOREIGN KEY (`tipo`) REFERENCES `bill_compratipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=879 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_facturaventa
-- ----------------------------
DROP TABLE IF EXISTS `billing_facturaventa`;
CREATE TABLE `billing_facturaventa` (
  `codigofactventa` int(11) NOT NULL AUTO_INCREMENT,
  `nroAutorizacion` varchar(45) COLLATE utf8_bin NOT NULL,
  `fvenceautorizacion` date DEFAULT NULL,
  `secuenciafactventa` bigint(20) DEFAULT NULL,
  `descuentoporcent` float NOT NULL DEFAULT '0',
  `descuentovalor` float NOT NULL DEFAULT '0',
  `recargoporcent` float NOT NULL DEFAULT '0',
  `recargovalor` float NOT NULL DEFAULT '0',
  `fechaarchivada` date DEFAULT NULL,
  `horaarchivada` time DEFAULT NULL,
  `fechaCreacion` date NOT NULL,
  `hora` time DEFAULT NULL,
  `fechavencefact` date DEFAULT NULL,
  `subtotalBruto` float NOT NULL DEFAULT '0',
  `impuestoImportacion` float DEFAULT '0',
  `transporteporcent` float DEFAULT '0',
  `transporteval` float DEFAULT NULL,
  `subtotalNeto` float NOT NULL,
  `ivaporcent` float NOT NULL,
  `ivaval` float NOT NULL,
  `totalCompra` float NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `puntoventaempleado_empleado_cedulaRuc` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `puntoventaempleado_establecimiento` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `puntoventaempleado_puntoemision` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `puntoventaempleado_tiposcomprobante_cod` varchar(7) COLLATE utf8_bin DEFAULT NULL,
  `empleado_vendedor` varchar(128) COLLATE utf8_bin NOT NULL,
  `sustento_cod` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `cliente_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `valorrecibidoefectivo` float DEFAULT '0',
  `valorcambio` float DEFAULT '0',
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `tarifacerobruto` float NOT NULL DEFAULT '0',
  `tarifaceroneto` float NOT NULL DEFAULT '0',
  `tarifadocebruto` float NOT NULL DEFAULT '0',
  `tarifadoceneto` float NOT NULL DEFAULT '0',
  `subtbrutobienes` float NOT NULL DEFAULT '0',
  `subtbrutoservicios` float NOT NULL DEFAULT '0',
  `subtnetobienes` float NOT NULL DEFAULT '0',
  `subtnetoservicios` float NOT NULL DEFAULT '0',
  `iceval` float NOT NULL DEFAULT '0',
  `impverdeval` float NOT NULL DEFAULT '0',
  `efectivoval` float NOT NULL DEFAULT '0',
  `creditoval` float NOT NULL DEFAULT '0',
  `tarjcreditoval` float NOT NULL DEFAULT '0',
  `chequeval` float NOT NULL DEFAULT '0',
  `diferidoval` float NOT NULL DEFAULT '0',
  `anticipoval` double(255,2) NOT NULL DEFAULT '0.00',
  `baseiva` double(255,2) DEFAULT NULL,
  `bodega_id` int(11) DEFAULT NULL,
  `tipoprecio` varchar(28) COLLATE utf8_bin DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT ' 1 = pendiente, 2 = archivada, -1 = pendiente anulada, -2 = archivada anulada',
  `estado_observ` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estado_user` int(11) DEFAULT NULL,
  `estado_fecha` date DEFAULT NULL,
  `retencion_venta_id` int(11) DEFAULT NULL,
  `autorizado_sri` int(1) NOT NULL DEFAULT '0',
  `mensaje_sri` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL COMMENT 'Cuando es nota de credito, hace referencia a la factura de venta que se le aplico la nota de credito',
  `pagada` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Si se hizo la devulucion del valor de la nota de credito',
  `pagada_detalle` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `ndc_tipo_pago` int(11) DEFAULT NULL,
  `tipo_pago` tinyint(1) NOT NULL DEFAULT '1',
  `tecnico_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT '1',
  `cod_fact_electronica` varchar(250) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`codigofactventa`),
  UNIQUE KEY `idx_secuenciaunica` (`secuenciafactventa`,`puntoventaempleado_puntoemision`,`puntoventaempleado_establecimiento`) USING BTREE,
  KEY `fk_facturaventa_puntoventaempleado1` (`puntoventaempleado_empleado_cedulaRuc`,`puntoventaempleado_puntoemision`,`puntoventaempleado_establecimiento`,`puntoventaempleado_tiposcomprobante_cod`) USING BTREE,
  KEY `fk_facturaventa_empleado1` (`empleado_vendedor`) USING BTREE,
  KEY `fk_facturaventa_sustento1` (`sustento_cod`) USING BTREE,
  KEY `fk_facturaventa_cliente1` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_facturaventa_contacuentasplan1` (`contacuentasplan_cod`) USING BTREE,
  KEY `idx_fact` (`secuenciafactventa`) USING BTREE,
  KEY `fk_factventa_bodegaid1` (`bodega_id`) USING BTREE,
  KEY `fk_factventa_tipoprecio1` (`tipoprecio`) USING BTREE,
  CONSTRAINT `billing_facturaventa_ibfk_1` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturaventa_ibfk_2` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturaventa_ibfk_3` FOREIGN KEY (`tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=796 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_facturaventadetalle
-- ----------------------------
DROP TABLE IF EXISTS `billing_facturaventadetalle`;
CREATE TABLE `billing_facturaventadetalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facturaventa_codigofactventa` int(11) NOT NULL,
  `Producto_codigo` bigint(20) NOT NULL,
  `itemcantidad` int(11) NOT NULL,
  `itempreciobruto` float NOT NULL,
  `itemprecioneto` float NOT NULL,
  `itemprecioxcantidadbruto` float NOT NULL,
  `descuentofactporcent` float DEFAULT NULL,
  `descuentofactvalor` float DEFAULT NULL,
  `recargofactporcent` float DEFAULT NULL,
  `recargofactvalor` float DEFAULT NULL,
  `itemprecioxcantidadneto` float DEFAULT NULL,
  `ivaporcent` float DEFAULT NULL,
  `ivavalitemprecioneto` float DEFAULT NULL,
  `itemprecioiva` float DEFAULT NULL,
  `ivavalprecioxcantidadneto` float DEFAULT NULL,
  `itemxcantidadprecioiva` float DEFAULT NULL,
  `estaAnulada` int(11) DEFAULT '0',
  `bodega_id` int(11) NOT NULL,
  `tiposprecio_tipoprecio` varchar(28) COLLATE utf8_bin NOT NULL,
  `itembaseiva` double(255,2) DEFAULT NULL,
  `totitembaseiva` double(255,2) DEFAULT NULL,
  `iceporcent` double(255,2) DEFAULT NULL,
  `iceval` double(255,2) DEFAULT NULL,
  `priceice` double(255,2) DEFAULT NULL,
  `totalpriceice` double(255,2) DEFAULT NULL,
  `totivaval` double(255,2) DEFAULT NULL,
  `priceiva` double(255,2) DEFAULT NULL,
  `totalpriceiva` double(255,2) DEFAULT NULL,
  `detalle` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `meses_garantia` varchar(56) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_DetalleFacturaCompra_Producto1` (`Producto_codigo`) USING BTREE,
  KEY `fk_detallefacturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_facturaventadetalle_facturaventa1` (`facturaventa_codigofactventa`) USING BTREE,
  KEY `fk_facturaventadetalle_tiposprecio1` (`tiposprecio_tipoprecio`) USING BTREE,
  CONSTRAINT `billing_facturaventadetalle_ibfk_1` FOREIGN KEY (`facturaventa_codigofactventa`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturaventadetalle_ibfk_2` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturaventadetalle_ibfk_3` FOREIGN KEY (`Producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_facturaventadetalle_ibfk_4` FOREIGN KEY (`tiposprecio_tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1311 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_garante
-- ----------------------------
DROP TABLE IF EXISTS `billing_garante`;
CREATE TABLE `billing_garante` (
  `idGarante` int(11) NOT NULL AUTO_INCREMENT,
  `cedula` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `nombres` varchar(28) COLLATE utf8_bin DEFAULT NULL,
  `apellidos` varchar(28) COLLATE utf8_bin DEFAULT NULL,
  `telefono` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `celular` varchar(9) COLLATE utf8_bin DEFAULT NULL,
  `email` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`idGarante`),
  UNIQUE KEY `cedula_UNIQUE` (`cedula`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_marca
-- ----------------------------
DROP TABLE IF EXISTS `billing_marca`;
CREATE TABLE `billing_marca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=439 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_producto
-- ----------------------------
DROP TABLE IF EXISTS `billing_producto`;
CREATE TABLE `billing_producto` (
  `codigo` bigint(20) NOT NULL AUTO_INCREMENT,
  `codigo2` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `nombreUnico` varchar(128) COLLATE utf8_bin NOT NULL,
  `fotourl` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `descripcion` varchar(1500) COLLATE utf8_bin DEFAULT NULL,
  `existenciaMinima` int(5) NOT NULL DEFAULT '1' COMMENT 'Existencia minima 1 producto, -1 si no requiere existencia minima',
  `existenciaMaxima` int(5) DEFAULT '100',
  `stockactual` int(11) NOT NULL DEFAULT '0',
  `costopromediokardex` double(255,2) NOT NULL DEFAULT '0.00',
  `costoultimokardex` double(255,2) NOT NULL DEFAULT '0.00',
  `puedeVenderse` int(11) DEFAULT '1' COMMENT 'Por defecto sÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â­. Por ejemplo, los semielaborados o productos intermedios en fabricaciÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â³n podrÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â­an no ser vendibles. Herramientas, disolventes... productos utilizados por la empresa que no existen en el catÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡logo y que se quieran configurar en el sistema, se d',
  `puedeComprarse` int(11) DEFAULT '1' COMMENT 'Por defecto sÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â­. HabrÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡ productos que nunca sean comprados, por ejemplo, porque los fabricamos nosotros.',
  `deAlquiler` int(11) DEFAULT '0' COMMENT 'Para productos que serÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡n puestos en alquiler.',
  `coloresDisponibles` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'Aqui se activan los distintos colores disponibles de ese producto, ejm. Portatil: roja, negra, azul ... ',
  `tallasDisponibles` varchar(500) COLLATE utf8_bin DEFAULT NULL COMMENT 'Ejm. Talla S, talla L, ...',
  `fechacreacion` date DEFAULT NULL,
  `fechaultactualizacion` datetime DEFAULT NULL,
  `esServicio` int(1) DEFAULT '0',
  `productogrupo_codigo` int(11) NOT NULL,
  `marca_id` int(11) NOT NULL,
  `productotipo_id` int(11) NOT NULL,
  `ivaporcent` float NOT NULL DEFAULT '12',
  `iceporcent` float NOT NULL DEFAULT '0',
  `impverdeporcent` float NOT NULL DEFAULT '0',
  `otroimpuestoporcent` float NOT NULL DEFAULT '0',
  `descmaxporcent` double(255,2) NOT NULL DEFAULT '0.00' COMMENT 'el descuento es relativo al precio de venta, PA, PB, ...',
  `codbarras1` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `codbarras2` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `codbarras3` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `descuentomaximoporcentunico` float DEFAULT '0' COMMENT 'es unico, solamente respecto al precio A',
  `pvppromo` double(255,2) NOT NULL DEFAULT '0.00',
  `finpvppromo` date DEFAULT NULL,
  `ajuste1` double(255,5) NOT NULL DEFAULT '0.00000',
  `ajuste2` double(255,5) NOT NULL DEFAULT '0.00000',
  `ajuste2cuantos` int(255) NOT NULL DEFAULT '0' COMMENT 'esta cantidad se ba disminuyendo en 1 cada vez q se baja en stock',
  `es_promo` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `nombreUnico_UNIQUE` (`nombreUnico`) USING BTREE,
  KEY `fk_producto_productogrupo1` (`productogrupo_codigo`) USING BTREE,
  KEY `fk_producto_marca1` (`marca_id`) USING BTREE,
  KEY `fk_producto_productotipo1` (`productotipo_id`) USING BTREE,
  CONSTRAINT `billing_producto_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `billing_marca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_producto_ibfk_2` FOREIGN KEY (`productogrupo_codigo`) REFERENCES `billing_productogrupo` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_producto_ibfk_3` FOREIGN KEY (`productotipo_id`) REFERENCES `billing_productotipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=14138 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_productogrupo
-- ----------------------------
DROP TABLE IF EXISTS `billing_productogrupo`;
CREATE TABLE `billing_productogrupo` (
  `codigo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `vista_web` int(1) DEFAULT '1',
  `meses_garantia` int(5) DEFAULT NULL,
  `activo` int(1) DEFAULT '1',
  `parent` int(3) NOT NULL DEFAULT '0',
  PRIMARY KEY (`codigo`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_productotipo
-- ----------------------------
DROP TABLE IF EXISTS `billing_productotipo`;
CREATE TABLE `billing_productotipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(28) COLLATE utf8_bin NOT NULL COMMENT '    Almacenable: Se definen de este tipo los productos cuya reposiciÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¾Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¾ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â¦ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Â¦Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â³n debe ser mÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¾Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¾ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬ÃƒÂ¢Ã¢â‚¬Å¾Ã‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã‚Â¦ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã¢â‚¬Â ÃƒÂ¢Ã¢â€šÂ¬Ã¢â€žÂ¢ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Â¦Ãƒâ€šÃ‚Â¡ÃƒÆ’Ã†â€™Ãƒâ€ Ã¢â‚¬â„¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â‚¬Å¡Ã‚Â¬Ãƒâ€¦Ã‚Â¡ÃƒÆ’Ã†â€™ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â¡s o meno',
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estaActivo` int(1) DEFAULT '1',
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombreProductoTipo_UNIQUE` (`nombre`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_proveedor
-- ----------------------------
DROP TABLE IF EXISTS `billing_proveedor`;
CREATE TABLE `billing_proveedor` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `es_pasaporte` tinyint(1) NOT NULL DEFAULT '0',
  `PersonaComercio_cedulaRuc` varchar(45) COLLATE utf8_bin NOT NULL,
  `nombres` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `apellidos` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `razonsocial` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `pais` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `ciudad` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `diasCredito` int(3) DEFAULT NULL,
  `comentarios` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin NOT NULL DEFAULT '201030101',
  `proveedortipo_id` int(11) DEFAULT NULL,
  `email` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `telefonos` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `celular` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `docidentificacion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_proveedor_contacuentasplan1` (`contacuentasplan_cod`) USING BTREE,
  KEY `fk_proveedortipo` (`proveedortipo_id`) USING BTREE,
  KEY `fk_provdocidentiftipo` (`docidentificacion_id`) USING BTREE,
  KEY `fk_Proveedor_PersonaComercio1` (`PersonaComercio_cedulaRuc`) USING BTREE,
  CONSTRAINT `billing_proveedor_ibfk_1` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_proveedor_ibfk_2` FOREIGN KEY (`docidentificacion_id`) REFERENCES `billing_docidentificaciontipo` (`iddocidentificaciontipo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_proveedor_ibfk_3` FOREIGN KEY (`proveedortipo_id`) REFERENCES `bill_proveedortipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1664 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_proveedortiposcomprobante
-- ----------------------------
DROP TABLE IF EXISTS `billing_proveedortiposcomprobante`;
CREATE TABLE `billing_proveedortiposcomprobante` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor_PersonaComercio_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `establecimiento` varchar(3) COLLATE utf8_bin NOT NULL,
  `puntoemision` varchar(3) COLLATE utf8_bin NOT NULL,
  `numautorizacion` varchar(45) COLLATE utf8_bin NOT NULL,
  `fvencimiento` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numautorizacion_UNIQUE` (`numautorizacion`) USING BTREE,
  UNIQUE KEY `idx_primarykey` (`proveedor_PersonaComercio_cedulaRuc`,`tiposcomprobante_cod`,`establecimiento`,`puntoemision`) USING BTREE,
  KEY `fk_proveedor_has_tiposcomprobante_tiposcomprobante1` (`tiposcomprobante_cod`) USING BTREE,
  KEY `fk_proveedor_has_tiposcomprobante_proveedor1` (`proveedor_PersonaComercio_cedulaRuc`) USING BTREE,
  CONSTRAINT `billing_proveedortiposcomprobante_ibfk_1` FOREIGN KEY (`proveedor_PersonaComercio_cedulaRuc`) REFERENCES `billing_proveedor` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_proveedortiposcomprobante_ibfk_2` FOREIGN KEY (`tiposcomprobante_cod`) REFERENCES `billing_tiposcomprobante` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_puntoventaempleado
-- ----------------------------
DROP TABLE IF EXISTS `billing_puntoventaempleado`;
CREATE TABLE `billing_puntoventaempleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `puntoemision` varchar(3) COLLATE utf8_bin NOT NULL,
  `establecimiento` varchar(3) COLLATE utf8_bin NOT NULL,
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `nroautorizacion` varchar(45) COLLATE utf8_bin NOT NULL,
  `fvenceautorizacion` date NOT NULL,
  `fcreacionpunto` date NOT NULL,
  `secuenciainicial` bigint(20) NOT NULL,
  `secuenciaultima` bigint(20) NOT NULL,
  `dirfisicaequipo` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `bodega_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`puntoemision`,`establecimiento`,`tiposcomprobante_cod`) USING BTREE,
  KEY `fk_puntoventa_tiposcomprobante1` (`tiposcomprobante_cod`) USING BTREE,
  KEY `fk_pv_bodega_id1` (`bodega_id`) USING BTREE,
  CONSTRAINT `billing_puntoventaempleado_ibfk_1` FOREIGN KEY (`tiposcomprobante_cod`) REFERENCES `billing_tiposcomprobante` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_puntoventaempleado_ibfk_2` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_stockbodega
-- ----------------------------
DROP TABLE IF EXISTS `billing_stockbodega`;
CREATE TABLE `billing_stockbodega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bodega_id` int(11) NOT NULL,
  `producto_codigo` bigint(20) NOT NULL,
  `stock` float DEFAULT NULL,
  `fultimact` datetime DEFAULT NULL,
  `descuentomaxporcent` float DEFAULT '0' COMMENT 'este es relativo al precio de venta, precio A, precio B, ...',
  `descuentomaxporcentunico` float DEFAULT '0' COMMENT 'este es un solo descuento relativo al precio mayor PA',
  PRIMARY KEY (`id`),
  KEY `fk_bodega_has_stock_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_stockbodega_producto1` (`producto_codigo`) USING BTREE,
  CONSTRAINT `billing_stockbodega_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_stockbodega_ibfk_2` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3515 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_sucursal
-- ----------------------------
DROP TABLE IF EXISTS `billing_sucursal`;
CREATE TABLE `billing_sucursal` (
  `idSucursal` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) COLLATE utf8_bin NOT NULL,
  `pais` varchar(28) COLLATE utf8_bin NOT NULL DEFAULT 'Ecuador',
  `ciudad` varchar(28) COLLATE utf8_bin NOT NULL,
  `direccion` varchar(256) COLLATE utf8_bin NOT NULL,
  `telefono` varchar(45) COLLATE utf8_bin NOT NULL,
  `email` varchar(45) COLLATE utf8_bin NOT NULL DEFAULT '@',
  `sitioWeb` varchar(45) COLLATE utf8_bin DEFAULT 'http://',
  `prefix` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `fechaRegistroSucursal` date DEFAULT NULL,
  `estaActiva` int(1) DEFAULT NULL,
  `empresa_ruc` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`idSucursal`),
  KEY `fk_sucursal_empresa1` (`empresa_ruc`) USING BTREE,
  CONSTRAINT `billing_sucursal_ibfk_1` FOREIGN KEY (`empresa_ruc`) REFERENCES `billing_empresa` (`ruc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_sustento
-- ----------------------------
DROP TABLE IF EXISTS `billing_sustento`;
CREATE TABLE `billing_sustento` (
  `cod` varchar(5) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `tipocomprobante` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_tarjetacredito
-- ----------------------------
DROP TABLE IF EXISTS `billing_tarjetacredito`;
CREATE TABLE `billing_tarjetacredito` (
  `cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `banco_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`cod`),
  KEY `billing_tarjetacredito_fk_1` (`banco_id`) USING BTREE,
  CONSTRAINT `billing_tarjetacredito_ibfk_1` FOREIGN KEY (`banco_id`) REFERENCES `billing_banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_tipopago
-- ----------------------------
DROP TABLE IF EXISTS `billing_tipopago`;
CREATE TABLE `billing_tipopago` (
  `cod` varchar(3) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(56) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `alias` varchar(56) COLLATE utf8_bin DEFAULT NULL,
  `estaactivo` tinyint(1) NOT NULL DEFAULT '1',
  `contacuentasplan_codventa` varchar(12) COLLATE utf8_bin NOT NULL,
  `cta_pago_compras` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cod`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`) USING BTREE,
  KEY `fk_tipopago_contacuentasplan1` (`contacuentasplan_codventa`) USING BTREE,
  KEY `billing_tipopago_ibfk_2` (`cta_pago_compras`) USING BTREE,
  CONSTRAINT `billing_tipopago_ibfk_1` FOREIGN KEY (`contacuentasplan_codventa`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_tipopago_ibfk_2` FOREIGN KEY (`cta_pago_compras`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_tiposcomprobante
-- ----------------------------
DROP TABLE IF EXISTS `billing_tiposcomprobante`;
CREATE TABLE `billing_tiposcomprobante` (
  `cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `estaactivo` int(1) DEFAULT '1',
  `codsecuencialestrans` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `sustentotributario` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `vigenciadesde` date DEFAULT NULL,
  `vigenciahasta` date DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_tiposprecio
-- ----------------------------
DROP TABLE IF EXISTS `billing_tiposprecio`;
CREATE TABLE `billing_tiposprecio` (
  `tipoprecio` varchar(28) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`tipoprecio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_tipotransaccion
-- ----------------------------
DROP TABLE IF EXISTS `billing_tipotransaccion`;
CREATE TABLE `billing_tipotransaccion` (
  `cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `nombre` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_transferenciasxaprobar
-- ----------------------------
DROP TABLE IF EXISTS `billing_transferenciasxaprobar`;
CREATE TABLE `billing_transferenciasxaprobar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` float DEFAULT NULL,
  `transfnro` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `transfctacliente` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `transfctaempresa` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `bancos_cod` varchar(3) COLLATE utf8_bin NOT NULL,
  `cliente_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `fechatransf` date DEFAULT NULL,
  `aprovado` int(1) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `empleado_usercedulaRuc` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_transferenciasxaprobar_bancos1` (`bancos_cod`) USING BTREE,
  KEY `fk_transferenciasxaprobar_cliente1` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_transferenciasxaprobar_empleado1` (`empleado_usercedulaRuc`) USING BTREE,
  CONSTRAINT `billing_transferenciasxaprobar_ibfk_1` FOREIGN KEY (`cliente_cedulaRuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_transferenciasxaprobar_ibfk_2` FOREIGN KEY (`empleado_usercedulaRuc`) REFERENCES `billing_empleado` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for billing_ventaservicioshistorial
-- ----------------------------
DROP TABLE IF EXISTS `billing_ventaservicioshistorial`;
CREATE TABLE `billing_ventaservicioshistorial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_codigo` bigint(20) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `itemcantidadentrada` int(11) DEFAULT '0',
  `itempreciobruto` float DEFAULT NULL,
  `itemprecioneto` float DEFAULT NULL,
  `itemprecioxcantidadneto` float DEFAULT NULL,
  `factualizacion` datetime NOT NULL COMMENT 'Fecha de ultima actualizacion',
  `estaanulado` int(1) DEFAULT '0',
  `facturaventa_codigofactventa` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_StockHistorial_Producto1` (`producto_codigo`) USING BTREE,
  KEY `fk_stockhistorial_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_ventaservicioshistorial_facturaventa1` (`facturaventa_codigofactventa`) USING BTREE,
  CONSTRAINT `billing_ventaservicioshistorial_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_ventaservicioshistorial_ibfk_2` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `billing_ventaservicioshistorial_ibfk_3` FOREIGN KEY (`facturaventa_codigofactventa`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_activosfijoshist
-- ----------------------------
DROP TABLE IF EXISTS `bill_activosfijoshist`;
CREATE TABLE `bill_activosfijoshist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_codigo` bigint(20) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `entrada` int(11) DEFAULT '0',
  `price` double(255,5) DEFAULT NULL,
  `priceneto` double(255,5) DEFAULT NULL,
  `ivaval` double(255,5) DEFAULT NULL,
  `totalpriceneto` double(255,5) DEFAULT NULL COMMENT 'el total que cuesta el producto sin incluir el iva',
  `totivaval` double(255,5) NOT NULL DEFAULT '0.00000',
  `totalpriceiva` double(255,5) DEFAULT NULL COMMENT 'el total que cuesta el producto incluido el iva',
  `factualizacion` date NOT NULL COMMENT 'Fecha de ultima actualizacion',
  `anulado` tinyint(1) DEFAULT '0',
  `facturacompra_codigoFacturaCompra` int(11) NOT NULL,
  `departamentoid` int(11) DEFAULT NULL,
  `anio` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_StockHistorial_Producto1` (`producto_codigo`) USING BTREE,
  KEY `fk_stockhistorial_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_gastoshistorial_facturacompra1` (`facturacompra_codigoFacturaCompra`) USING BTREE,
  KEY `fk_gastoshistorial_departamento1_idx` (`departamentoid`) USING BTREE,
  CONSTRAINT `bill_activosfijoshist_ibfk_1` FOREIGN KEY (`departamentoid`) REFERENCES `billing_departamento` (`idDepartamento`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_activosfijoshist_ibfk_2` FOREIGN KEY (`facturacompra_codigoFacturaCompra`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_activosfijoshist_ibfk_3` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_activosfijoshist_ibfk_4` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_ajustentrada
-- ----------------------------
DROP TABLE IF EXISTS `bill_ajustentrada`;
CREATE TABLE `bill_ajustentrada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `total` double(255,2) NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `fecha_anulada` datetime DEFAULT NULL,
  `user_anulacion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `user_registra` varchar(45) COLLATE utf8_bin NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `sustento_cod` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `ivaporcent` double(255,2) NOT NULL DEFAULT '12.00',
  `subtbienes` double(255,2) NOT NULL DEFAULT '0.00',
  `subtservicios` double(255,2) NOT NULL DEFAULT '0.00',
  `tipo` int(11) NOT NULL DEFAULT '1' COMMENT '1 = Ajuste Inicial, 2 = Compra sin factura, 3 = Para igualar con ajuste de salida',
  `proveedor_id` int(11) DEFAULT NULL,
  `estado` tinyint(2) NOT NULL DEFAULT '1' COMMENT '-1 = anulado, 1 = activo ( sin reg. asiento contable ), 2 = activo ( reg. asiento contable )',
  PRIMARY KEY (`id`),
  KEY `fk_facturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_facturacompra_sustento1` (`sustento_cod`) USING BTREE,
  KEY `billing_facturacompra_ibfk_4` (`proveedor_id`) USING BTREE,
  CONSTRAINT `bill_ajustentrada_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustentrada_ibfk_2` FOREIGN KEY (`sustento_cod`) REFERENCES `billing_sustento` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustentrada_ibfk_3` FOREIGN KEY (`proveedor_id`) REFERENCES `billing_proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_ajustentradadet
-- ----------------------------
DROP TABLE IF EXISTS `bill_ajustentradadet`;
CREATE TABLE `bill_ajustentradadet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ajustentrada_id` int(11) NOT NULL,
  `Producto_codigo` bigint(20) NOT NULL,
  `itemcantidad` int(11) NOT NULL,
  `itemcosto` double(255,2) NOT NULL,
  `itemcostoxcantidad` double(255,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT '-1 => anulada, 1 => activa',
  `bodega_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_FacturaCompra_has_Producto_FacturaCompra1` (`ajustentrada_id`) USING BTREE,
  KEY `fk_DetalleFacturaCompra_Producto1` (`Producto_codigo`) USING BTREE,
  KEY `fk_detallefacturacompra_bodega1` (`bodega_id`) USING BTREE,
  CONSTRAINT `bill_ajustentradadet_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustentradadet_ibfk_2` FOREIGN KEY (`Producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustentradadet_ibfk_3` FOREIGN KEY (`ajustentrada_id`) REFERENCES `bill_ajustentrada` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_ajustesalida
-- ----------------------------
DROP TABLE IF EXISTS `bill_ajustesalida`;
CREATE TABLE `bill_ajustesalida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `total` double(255,2) NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `fecha_anulada` datetime DEFAULT NULL,
  `user_anulacion` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `user_registra` varchar(45) COLLATE utf8_bin NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `sustento_cod` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `ivaporcent` double(255,2) NOT NULL DEFAULT '12.00',
  `subtbienes` double(255,2) NOT NULL DEFAULT '0.00',
  `subtservicios` double(255,2) NOT NULL DEFAULT '0.00',
  `tipo` int(11) NOT NULL DEFAULT '1' COMMENT '1 = Ajuste Inicial, 2 = Compra sin factura, 3 = Para igualar con ajuste de salida',
  `proveedor_id` int(11) DEFAULT NULL,
  `estado` tinyint(2) NOT NULL DEFAULT '1' COMMENT '-1 = anulado, 1 = activo ( sin reg. asiento contable ), 2 = activo ( reg. asiento contable )',
  `ajustentrada_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_facturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_facturacompra_sustento1` (`sustento_cod`) USING BTREE,
  KEY `billing_facturacompra_ibfk_4` (`proveedor_id`) USING BTREE,
  KEY `bill_ajustesalida_ibfk_4` (`ajustentrada_id`) USING BTREE,
  CONSTRAINT `bill_ajustesalida_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustesalida_ibfk_2` FOREIGN KEY (`sustento_cod`) REFERENCES `billing_sustento` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustesalida_ibfk_4` FOREIGN KEY (`ajustentrada_id`) REFERENCES `bill_ajustentrada` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_ajustesalidadet
-- ----------------------------
DROP TABLE IF EXISTS `bill_ajustesalidadet`;
CREATE TABLE `bill_ajustesalidadet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ajustesalida_id` int(11) DEFAULT NULL,
  `Producto_codigo` bigint(20) NOT NULL,
  `itemcantidad` int(11) NOT NULL,
  `itemcosto` double(255,2) NOT NULL,
  `itemcostoxcantidad` double(255,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT '-1 => anulada, 1 => activa',
  `bodega_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_DetalleFacturaCompra_Producto1` (`Producto_codigo`) USING BTREE,
  KEY `fk_detallefacturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `bill_ajustesalidadet_ibfk_3` (`ajustesalida_id`) USING BTREE,
  CONSTRAINT `bill_ajustesalidadet_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustesalidadet_ibfk_2` FOREIGN KEY (`Producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ajustesalidadet_ibfk_3` FOREIGN KEY (`ajustesalida_id`) REFERENCES `bill_ajustesalida` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_asiento_contable
-- ----------------------------
DROP TABLE IF EXISTS `bill_asiento_contable`;
CREATE TABLE `bill_asiento_contable` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` varchar(4) NOT NULL,
  `mes_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1',
  `user_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `cierre_id` int(11) DEFAULT NULL,
  `detalle` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bill_asiento_contable_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_asiento_contable_det`;
CREATE TABLE `bill_asiento_contable_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `asiento_contable_id` int(11) NOT NULL,
  `cuenta_cont_id` int(11) NOT NULL,
  `debito` double(255,2) NOT NULL,
  `credito` double(255,2) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `detalle` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=194 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bill_bancoslist
-- ----------------------------
DROP TABLE IF EXISTS `bill_bancoslist`;
CREATE TABLE `bill_bancoslist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banco` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_banco` (`banco`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_bodegaempleado
-- ----------------------------
DROP TABLE IF EXISTS `bill_bodegaempleado`;
CREATE TABLE `bill_bodegaempleado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_bodega` int(11) NOT NULL,
  `id_empleado` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_chequescustodio
-- ----------------------------
DROP TABLE IF EXISTS `bill_chequescustodio`;
CREATE TABLE `bill_chequescustodio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valorcheque` float DEFAULT NULL,
  `nrocheque` varchar(45) COLLATE utf8_bin NOT NULL,
  `nrocuentacheque` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `fechacobro` date DEFAULT NULL,
  `lugar` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `depositado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `fechacambioestado` date DEFAULT NULL,
  `horacambioestado` time DEFAULT NULL,
  `cliente_cedulaRuc` varchar(128) COLLATE utf8_bin NOT NULL,
  `contaasientocontable_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `bancolist_id` int(11) NOT NULL,
  `docid` bigint(20) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `empleado_id` int(11) NOT NULL,
  `nombre_beneficiario` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `estado_info` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`nrocheque`,`cliente_cedulaRuc`,`bancolist_id`) USING BTREE,
  KEY `fk_chequescustodio_cliente1_idx` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_chequescustodio_contaasientocontable1_idx` (`contaasientocontable_id`) USING BTREE,
  KEY `fk_chequescustodio_tipotransaccion1_idx` (`tipotransaccion_cod`) USING BTREE,
  KEY `fk_bancoslist` (`bancolist_id`) USING BTREE,
  KEY `fk_chequescust_empleadoid` (`empleado_id`) USING BTREE,
  CONSTRAINT `bill_chequescustodio_ibfk_1` FOREIGN KEY (`cliente_cedulaRuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_chequescustodio_ibfk_2` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_chequescustodio_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_chequescustodio_ibfk_4` FOREIGN KEY (`bancolist_id`) REFERENCES `bill_bancoslist` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_chequescustodio_ibfk_5` FOREIGN KEY (`empleado_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='este es el estado del cheque.. \r\nEjemplo:\r\n\r\n0 -> en custodio\r\n1 -> cobrado\r\n2 -> protestado , ...';

-- ----------------------------
-- Table structure for bill_cheque_pago
-- ----------------------------
DROP TABLE IF EXISTS `bill_cheque_pago`;
CREATE TABLE `bill_cheque_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nro` varchar(255) NOT NULL,
  `fecha_emision` date NOT NULL,
  `hora_emision` time NOT NULL,
  `fecha_cobro` date NOT NULL,
  `lugar` varchar(25) NOT NULL,
  `nombre_beneficiario` varchar(128) NOT NULL,
  `banco_id` int(11) NOT NULL,
  `valor` double(255,2) NOT NULL,
  `comprobante_id` int(11) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT 'por default 1 => activo, -1 => anulado',
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `doc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_cheque_pago_fk_1` (`banco_id`) USING BTREE,
  CONSTRAINT `bill_cheque_pago_ibfk_1` FOREIGN KEY (`banco_id`) REFERENCES `billing_banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cierrecaja
-- ----------------------------
DROP TABLE IF EXISTS `bill_cierrecaja`;
CREATE TABLE `bill_cierrecaja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `empleado` varchar(13) COLLATE utf8_bin NOT NULL,
  `usuario` varchar(13) COLLATE utf8_bin NOT NULL,
  `totdebe` double NOT NULL,
  `tothaber` double NOT NULL,
  `sobrante` double NOT NULL,
  `faltante` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cierre_caja
-- ----------------------------
DROP TABLE IF EXISTS `bill_cierre_caja`;
CREATE TABLE `bill_cierre_caja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ventas_contado` float(255,2) DEFAULT NULL,
  `ventas_credito` float(255,2) DEFAULT NULL,
  `recaudacion` float(255,2) DEFAULT NULL,
  `flujo_efectivo` float(255,2) DEFAULT NULL,
  `existe_efectivo` float(255,2) DEFAULT NULL,
  `faltante_efectivo` float(255,2) DEFAULT NULL,
  `total_ventas` float(255,2) DEFAULT NULL,
  `resumen_transacciones` float(255,2) DEFAULT NULL,
  `fecha_ini` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `user` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cliente_anticipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_cliente_anticipo`;
CREATE TABLE `bill_cliente_anticipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo` double(255,2) NOT NULL,
  `saldo` double(255,2) NOT NULL,
  `saldo_ultimo` double(255,2) NOT NULL,
  `client_id` varchar(128) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `empleado_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT 'por default .. activo',
  `anticipo_anulado_id` int(11) DEFAULT NULL COMMENT 'lo relaciono con esta misma tabla, para cuando se anula anticipo',
  `detalle_anulacion` varchar(500) DEFAULT NULL,
  `user_id_anulacion` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cliente_anticipo_tipopago
-- ----------------------------
DROP TABLE IF EXISTS `bill_cliente_anticipo_tipopago`;
CREATE TABLE `bill_cliente_anticipo_tipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `valor` double(255,2) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `doc_pago_id` int(11) NOT NULL COMMENT 'puede ser id de cheque, transferencia, etc',
  PRIMARY KEY (`id`),
  KEY `fx_ventatipopago_ventaid` (`anticipo_id`) USING BTREE,
  KEY `fk_ventatipopago_tipopago` (`tipopago_id`) USING BTREE,
  CONSTRAINT `bill_cliente_anticipo_tipopago_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_compratipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_compratipo`;
CREATE TABLE `bill_compratipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(25) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_compratipopago
-- ----------------------------
DROP TABLE IF EXISTS `bill_compratipopago`;
CREATE TABLE `bill_compratipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `valor` double(255,2) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ventatipopago_tipopago` (`tipopago_id`) USING BTREE,
  KEY `bill_compratipopago_ibfk_2` (`compra_id`) USING BTREE,
  CONSTRAINT `bill_compratipopago_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_compratipopago_ibfk_2` FOREIGN KEY (`compra_id`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_comprobanteingreso
-- ----------------------------
DROP TABLE IF EXISTS `bill_comprobanteingreso`;
CREATE TABLE `bill_comprobanteingreso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` varchar(4) NOT NULL,
  `fecha` date NOT NULL,
  `valortotal` double(255,5) NOT NULL,
  `cliente_id` varchar(13) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `tipotransaccion_cod` varchar(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `tiposcomprobante_cod` varchar(7) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `nota` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_comprobanteingreso_billing_cliente1_idx` (`cliente_id`) USING BTREE,
  KEY `fk_bill_comprobanteingreso_billing_tipotransaccion1_idx` (`tipotransaccion_cod`) USING BTREE,
  KEY `fk_bill_comprobanteingreso_billing_tiposcomprobante1_idx` (`tiposcomprobante_cod`) USING BTREE,
  CONSTRAINT `bill_comprobanteingreso_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_comprobanteingreso_ibfk_2` FOREIGN KEY (`tiposcomprobante_cod`) REFERENCES `billing_tiposcomprobante` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_comprobanteingreso_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_comprob_pago
-- ----------------------------
DROP TABLE IF EXISTS `bill_comprob_pago`;
CREATE TABLE `bill_comprob_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` varchar(4) NOT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `client_id` varchar(128) DEFAULT NULL,
  `empleado_id` int(11) DEFAULT NULL,
  `nota` varchar(255) DEFAULT NULL,
  `doc_id` int(11) DEFAULT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `lugar` varchar(45) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=298 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_comprob_pago_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_comprob_pago_det`;
CREATE TABLE `bill_comprob_pago_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comprob_pago_id` int(11) NOT NULL,
  `detalle` varchar(255) NOT NULL,
  `debito` double(255,2) NOT NULL,
  `credito` double(255,2) NOT NULL,
  `cta_contable` varchar(25) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `tipopago_cod` varchar(3) NOT NULL,
  `doc_nro` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=614 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_comprob_pago_tipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_comprob_pago_tipo`;
CREATE TABLE `bill_comprob_pago_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(25) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_contasientotipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_contasientotipo`;
CREATE TABLE `bill_contasientotipo` (
  `id` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  `descripcion` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_contribuyente
-- ----------------------------
DROP TABLE IF EXISTS `bill_contribuyente`;
CREATE TABLE `bill_contribuyente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `clase` varchar(20) NOT NULL,
  `resolucion` varchar(50) NOT NULL,
  `contabilidad` varchar(2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_contribuyente_clase
-- ----------------------------
DROP TABLE IF EXISTS `bill_contribuyente_clase`;
CREATE TABLE `bill_contribuyente_clase` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clase` varchar(25) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_contribuyente_tipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_contribuyente_tipo`;
CREATE TABLE `bill_contribuyente_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(25) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_costoshist
-- ----------------------------
DROP TABLE IF EXISTS `bill_costoshist`;
CREATE TABLE `bill_costoshist` (
  `id` int(11) NOT NULL,
  `costopromedio` double(255,2) NOT NULL,
  `costoultimo` double(255,2) NOT NULL,
  `compra_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `usuario` varchar(45) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_costohist_fk_1` (`compra_id`) USING BTREE,
  CONSTRAINT `bill_costoshist_ibfk_1` FOREIGN KEY (`compra_id`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_costoventaprod
-- ----------------------------
DROP TABLE IF EXISTS `bill_costoventaprod`;
CREATE TABLE `bill_costoventaprod` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `qty` double(255,2) NOT NULL,
  `costoventaunit` double NOT NULL,
  `precioventaunit` double NOT NULL COMMENT 'sin iva',
  `utilidadunit` double NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `anulada` tinyint(1) NOT NULL DEFAULT '0',
  `producto_codigo` bigint(20) NOT NULL,
  `contaasientocontable_id` int(11) DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_costoventaprod_billing_producto1_idx` (`producto_codigo`) USING BTREE,
  KEY `fk_bill_costoventaprod_billing_contaasientocontable1_idx` (`contaasientocontable_id`) USING BTREE,
  KEY `bill_costoventaprod_ibfk_4` (`venta_id`) USING BTREE,
  CONSTRAINT `bill_costoventaprod_ibfk_1` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_costoventaprod_ibfk_2` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_costoventaprod_ibfk_3` FOREIGN KEY (`venta_id`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cotizacionventadetalle_x
-- ----------------------------
DROP TABLE IF EXISTS `bill_cotizacionventadetalle_x`;
CREATE TABLE `bill_cotizacionventadetalle_x` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_codigo` bigint(20) NOT NULL,
  `qty` int(11) NOT NULL COMMENT 'cantidad de productos',
  `price` double(255,5) NOT NULL COMMENT 'precio unitario antes de aplicar descuentos y recargos',
  `total` double(255,5) NOT NULL COMMENT 'total antes de aplicar descuento y recargos',
  `desctoporcent` double(255,5) DEFAULT NULL,
  `totaldesctoval` double(255,5) DEFAULT NULL COMMENT 'descuento aplicado a la factura, desglosado al total de productos x cantidad',
  `recargoporcent` double(255,5) DEFAULT NULL COMMENT 'el recargo aplicado a la factura, en porcentaje se calcula para cada producto',
  `cotizacionventa_id` int(11) NOT NULL,
  `totalrecargoval` double(255,5) DEFAULT NULL COMMENT 'valor que se aplica de recargo al total de productos x cantidad',
  `priceneto` double(255,5) NOT NULL COMMENT 'precio ya aplicando descuentos y recargos',
  `totalpriceneto` double(255,5) DEFAULT NULL COMMENT 'precio x cantidad aplicando ya descuentos y recargos',
  `ivaporcent` double(255,5) DEFAULT NULL,
  `ivaval` double(255,5) DEFAULT NULL COMMENT 'iva por cada producto',
  `priceiva` double(255,5) DEFAULT NULL COMMENT 'precio producto + iva = priceiva',
  `totivaval` double(255,5) DEFAULT NULL COMMENT 'iva de (precioproducto *  cantidad)',
  `totalpriceiva` double DEFAULT NULL,
  `estaAnulada` int(11) DEFAULT '0',
  `tiposprecio_tipoprecio` varchar(28) COLLATE utf8_bin NOT NULL,
  `pricerecargoval` double(255,5) DEFAULT NULL COMMENT 'valor del recargo al precio unitoario',
  `pricedesctoval` double(255,5) DEFAULT NULL COMMENT 'valor del descuento al precio unitoario',
  `iceporcent` double(255,5) DEFAULT NULL,
  `iceval` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `priceice` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `toticeval` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `totalpriceice` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_DetalleFacturaCompra_Producto1` (`producto_codigo`) USING BTREE,
  KEY `fk_facturaventadetalle_tiposprecio1` (`tiposprecio_tipoprecio`) USING BTREE,
  KEY `fk_billing_proformaventadetalle_billing_proformaventa_1` (`cotizacionventa_id`) USING BTREE,
  CONSTRAINT `bill_cotizacionventadetalle_x_ibfk_1` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`),
  CONSTRAINT `bill_cotizacionventadetalle_x_ibfk_2` FOREIGN KEY (`tiposprecio_tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`),
  CONSTRAINT `bill_cotizacionventadetalle_x_ibfk_3` FOREIGN KEY (`cotizacionventa_id`) REFERENCES `bill_cotizacionventa_x` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cotizacionventa_x
-- ----------------------------
DROP TABLE IF EXISTS `bill_cotizacionventa_x`;
CREATE TABLE `bill_cotizacionventa_x` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descuentoporcent` double(255,5) NOT NULL DEFAULT '0.00000',
  `descuentovalor` double(255,5) NOT NULL DEFAULT '0.00000',
  `recargoporcent` double(255,5) NOT NULL DEFAULT '0.00000',
  `recargovalor` double(255,5) NOT NULL DEFAULT '0.00000',
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `subtotalBruto` double(255,5) NOT NULL DEFAULT '0.00000',
  `impuestoImportacion` double(255,5) DEFAULT '0.00000',
  `transporteporcent` double(255,5) DEFAULT '0.00000',
  `transporteval` double(255,5) DEFAULT NULL,
  `subtotalNeto` double(255,5) NOT NULL,
  `baseiva` double(255,5) NOT NULL COMMENT 'base imponible sobre la cual se aplica el iva -- subtotal + ice',
  `ivaporcent` double(255,5) NOT NULL,
  `ivaval` double(255,5) NOT NULL,
  `totalCompra` double(255,5) NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `anulada` tinyint(1) DEFAULT '0',
  `empleado_vendedor` varchar(128) COLLATE utf8_bin NOT NULL,
  `cliente_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `tarifacerobruto` double(255,5) NOT NULL DEFAULT '0.00000',
  `tarifaceroneto` double(255,5) NOT NULL DEFAULT '0.00000',
  `tarifadocebruto` double(255,5) NOT NULL DEFAULT '0.00000',
  `tarifadoceneto` double(255,5) NOT NULL DEFAULT '0.00000',
  `subtbrutobienes` double(255,5) NOT NULL DEFAULT '0.00000',
  `subtnetobienes` double(255,5) NOT NULL DEFAULT '0.00000',
  `subtbrutoservicios` double(255,5) NOT NULL DEFAULT '0.00000',
  `subtnetoservicios` double(255,5) NOT NULL DEFAULT '0.00000',
  `iceval` double(255,5) NOT NULL DEFAULT '0.00000',
  `impverdeval` double(255,5) NOT NULL DEFAULT '0.00000',
  PRIMARY KEY (`id`),
  KEY `fk_facturaventa_empleado1` (`empleado_vendedor`) USING BTREE,
  KEY `fk_facturaventa_cliente1` (`cliente_cedulaRuc`) USING BTREE,
  CONSTRAINT `bill_cotizacionventa_x_ibfk_1` FOREIGN KEY (`cliente_cedulaRuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`),
  CONSTRAINT `bill_cotizacionventa_x_ibfk_2` FOREIGN KEY (`empleado_vendedor`) REFERENCES `billing_empleado` (`PersonaComercio_cedulaRuc`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cotizacion_venta
-- ----------------------------
DROP TABLE IF EXISTS `bill_cotizacion_venta`;
CREATE TABLE `bill_cotizacion_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descuentoporcent` float NOT NULL DEFAULT '0',
  `descuentovalor` float NOT NULL DEFAULT '0',
  `recargoporcent` float NOT NULL DEFAULT '0',
  `recargovalor` float NOT NULL DEFAULT '0',
  `fechaarchivada` date DEFAULT NULL,
  `horaarchivada` time DEFAULT NULL,
  `fechaCreacion` date NOT NULL,
  `hora` time DEFAULT NULL,
  `fechavencefact` date DEFAULT NULL,
  `subtotalBruto` float NOT NULL DEFAULT '0',
  `impuestoImportacion` float DEFAULT '0',
  `transporteporcent` float DEFAULT '0',
  `transporteval` float DEFAULT NULL,
  `subtotalNeto` float NOT NULL,
  `ivaporcent` float NOT NULL,
  `ivaval` float NOT NULL,
  `totalCompra` float NOT NULL COMMENT 'Precio total, incluido IVA',
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `empleado_vendedor` varchar(128) COLLATE utf8_bin NOT NULL,
  `sustento_cod` varchar(5) COLLATE utf8_bin DEFAULT NULL,
  `cliente_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `valorrecibidoefectivo` float DEFAULT '0',
  `valorcambio` float DEFAULT '0',
  `contacuentasplan_cod` varchar(12) COLLATE utf8_bin DEFAULT NULL,
  `tarifacerobruto` float NOT NULL DEFAULT '0',
  `tarifaceroneto` float NOT NULL DEFAULT '0',
  `tarifadocebruto` float NOT NULL DEFAULT '0',
  `tarifadoceneto` float NOT NULL DEFAULT '0',
  `subtbrutobienes` float NOT NULL DEFAULT '0',
  `subtbrutoservicios` float NOT NULL DEFAULT '0',
  `subtnetobienes` float NOT NULL DEFAULT '0',
  `subtnetoservicios` float NOT NULL DEFAULT '0',
  `iceval` float NOT NULL DEFAULT '0',
  `impverdeval` float NOT NULL DEFAULT '0',
  `efectivoval` float NOT NULL DEFAULT '0',
  `creditoval` float NOT NULL DEFAULT '0',
  `tarjcreditoval` float NOT NULL DEFAULT '0',
  `chequeval` float NOT NULL DEFAULT '0',
  `diferidoval` float NOT NULL DEFAULT '0',
  `anticipoval` double(255,2) NOT NULL DEFAULT '0.00',
  `baseiva` double(255,2) DEFAULT NULL,
  `bodega_id` int(11) DEFAULT NULL,
  `tipoprecio` varchar(28) COLLATE utf8_bin DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT ' 1 = pendiente, 2 = archivada, -1 = pendiente anulada, -2 = archivada anulada',
  `estado_observ` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `estado_user` int(11) DEFAULT NULL,
  `estado_fecha` date DEFAULT NULL,
  `retencion_venta_id` int(11) DEFAULT NULL,
  `autorizado_sri` int(1) NOT NULL DEFAULT '0',
  `mensaje_sri` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `venta_id` int(11) DEFAULT NULL COMMENT 'Cuando es nota de credito, hace referencia a la factura de venta que se le aplico la nota de credito',
  `pagada` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'Si se hizo la devulucion del valor de la nota de credito',
  `pagada_detalle` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `ndc_tipo_pago` int(11) DEFAULT NULL,
  `tipo_pago` tinyint(1) NOT NULL DEFAULT '1',
  `tecnico_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_facturaventa_empleado1` (`empleado_vendedor`) USING BTREE,
  KEY `fk_facturaventa_sustento1` (`sustento_cod`) USING BTREE,
  KEY `fk_facturaventa_cliente1` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_facturaventa_contacuentasplan1` (`contacuentasplan_cod`) USING BTREE,
  KEY `fk_factventa_bodegaid1` (`bodega_id`) USING BTREE,
  KEY `fk_factventa_tipoprecio1` (`tipoprecio`) USING BTREE,
  CONSTRAINT `bill_cotizacion_venta_ibfk_1` FOREIGN KEY (`contacuentasplan_cod`) REFERENCES `billing_contacuentasplan` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cotizacion_venta_ibfk_2` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cotizacion_venta_ibfk_3` FOREIGN KEY (`tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cotizacion_venta_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_cotizacion_venta_det`;
CREATE TABLE `bill_cotizacion_venta_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cotizacion_id` int(11) NOT NULL,
  `Producto_codigo` bigint(20) NOT NULL,
  `itemcantidad` int(11) NOT NULL,
  `itempreciobruto` float NOT NULL,
  `itemprecioneto` float NOT NULL,
  `itemprecioxcantidadbruto` float NOT NULL,
  `descuentofactporcent` float DEFAULT NULL,
  `descuentofactvalor` float DEFAULT NULL,
  `recargofactporcent` float DEFAULT NULL,
  `recargofactvalor` float DEFAULT NULL,
  `itemprecioxcantidadneto` float DEFAULT NULL,
  `ivaporcent` float DEFAULT NULL,
  `ivavalitemprecioneto` float DEFAULT NULL,
  `itemprecioiva` float DEFAULT NULL,
  `ivavalprecioxcantidadneto` float DEFAULT NULL,
  `itemxcantidadprecioiva` float DEFAULT NULL,
  `estaAnulada` int(11) DEFAULT '0',
  `bodega_id` int(11) NOT NULL,
  `tiposprecio_tipoprecio` varchar(28) COLLATE utf8_bin NOT NULL,
  `itembaseiva` double(255,2) DEFAULT NULL,
  `totitembaseiva` double(255,2) DEFAULT NULL,
  `iceporcent` double(255,2) DEFAULT NULL,
  `iceval` double(255,2) DEFAULT NULL,
  `priceice` double(255,2) DEFAULT NULL,
  `totalpriceice` double(255,2) DEFAULT NULL,
  `totivaval` double(255,2) DEFAULT NULL,
  `priceiva` double(255,2) DEFAULT NULL,
  `totalpriceiva` double(255,2) DEFAULT NULL,
  `detalle` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_DetalleFacturaCompra_Producto1` (`Producto_codigo`) USING BTREE,
  KEY `fk_detallefacturacompra_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_facturaventadetalle_tiposprecio1` (`tiposprecio_tipoprecio`) USING BTREE,
  KEY `bill_cotizacion_venta_det_ibfk_1` (`cotizacion_id`),
  CONSTRAINT `bill_cotizacion_venta_det_ibfk_1` FOREIGN KEY (`cotizacion_id`) REFERENCES `bill_cotizacion_venta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cotizacion_venta_det_ibfk_2` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cotizacion_venta_det_ibfk_3` FOREIGN KEY (`Producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cotizacion_venta_det_ibfk_4` FOREIGN KEY (`tiposprecio_tipoprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cuentabancaria
-- ----------------------------
DROP TABLE IF EXISTS `bill_cuentabancaria`;
CREATE TABLE `bill_cuentabancaria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banco_id` int(11) NOT NULL,
  `nombre_usuario` varchar(255) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `fecha_vence` date NOT NULL,
  `fecha_cobro_real` date NOT NULL,
  `fecha_registro` date NOT NULL,
  `fecha_registro_cobro_real` date NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipo_transaccion` varchar(3) NOT NULL,
  `debito` double(255,4) NOT NULL,
  `credito` double(255,4) NOT NULL,
  `saldo` double(255,4) NOT NULL,
  `asiento_id` double(255,4) DEFAULT NULL,
  `anio` int(11) NOT NULL,
  `mes` int(11) NOT NULL,
  `conciliado` tinyint(1) NOT NULL DEFAULT '0',
  `empleado_id` int(11) NOT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `cliente_id` varchar(128) DEFAULT NULL,
  `hora` time NOT NULL,
  `nota` varchar(255) DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT '1 = activo, -1 = inactivo',
  `estado_info` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_cuentabancaria_fk_1` (`banco_id`) USING BTREE,
  KEY `bill_cuentabancaria_fk_2` (`mes`) USING BTREE,
  KEY `bill_cuentabancaria_fk_3` (`tipo_id`) USING BTREE,
  CONSTRAINT `bill_cuentabancaria_ibfk_1` FOREIGN KEY (`banco_id`) REFERENCES `billing_banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cuentabancaria_ibfk_2` FOREIGN KEY (`mes`) REFERENCES `bill_mes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cuentabancaria_ibfk_3` FOREIGN KEY (`tipo_id`) REFERENCES `bill_cuentabancaria_tipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cuentabancaria_saldos
-- ----------------------------
DROP TABLE IF EXISTS `bill_cuentabancaria_saldos`;
CREATE TABLE `bill_cuentabancaria_saldos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `banco_id` int(11) DEFAULT NULL,
  `saldo` varchar(255) DEFAULT NULL,
  `mes_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bill_cuentabancaria_tipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_cuentabancaria_tipo`;
CREATE TABLE `bill_cuentabancaria_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cxc
-- ----------------------------
DROP TABLE IF EXISTS `bill_cxc`;
CREATE TABLE `bill_cxc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `doc_id` int(11) DEFAULT NULL,
  `tipotransaccion_cod` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `total_bruto` double(255,2) DEFAULT NULL,
  `interes` double(255,2) DEFAULT NULL,
  `total_neto` double(255,2) NOT NULL COMMENT 'total ya aplicando interes en caso que lo hubiese',
  `vencecadadias` int(11) NOT NULL,
  `idcuota` int(11) NOT NULL,
  `nrocuotas` int(11) NOT NULL,
  `cuota_bruto` double(255,2) NOT NULL,
  `porcent_interes_mensualizado` double(255,2) DEFAULT NULL,
  `cuota_neto` double(255,2) DEFAULT NULL,
  `vence_cuota` date DEFAULT NULL,
  `balance` double(255,2) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `valor_cobrado` double(255,2) DEFAULT NULL,
  `fecha_cobro` date DEFAULT NULL,
  `valor_cobrado_bruto` double(255,2) DEFAULT NULL COMMENT 'Lo que nos deja el cliente, sin tener en cuenta el cambio que se leda',
  `cambio` double(255,2) DEFAULT NULL,
  `saldototal` double(255,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `client_id` varchar(45) COLLATE utf8_bin NOT NULL,
  `saldo_client` double(255,2) DEFAULT NULL,
  `saldo_ultimo` double(255,2) DEFAULT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT '1 = activa, -1 = anulada',
  `cxc_anulada_id` int(11) DEFAULT NULL,
  `detalle_anulacion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cxc_venta_id` (`doc_id`) USING BTREE,
  KEY `fk_cxc_tipopago` (`tipopago_id`) USING BTREE,
  CONSTRAINT `bill_cxc_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=217 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cxcreciboctascobradas
-- ----------------------------
DROP TABLE IF EXISTS `bill_cxcreciboctascobradas`;
CREATE TABLE `bill_cxcreciboctascobradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigofactventa` int(11) NOT NULL,
  `idcuota` varchar(45) COLLATE utf8_bin NOT NULL,
  `fecha` date DEFAULT NULL,
  `valordeudatotal` float DEFAULT NULL,
  `balance` float DEFAULT NULL,
  `valorcuota` float DEFAULT NULL,
  `valorabono` float DEFAULT NULL,
  `saldo` float DEFAULT NULL,
  `valorabonoletras` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `saldoletras` varchar(256) COLLATE utf8_bin DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `anio` year(4) DEFAULT NULL,
  `cliente_cedularuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `empleado_cedularuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `factventatipopago_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cxcreciboctascobradas_facturaventa1` (`codigofactventa`) USING BTREE,
  KEY `fk_cxcreciboctascobradas_cliente1` (`cliente_cedularuc`) USING BTREE,
  KEY `fk_factventatipopago_id` (`factventatipopago_id`) USING BTREE,
  CONSTRAINT `bill_cxcreciboctascobradas_ibfk_1` FOREIGN KEY (`cliente_cedularuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cxcreciboctascobradas_ibfk_2` FOREIGN KEY (`codigofactventa`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cxc_pago_cuota
-- ----------------------------
DROP TABLE IF EXISTS `bill_cxc_pago_cuota`;
CREATE TABLE `bill_cxc_pago_cuota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cxc_id` int(11) NOT NULL,
  `cuota_val` double(255,2) NOT NULL,
  `valor_cancelado` double(255,2) NOT NULL,
  `saldo_cuota` double(255,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_cxc_tipopago
-- ----------------------------
DROP TABLE IF EXISTS `bill_cxc_tipopago`;
CREATE TABLE `bill_cxc_tipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `valor` double(255,2) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `doc_pago_id` int(11) NOT NULL COMMENT 'puede ser id de cheque, transferencia, etc',
  PRIMARY KEY (`id`),
  KEY `fx_ventatipopago_ventaid` (`anticipo_id`) USING BTREE,
  KEY `fk_ventatipopago_tipopago` (`tipopago_id`) USING BTREE,
  CONSTRAINT `bill_cxc_tipopago_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_cxp
-- ----------------------------
DROP TABLE IF EXISTS `bill_cxp`;
CREATE TABLE `bill_cxp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  `totaldeuda` double(255,2) NOT NULL,
  `vencecadadias` int(11) NOT NULL,
  `nrocuotas` int(11) NOT NULL,
  `idcuota` int(11) NOT NULL,
  `valorcuotaindividual` double(255,2) NOT NULL,
  `vencecuotaindividual` date DEFAULT NULL,
  `balance` double(255,2) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `valor_pagado` double(255,2) DEFAULT NULL,
  `fechapago` date DEFAULT NULL,
  `saldototal` double(255,2) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `proveedor_id` int(11) DEFAULT NULL,
  `saldo_proveedor` double(255,2) NOT NULL,
  `saldo_ultimo` double(255,2) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `detalle_anulacion` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(255) DEFAULT NULL,
  `cxp_anulada_id` int(11) DEFAULT NULL,
  `tipotransaccion_cod` varchar(3) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cxc_tipopago` (`tipopago_id`) USING BTREE,
  KEY `bill_cxp_ibfk_2` (`compra_id`) USING BTREE,
  CONSTRAINT `bill_cxp_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_cxp_ibfk_2` FOREIGN KEY (`compra_id`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=200 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_deposito_realizado
-- ----------------------------
DROP TABLE IF EXISTS `bill_deposito_realizado`;
CREATE TABLE `bill_deposito_realizado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` float DEFAULT NULL,
  `numero` varchar(45) COLLATE utf8_bin NOT NULL,
  `nro_cuenta` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `fecha_deposio` date DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `proveedor_id` int(11) NOT NULL,
  `contaasientocontable_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `banco_id` int(11) NOT NULL,
  `docid` bigint(20) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`numero`,`proveedor_id`,`banco_id`) USING BTREE,
  KEY `fk_chequescustodio_cliente1_idx` (`proveedor_id`) USING BTREE,
  KEY `fk_chequescustodio_contaasientocontable1_idx` (`contaasientocontable_id`) USING BTREE,
  KEY `fk_chequescustodio_tipotransaccion1_idx` (`tipotransaccion_cod`) USING BTREE,
  KEY `fk_bancoslist` (`banco_id`) USING BTREE,
  KEY `fk_chequescust_empleadoid` (`user_id`) USING BTREE,
  CONSTRAINT `bill_deposito_realizado_ibfk_2` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_deposito_realizado_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_deposito_realizado_ibfk_4` FOREIGN KEY (`user_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='este es el estado del cheque.. \r\nEjemplo:\r\n\r\n0 -> en custodio\r\n1 -> cobrado\r\n2 -> protestado , ...';

-- ----------------------------
-- Table structure for bill_deposito_recibido
-- ----------------------------
DROP TABLE IF EXISTS `bill_deposito_recibido`;
CREATE TABLE `bill_deposito_recibido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` float DEFAULT NULL,
  `numero` varchar(45) COLLATE utf8_bin NOT NULL,
  `nro_cuenta` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `fecha_deposio` date DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `cliente_cedulaRuc` varchar(128) COLLATE utf8_bin NOT NULL,
  `contaasientocontable_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `banco_id` int(11) NOT NULL,
  `docid` bigint(20) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`numero`,`cliente_cedulaRuc`,`banco_id`) USING BTREE,
  KEY `fk_chequescustodio_cliente1_idx` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_chequescustodio_contaasientocontable1_idx` (`contaasientocontable_id`) USING BTREE,
  KEY `fk_chequescustodio_tipotransaccion1_idx` (`tipotransaccion_cod`) USING BTREE,
  KEY `fk_bancoslist` (`banco_id`) USING BTREE,
  KEY `fk_chequescust_empleadoid` (`user_id`) USING BTREE,
  CONSTRAINT `bill_deposito_recibido_ibfk_1` FOREIGN KEY (`cliente_cedulaRuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_deposito_recibido_ibfk_2` FOREIGN KEY (`contaasientocontable_id`) REFERENCES `billing_contaasientocontable` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_deposito_recibido_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_deposito_recibido_ibfk_5` FOREIGN KEY (`user_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='este es el estado del cheque.. \r\nEjemplo:\r\n\r\n0 -> en custodio\r\n1 -> cobrado\r\n2 -> protestado , ...';

-- ----------------------------
-- Table structure for bill_error_sri
-- ----------------------------
DROP TABLE IF EXISTS `bill_error_sri`;
CREATE TABLE `bill_error_sri` (
  `id` varchar(11) NOT NULL,
  `descripcion` varchar(250) NOT NULL,
  `solucion` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_gastoshist
-- ----------------------------
DROP TABLE IF EXISTS `bill_gastoshist`;
CREATE TABLE `bill_gastoshist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_codigo` bigint(20) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `entrada` int(11) DEFAULT '0',
  `price` double(255,5) DEFAULT NULL,
  `priceneto` double(255,5) DEFAULT NULL,
  `ivaval` double(255,5) DEFAULT NULL,
  `totalpriceneto` double(255,5) DEFAULT NULL,
  `totivaval` double(255,5) DEFAULT NULL,
  `totalpriceiva` double(255,5) DEFAULT NULL,
  `factualizacion` date NOT NULL COMMENT 'Fecha de ultima actualizacion',
  `anulado` tinyint(1) DEFAULT '0',
  `facturacompra_codigoFacturaCompra` int(11) NOT NULL,
  `centroscostoid` int(11) DEFAULT NULL,
  `anio` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_StockHistorial_Producto1` (`producto_codigo`) USING BTREE,
  KEY `fk_stockhistorial_bodega1` (`bodega_id`) USING BTREE,
  KEY `fk_gastoshistorial_facturacompra1` (`facturacompra_codigoFacturaCompra`) USING BTREE,
  KEY `fk_gastoshistorial_centroscosto1_idx` (`centroscostoid`) USING BTREE,
  CONSTRAINT `bill_gastoshist_ibfk_1` FOREIGN KEY (`centroscostoid`) REFERENCES `billing_centroscosto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_gastoshist_ibfk_2` FOREIGN KEY (`facturacompra_codigoFacturaCompra`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_gastoshist_ibfk_3` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_gastoshist_ibfk_4` FOREIGN KEY (`producto_codigo`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_grupoprecio
-- ----------------------------
DROP TABLE IF EXISTS `bill_grupoprecio`;
CREATE TABLE `bill_grupoprecio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productogrupo_id` int(11) NOT NULL,
  `tiposprecio_id` varchar(28) COLLATE utf8_bin NOT NULL,
  `utilidad` double NOT NULL,
  `fechadesde` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`tiposprecio_id`,`productogrupo_id`) USING BTREE,
  KEY `fk_billing_tiposprecio_has_billing_productogrupo_billing_pr_idx` (`productogrupo_id`) USING BTREE,
  KEY `fk_billing_tiposprecio_has_billing_productogrupo_billing_ti_idx` (`tiposprecio_id`) USING BTREE,
  CONSTRAINT `bill_grupoprecio_ibfk_1` FOREIGN KEY (`productogrupo_id`) REFERENCES `billing_productogrupo` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_grupoprecio_ibfk_2` FOREIGN KEY (`tiposprecio_id`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=273 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_grupopreciohist
-- ----------------------------
DROP TABLE IF EXISTS `bill_grupopreciohist`;
CREATE TABLE `bill_grupopreciohist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `utilidad` double DEFAULT NULL,
  `fechadesde` date DEFAULT NULL,
  `grupoprecio_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_grupopreciohist_grupoprecio1_idx` (`grupoprecio_id`) USING BTREE,
  CONSTRAINT `bill_grupopreciohist_ibfk_1` FOREIGN KEY (`grupoprecio_id`) REFERENCES `bill_grupoprecio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_impuesto
-- ----------------------------
DROP TABLE IF EXISTS `bill_impuesto`;
CREATE TABLE `bill_impuesto` (
  `id` int(11) NOT NULL,
  `impuesto` varchar(255) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_impuestotarifa
-- ----------------------------
DROP TABLE IF EXISTS `bill_impuestotarifa`;
CREATE TABLE `bill_impuestotarifa` (
  `id` int(11) NOT NULL,
  `cod` int(11) NOT NULL,
  `tarporcent` double NOT NULL,
  `descripcion` varchar(45) COLLATE utf8_bin NOT NULL,
  `impuesto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_impuestotarifa_bill_impuesto1_idx` (`impuesto_id`) USING BTREE,
  CONSTRAINT `bill_impuestotarifa_ibfk_1` FOREIGN KEY (`impuesto_id`) REFERENCES `bill_impuesto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_kardex
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex`;
CREATE TABLE `bill_kardex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `kardex` int(11) NOT NULL COMMENT 'cantidad de entrada o salida',
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `costo_prom` double(255,2) NOT NULL,
  `costo_prom_total` double(255,2) NOT NULL,
  `precio_venta_total` double(255,2) DEFAULT NULL,
  `utilidad_venta` double(255,2) DEFAULT NULL COMMENT 'si es una venta, entonces calculamos la utilidad en valores reales',
  `costo_prom_ultimo` double(255,2) NOT NULL,
  `costo_ult` double(255,2) NOT NULL,
  `costo_ult_ultimo` double(255,2) NOT NULL,
  `tot_costo_ventas` double(255,2) NOT NULL,
  `docid` int(11) NOT NULL,
  `transaccion_cod` varchar(2) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `costo_inventario_product` double(255,2) DEFAULT NULL,
  `costo_inv_product_ultimo` double(255,2) NOT NULL,
  `costo_inventario` double(255,2) DEFAULT NULL COMMENT 'presenta el costo del inventario al momento de realizar la transaccion, de todos los productos',
  `costo_inventario_ultimo` double(255,2) DEFAULT NULL,
  `estado` tinyint(1) DEFAULT '1' COMMENT 'presenta el actual costo del inventario total, de todos los productos',
  `bodega_id` int(11) NOT NULL,
  `kardex_anulado_id` int(11) DEFAULT NULL,
  `detalle_anulacion` varchar(500) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `estado_info` varchar(255) DEFAULT NULL,
  `tipotransaccion_cod_ajuste` varchar(3) DEFAULT NULL COMMENT 'Este campo se usa solo cuando es por un ajueste de entrada o salida',
  `doc_id_ajuste` int(11) DEFAULT NULL COMMENT 'Id del ajuste de entrada o de salida',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_kardex_bodega
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex_bodega`;
CREATE TABLE `bill_kardex_bodega` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `kardex` int(255) NOT NULL,
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4393 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_kardex_bodega_aux
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex_bodega_aux`;
CREATE TABLE `bill_kardex_bodega_aux` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `kardex` int(255) NOT NULL,
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6161 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_kardex_bodega_original_bill_master
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex_bodega_original_bill_master`;
CREATE TABLE `bill_kardex_bodega_original_bill_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `kardex` int(255) NOT NULL,
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6161 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_kardex_bodega_xxantes
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex_bodega_xxantes`;
CREATE TABLE `bill_kardex_bodega_xxantes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `kardex` int(255) NOT NULL,
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1362 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_kardex_bodega_xxaux_antes
-- ----------------------------
DROP TABLE IF EXISTS `bill_kardex_bodega_xxaux_antes`;
CREATE TABLE `bill_kardex_bodega_xxaux_antes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `bodega_id` int(11) NOT NULL,
  `kardex` int(255) NOT NULL,
  `kardex_total` int(255) NOT NULL,
  `kardex_ultimo` int(255) NOT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1362 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_mes
-- ----------------------------
DROP TABLE IF EXISTS `bill_mes`;
CREATE TABLE `bill_mes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mes` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_ndc_tipo_cobro
-- ----------------------------
DROP TABLE IF EXISTS `bill_ndc_tipo_cobro`;
CREATE TABLE `bill_ndc_tipo_cobro` (
  `id` int(11) NOT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for bill_prodattr
-- ----------------------------
DROP TABLE IF EXISTS `bill_prodattr`;
CREATE TABLE `bill_prodattr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `attr` varchar(25) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_productoattr
-- ----------------------------
DROP TABLE IF EXISTS `bill_productoattr`;
CREATE TABLE `bill_productoattr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) NOT NULL,
  `prodattr_id` int(11) NOT NULL,
  `valor_attr` varchar(128) COLLATE utf8_bin NOT NULL,
  `tipotransaccion_cod` varchar(3) COLLATE utf8_bin NOT NULL,
  `doc_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 = activo, -1 = desactivado o eliminado',
  `usuario_name` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primary_key` (`producto_id`,`prodattr_id`,`valor_attr`,`doc_id`,`tipotransaccion_cod`) USING BTREE,
  KEY `fk_billing_producto_has_bill_prodattr_bill_prodattr1_idx` (`prodattr_id`) USING BTREE,
  KEY `fk_billing_producto_has_bill_prodattr_billing_producto1_idx` (`producto_id`) USING BTREE,
  CONSTRAINT `bill_productoattr_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_productoattr_ibfk_2` FOREIGN KEY (`prodattr_id`) REFERENCES `bill_prodattr` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_productoimpuestotarifa
-- ----------------------------
DROP TABLE IF EXISTS `bill_productoimpuestotarifa`;
CREATE TABLE `bill_productoimpuestotarifa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) NOT NULL,
  `impuestotarifa_id` int(11) NOT NULL,
  `impuesto_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`producto_id`,`impuestotarifa_id`) USING BTREE,
  KEY `fk_billing_producto_has_bill_impuestotarifa_bill_impuestota_idx` (`impuestotarifa_id`) USING BTREE,
  KEY `fk_billing_producto_has_bill_impuestotarifa_billing_product_idx` (`producto_id`) USING BTREE,
  KEY `fk_bill_productoimpuestotarifa_bill_impuesto1_idx` (`impuesto_id`) USING BTREE,
  CONSTRAINT `bill_productoimpuestotarifa_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_productoimpuestotarifa_ibfk_2` FOREIGN KEY (`impuestotarifa_id`) REFERENCES `bill_impuestotarifa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_productoimpuestotarifa_ibfk_3` FOREIGN KEY (`impuesto_id`) REFERENCES `bill_impuesto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2501 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_proveedortipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_proveedortipo`;
CREATE TABLE `bill_proveedortipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) COLLATE utf8_bin NOT NULL,
  `descripcion` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_proveedor_anticipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_proveedor_anticipo`;
CREATE TABLE `bill_proveedor_anticipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo` double(255,2) NOT NULL,
  `saldo` double(255,2) NOT NULL,
  `saldo_ultimo` double(255,2) DEFAULT NULL,
  `proveedor_id` int(11) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  `empleado_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT 'por default .. activo',
  `anticipo_anulado_id` int(11) DEFAULT NULL COMMENT 'lo relaciono con esta misma tabla, para cuando se anula anticipo',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_proveedor_anticipo_tipopago
-- ----------------------------
DROP TABLE IF EXISTS `bill_proveedor_anticipo_tipopago`;
CREATE TABLE `bill_proveedor_anticipo_tipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `valor` double(255,2) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `doc_pago_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fx_ventatipopago_ventaid` (`anticipo_id`) USING BTREE,
  KEY `fk_ventatipopago_tipopago` (`tipopago_id`) USING BTREE,
  CONSTRAINT `bill_proveedor_anticipo_tipopago_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_proveedor_puntoventa
-- ----------------------------
DROP TABLE IF EXISTS `bill_proveedor_puntoventa`;
CREATE TABLE `bill_proveedor_puntoventa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor_id` int(13) NOT NULL,
  `tiposcomprobante_cod` varchar(7) COLLATE utf8_bin NOT NULL,
  `establecimiento` varchar(3) COLLATE utf8_bin NOT NULL,
  `puntoemision` varchar(3) COLLATE utf8_bin NOT NULL,
  `numautorizacion` varchar(45) COLLATE utf8_bin NOT NULL,
  `fvencimiento` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `numautorizacion_UNIQUE` (`numautorizacion`) USING BTREE,
  UNIQUE KEY `idx_primarykey` (`proveedor_id`,`tiposcomprobante_cod`,`establecimiento`,`puntoemision`) USING BTREE,
  KEY `fk_proveedor_has_tiposcomprobante_tiposcomprobante1` (`tiposcomprobante_cod`) USING BTREE,
  KEY `fk_proveedor_has_tiposcomprobante_proveedor1` (`proveedor_id`) USING BTREE,
  CONSTRAINT `bill_proveedor_puntoventa_ibfk_1` FOREIGN KEY (`tiposcomprobante_cod`) REFERENCES `billing_tiposcomprobante` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_proveedor_puntoventa_ibfk_2` FOREIGN KEY (`proveedor_id`) REFERENCES `billing_proveedor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_proveedor_sri_retencion
-- ----------------------------
DROP TABLE IF EXISTS `bill_proveedor_sri_retencion`;
CREATE TABLE `bill_proveedor_sri_retencion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor_id` int(11) NOT NULL,
  `sri_retencion_id` int(11) NOT NULL,
  `priority` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `bill_proveedor_sri_retencion_fk1` (`proveedor_id`) USING BTREE,
  KEY `bill_proveedor_sri_retencion_fk2` (`sri_retencion_id`) USING BTREE,
  CONSTRAINT `bill_proveedor_sri_retencion_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `billing_proveedor` (`id`),
  CONSTRAINT `bill_proveedor_sri_retencion_ibfk_2` FOREIGN KEY (`sri_retencion_id`) REFERENCES `bill_sri_retencion` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_puntoventausers
-- ----------------------------
DROP TABLE IF EXISTS `bill_puntoventausers`;
CREATE TABLE `bill_puntoventausers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `puntoventa_id` int(11) NOT NULL,
  `empleado_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_primarykey` (`puntoventa_id`,`empleado_id`) USING BTREE,
  KEY `fk_bill_puntoventausers_billing_puntoventaempleado1_idx` (`puntoventa_id`) USING BTREE,
  KEY `fk_bill_puntoventausers_billing_empleado1_idx` (`empleado_id`) USING BTREE,
  CONSTRAINT `bill_puntoventausers_ibfk_1` FOREIGN KEY (`puntoventa_id`) REFERENCES `billing_puntoventaempleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_puntoventausers_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `billing_empleado` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_recibo
-- ----------------------------
DROP TABLE IF EXISTS `bill_recibo`;
CREATE TABLE `bill_recibo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` varchar(4) NOT NULL,
  `client_id` varchar(128) NOT NULL,
  `nota` varchar(255) DEFAULT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `recibo_tipo_id` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `lugar` varchar(45) NOT NULL,
  `cantidad_number` double(255,2) NOT NULL,
  `cantidad_letras` varchar(255) NOT NULL,
  `user_empleado_id` int(11) NOT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `detalle_anulacion` varchar(500) DEFAULT NULL,
  `user_id_anulacion` int(255) DEFAULT NULL,
  `fecha_anulacion` date DEFAULT NULL,
  `cierre_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_recibo_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_recibo_det`;
CREATE TABLE `bill_recibo_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recibo_id` int(11) NOT NULL,
  `detalle` varchar(500) DEFAULT NULL,
  `doc_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `valor` double(255,2) NOT NULL,
  `tipopago_cod` varchar(3) NOT NULL,
  `doc_pago_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_recibo_tipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_recibo_tipo`;
CREATE TABLE `bill_recibo_tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo_recibo` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_retencion
-- ----------------------------
DROP TABLE IF EXISTS `bill_retencion`;
CREATE TABLE `bill_retencion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total` double(255,2) NOT NULL,
  `proveedor_id` int(11) NOT NULL,
  `establecimiento` varchar(3) NOT NULL,
  `pemision` varchar(3) NOT NULL,
  `nro` int(11) NOT NULL,
  `empleado_id` int(11) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1',
  `doc_id` int(11) NOT NULL,
  `tipo_transaccion` varchar(3) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `autorizacion_sri` varchar(45) NOT NULL,
  `vence_autorizacion_sri` date NOT NULL,
  `cobrada` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'indica si la retencion esta o no esta cobrada ( 0=> no cobrada, 1=> si cobrada) ',
  `user_id` int(11) DEFAULT NULL,
  `autorizado_id` int(11) NOT NULL DEFAULT '0' COMMENT 'Para verfificar la firma electronica, 1 esta autorizado, 2 no esta autorizado',
  `mensaje_sri` varchar(52) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_bill_retencion_1` (`establecimiento`,`pemision`,`nro`) USING BTREE,
  KEY `fk_retencion_1` (`proveedor_id`) USING BTREE,
  KEY `fk_retencion_2` (`empleado_id`) USING BTREE,
  KEY `fk_retencion_3` (`doc_id`) USING BTREE,
  CONSTRAINT `bill_retencion_ibfk_1` FOREIGN KEY (`proveedor_id`) REFERENCES `billing_proveedor` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_retencion_ibfk_2` FOREIGN KEY (`empleado_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_retencion_ibfk_3` FOREIGN KEY (`doc_id`) REFERENCES `billing_facturacompra` (`codigoFacturaCompra`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_retencion_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_retencion_det`;
CREATE TABLE `bill_retencion_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `retencion_id` int(11) NOT NULL,
  `sri_retencion_id` int(255) NOT NULL,
  `impuesto_renta` varchar(25) NOT NULL,
  `base_imponible` double(255,2) NOT NULL,
  `cod_impuesto` varchar(5) NOT NULL,
  `porcent_ret` double(255,2) NOT NULL,
  `val_retenido` double(255,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_retencion_det_1` (`retencion_id`) USING BTREE,
  KEY `fk_retencion_det_2` (`sri_retencion_id`) USING BTREE,
  CONSTRAINT `bill_retencion_det_ibfk_1` FOREIGN KEY (`retencion_id`) REFERENCES `bill_retencion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_retencion_det_ibfk_2` FOREIGN KEY (`sri_retencion_id`) REFERENCES `bill_sri_retencion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_retencion_venta
-- ----------------------------
DROP TABLE IF EXISTS `bill_retencion_venta`;
CREATE TABLE `bill_retencion_venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `total` double(255,2) NOT NULL,
  `client_id` varchar(128) NOT NULL,
  `establecimiento` varchar(3) NOT NULL,
  `pemision` varchar(3) NOT NULL,
  `nro` int(11) NOT NULL,
  `empleado_id` int(11) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1',
  `doc_id` int(11) NOT NULL,
  `tipo_transaccion` varchar(3) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `autorizacion_sri` varchar(45) NOT NULL,
  `vence_autorizacion_sri` date NOT NULL,
  `pagada` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'indica si la retencion esta o no esta cobrada ( 0=> no cobrada, 1=> si cobrada) ',
  PRIMARY KEY (`id`),
  KEY `fk_retencion_1` (`client_id`) USING BTREE,
  KEY `fk_retencion_2` (`empleado_id`) USING BTREE,
  KEY `bill_retencion_venta_ibfk_3` (`doc_id`) USING BTREE,
  CONSTRAINT `bill_retencion_venta_ibfk_1` FOREIGN KEY (`empleado_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_retencion_venta_ibfk_2` FOREIGN KEY (`doc_id`) REFERENCES `billing_facturaventa` (`codigofactventa`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_retencion_venta_det
-- ----------------------------
DROP TABLE IF EXISTS `bill_retencion_venta_det`;
CREATE TABLE `bill_retencion_venta_det` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `retencion_venta_id` int(11) NOT NULL,
  `sri_retencion_id` int(255) NOT NULL,
  `impuesto_renta` varchar(25) NOT NULL,
  `base_imponible` double(255,2) NOT NULL,
  `cod_impuesto` varchar(5) NOT NULL,
  `porcent_ret` double(255,2) NOT NULL,
  `val_retenido` double(255,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_retencion_det_2` (`sri_retencion_id`) USING BTREE,
  KEY `bill_retencion_venta_det_ibfk_1` (`retencion_venta_id`) USING BTREE,
  CONSTRAINT `bill_retencion_venta_det_ibfk_1` FOREIGN KEY (`retencion_venta_id`) REFERENCES `bill_retencion_venta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_retencion_venta_det_ibfk_2` FOREIGN KEY (`sri_retencion_id`) REFERENCES `bill_sri_retencion` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_settings
-- ----------------------------
DROP TABLE IF EXISTS `bill_settings`;
CREATE TABLE `bill_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `variable` varchar(25) NOT NULL,
  `valor` varchar(256) NOT NULL,
  `detalle` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_sri_forma_pago
-- ----------------------------
DROP TABLE IF EXISTS `bill_sri_forma_pago`;
CREATE TABLE `bill_sri_forma_pago` (
  `cod` varchar(3) NOT NULL,
  `forma_pago` varchar(255) NOT NULL,
  PRIMARY KEY (`cod`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_sri_forma_pago_compra
-- ----------------------------
DROP TABLE IF EXISTS `bill_sri_forma_pago_compra`;
CREATE TABLE `bill_sri_forma_pago_compra` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `compra_id` int(11) NOT NULL,
  `sri_forma_pago_id` varchar(3) DEFAULT NULL,
  `valor` varchar(255) NOT NULL COMMENT 'cuanto se pago en esa forma',
  PRIMARY KEY (`id`),
  KEY `bill_sri_forma_pago_fk_1` (`sri_forma_pago_id`) USING BTREE,
  CONSTRAINT `bill_sri_forma_pago_compra_ibfk_1` FOREIGN KEY (`sri_forma_pago_id`) REFERENCES `bill_sri_forma_pago` (`cod`)
) ENGINE=InnoDB AUTO_INCREMENT=357 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_sri_retencion
-- ----------------------------
DROP TABLE IF EXISTS `bill_sri_retencion`;
CREATE TABLE `bill_sri_retencion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cod` varchar(10) NOT NULL,
  `detalle_retencion` varchar(255) NOT NULL,
  `porcent_retencion` double(255,0) NOT NULL,
  `cta_cont_compras` varchar(12) NOT NULL,
  `cta_cont_ventas` varchar(12) NOT NULL,
  `impuesto_renta` varchar(25) NOT NULL,
  `col_compra` varchar(45) DEFAULT NULL COMMENT 'columna de la tabla facturacompra apra obtener la base imponible del impuesto',
  `col_venta` varchar(45) DEFAULT NULL COMMENT 'columna de la tabla facturaventa apra obtener la base imponible del impuesto',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_sri_retencionimpuesto
-- ----------------------------
DROP TABLE IF EXISTS `bill_sri_retencionimpuesto`;
CREATE TABLE `bill_sri_retencionimpuesto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(10) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_steqreparacion
-- ----------------------------
DROP TABLE IF EXISTS `bill_steqreparacion`;
CREATE TABLE `bill_steqreparacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `equipo_id` int(11) NOT NULL,
  `detalle` blob,
  `usuario_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `equestado_id` int(11) NOT NULL,
  `usuario_name` varchar(100) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(255) DEFAULT NULL,
  `celular` varchar(100) DEFAULT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_steqreparacion_bill_stequipo1_idx` (`equipo_id`) USING BTREE,
  KEY `fk_bill_steqreparacion_billing_personacomercio1_idx` (`usuario_id`) USING BTREE,
  KEY `fk_bill_steqreparacion_bill_stequestado1` (`equestado_id`) USING BTREE,
  CONSTRAINT `bill_steqreparacion_ibfk_1` FOREIGN KEY (`equestado_id`) REFERENCES `bill_stequestado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_steqreparacion_ibfk_2` FOREIGN KEY (`equipo_id`) REFERENCES `bill_stequipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_stequestado
-- ----------------------------
DROP TABLE IF EXISTS `bill_stequestado`;
CREATE TABLE `bill_stequestado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estado` varchar(45) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `clase` varchar(45) DEFAULT NULL,
  `orden` tinyint(1) DEFAULT NULL,
  `color` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_stequestado_1` (`estado`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_stequipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_stequipo`;
CREATE TABLE `bill_stequipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `anio` varchar(4) NOT NULL,
  `mes_id` int(11) NOT NULL,
  `cliente_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `caracteristicas` varchar(500) DEFAULT NULL,
  `problema` varchar(500) DEFAULT NULL,
  `presupuesto` float(11,0) DEFAULT NULL,
  `anticipocliente` float(11,0) DEFAULT NULL,
  `equipoenbodega` int(11) NOT NULL,
  `tecnicoencargado` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `marca_id` int(11) DEFAULT NULL,
  `equestado_id` int(11) NOT NULL,
  `tiposervicio_id` int(11) NOT NULL,
  `cambioultimo` blob,
  `fechaentrega` date DEFAULT NULL,
  `horaentrega` time DEFAULT NULL,
  `facturado` tinyint(1) NOT NULL DEFAULT '0',
  `factventa_id` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bill_stequipo_billing_personacomercio1_idx` (`tecnicoencargado`) USING BTREE,
  KEY `fk_bill_stequipo_billing_marca1_idx` (`marca_id`) USING BTREE,
  KEY `fk_bill_stequipo_billing_cliente1_idx` (`cliente_id`) USING BTREE,
  KEY `fk_bill_stequipo_bil_stequestado1_idx` (`equestado_id`) USING BTREE,
  KEY `fk_bill_stequipo_bill_sttiposervicio1_idx` (`tiposervicio_id`) USING BTREE,
  KEY `fk_bill_stequipo_billing_facturaventa1_idx` (`factventa_id`) USING BTREE,
  CONSTRAINT `bill_stequipo_ibfk_1` FOREIGN KEY (`marca_id`) REFERENCES `billing_marca` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stequipo_ibfk_2` FOREIGN KEY (`tiposervicio_id`) REFERENCES `bill_sttiposervicio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stequipo_ibfk_3` FOREIGN KEY (`equestado_id`) REFERENCES `bill_stequestado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stequipo_ibfk_4` FOREIGN KEY (`factventa_id`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_stequipoattr
-- ----------------------------
DROP TABLE IF EXISTS `bill_stequipoattr`;
CREATE TABLE `bill_stequipoattr` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombreattr` varchar(45) NOT NULL,
  `descripcion` varchar(45) DEFAULT NULL,
  `orden` tinyint(1) NOT NULL DEFAULT '1',
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `inputid` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombreattr_UNIQUE` (`nombreattr`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_stequipoattrequipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_stequipoattrequipo`;
CREATE TABLE `bill_stequipoattrequipo` (
  `equipoattr_id` int(11) NOT NULL,
  `equipo` int(11) NOT NULL,
  `valor` varchar(45) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_primarykey` (`equipo`,`equipoattr_id`) USING BTREE,
  KEY `fk_bill_stequipoattr_has_bill_stequipo_bill_stequipo1_idx` (`equipo`) USING BTREE,
  KEY `fk_bill_stequipoattr_has_bill_stequipo_bill_stequipoattr_idx` (`equipoattr_id`) USING BTREE,
  CONSTRAINT `bill_stequipoattrequipo_ibfk_1` FOREIGN KEY (`equipo`) REFERENCES `bill_stequipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stequipoattrequipo_ibfk_2` FOREIGN KEY (`equipoattr_id`) REFERENCES `bill_stequipoattr` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_stprefactura
-- ----------------------------
DROP TABLE IF EXISTS `bill_stprefactura`;
CREATE TABLE `bill_stprefactura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `stequipo_id` int(11) NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  `tiposprecio` varchar(28) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `cant` varchar(45) NOT NULL,
  `itemprecio` double NOT NULL,
  `ivaporcent` float NOT NULL,
  `iva` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `bodega_id` int(11) NOT NULL,
  `costopromedio` double DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `productname` varchar(255) DEFAULT NULL,
  `esservicio` tinyint(1) NOT NULL DEFAULT '0',
  `facturado` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_bill_stprefactura_bill_stequipo1_idx` (`stequipo_id`) USING BTREE,
  KEY `fk_bill_stprefactura_billing_producto1_idx` (`producto_id`) USING BTREE,
  KEY `fk_bill_stprefactura_billing_tiposprecio1_idx` (`tiposprecio`) USING BTREE,
  KEY `fk_bill_stprefactura_billing_bodega1_idx` (`bodega_id`) USING BTREE,
  CONSTRAINT `bill_stprefactura_ibfk_1` FOREIGN KEY (`bodega_id`) REFERENCES `billing_bodega` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stprefactura_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stprefactura_ibfk_3` FOREIGN KEY (`tiposprecio`) REFERENCES `billing_tiposprecio` (`tipoprecio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_stprefactura_ibfk_4` FOREIGN KEY (`stequipo_id`) REFERENCES `bill_stequipo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_sttiposervicio
-- ----------------------------
DROP TABLE IF EXISTS `bill_sttiposervicio`;
CREATE TABLE `bill_sttiposervicio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `prefix` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tipo_UNIQUE` (`tipo`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_tarjetascustodio
-- ----------------------------
DROP TABLE IF EXISTS `bill_tarjetascustodio`;
CREATE TABLE `bill_tarjetascustodio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` double(255,2) DEFAULT NULL,
  `nrotarjeta` varchar(45) COLLATE utf8_bin NOT NULL,
  `codigo` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `fechacaducidad` varchar(10) COLLATE utf8_bin DEFAULT NULL,
  `depositado` tinyint(1) NOT NULL DEFAULT '0',
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `fechacambioestado` date DEFAULT NULL,
  `horacambioestado` time DEFAULT NULL,
  `cliente_cedulaRuc` varchar(13) COLLATE utf8_bin NOT NULL,
  `contaasientocontable_id` int(11) NOT NULL,
  `tipotransaccion_cod` varchar(2) COLLATE utf8_bin NOT NULL,
  `tarjeta_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `docid` bigint(20) DEFAULT NULL,
  `observaciones` varchar(500) COLLATE utf8_bin DEFAULT NULL,
  `empleado_id` int(11) NOT NULL,
  `lugar` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `nombre_beneficiario` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `estado_info` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`nrotarjeta`,`cliente_cedulaRuc`,`tarjeta_id`) USING BTREE,
  KEY `fk_chequescustodio_cliente1_idx` (`cliente_cedulaRuc`) USING BTREE,
  KEY `fk_chequescustodio_contaasientocontable1_idx` (`contaasientocontable_id`) USING BTREE,
  KEY `fk_chequescustodio_tipotransaccion1_idx` (`tipotransaccion_cod`) USING BTREE,
  KEY `fk_chequescust_empleadoid` (`empleado_id`) USING BTREE,
  KEY `fk_tarjetascustodio_id1` (`tarjeta_id`) USING BTREE,
  CONSTRAINT `bill_tarjetascustodio_ibfk_1` FOREIGN KEY (`cliente_cedulaRuc`) REFERENCES `billing_cliente` (`PersonaComercio_cedulaRuc`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_tarjetascustodio_ibfk_3` FOREIGN KEY (`tipotransaccion_cod`) REFERENCES `billing_tipotransaccion` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_tarjetascustodio_ibfk_4` FOREIGN KEY (`empleado_id`) REFERENCES `billing_empleado` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_tarjetascustodio_ibfk_5` FOREIGN KEY (`tarjeta_id`) REFERENCES `billing_tarjetacredito` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='este es el estado del cheque.. \r\nEjemplo:\r\n\r\n0 -> en custodio\r\n1 -> cobrado\r\n2 -> protestado , ...';

-- ----------------------------
-- Table structure for bill_tarjeta_cred_pago
-- ----------------------------
DROP TABLE IF EXISTS `bill_tarjeta_cred_pago`;
CREATE TABLE `bill_tarjeta_cred_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nro` varchar(255) NOT NULL,
  `fecha_emision` date NOT NULL,
  `hora_emision` time NOT NULL,
  `fecha_cobro` date DEFAULT NULL,
  `lugar` varchar(25) NOT NULL,
  `nombre_beneficiario` varchar(128) NOT NULL,
  `banco_id` int(11) NOT NULL,
  `valor` double(255,2) NOT NULL,
  `comprobante_id` int(11) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT '1' COMMENT 'por default 1 => activo, -1 => anulado',
  `cod_seguridad` varchar(8) DEFAULT NULL,
  `fecha_caducidad` varchar(10) DEFAULT NULL,
  `tarjeta_id` varchar(3) NOT NULL,
  `tipotransaccion_cod` varchar(3) NOT NULL,
  `doc_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `bill_cheque_pago_fk_1` (`banco_id`) USING BTREE,
  CONSTRAINT `bill_tarjeta_cred_pago_ibfk_1` FOREIGN KEY (`banco_id`) REFERENCES `billing_banco` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transbus
-- ----------------------------
DROP TABLE IF EXISTS `bill_transbus`;
CREATE TABLE `bill_transbus` (
  `id` int(11) NOT NULL,
  `estado` tinyint(4) DEFAULT '1',
  `anio` varchar(4) DEFAULT NULL,
  `propietario` varchar(128) DEFAULT NULL,
  `nroasientos` int(11) NOT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `chofer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transbusasiento
-- ----------------------------
DROP TABLE IF EXISTS `bill_transbusasiento`;
CREATE TABLE `bill_transbusasiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transbushorario
-- ----------------------------
DROP TABLE IF EXISTS `bill_transbushorario`;
CREATE TABLE `bill_transbushorario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `horasalida` time NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_horasalida` (`horasalida`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transdestino
-- ----------------------------
DROP TABLE IF EXISTS `bill_transdestino`;
CREATE TABLE `bill_transdestino` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destino` varchar(45) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `destino_UNIQUE` (`destino`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_transdia
-- ----------------------------
DROP TABLE IF EXISTS `bill_transdia`;
CREATE TABLE `bill_transdia` (
  `id` int(11) NOT NULL,
  `dia` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transferencia
-- ----------------------------
DROP TABLE IF EXISTS `bill_transferencia`;
CREATE TABLE `bill_transferencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nota` varchar(500) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `usuario` int(11) NOT NULL,
  `empleado` int(11) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT '0' COMMENT '0 = transferencia en pendiente, aun no la aprueba la persona que recibe',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transferenciaproducto
-- ----------------------------
DROP TABLE IF EXISTS `bill_transferenciaproducto`;
CREATE TABLE `bill_transferenciaproducto` (
  `transferencia_id` int(11) DEFAULT NULL,
  `producto_id` int(11) DEFAULT NULL,
  `bodega_ori` int(11) DEFAULT NULL,
  `bodega_fin` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transruta
-- ----------------------------
DROP TABLE IF EXISTS `bill_transruta`;
CREATE TABLE `bill_transruta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` bigint(20) NOT NULL,
  `bushorario_id` int(11) DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `costo` double(255,2) NOT NULL,
  `horasalida` time DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `fk_primarykey` (`producto_id`,`horasalida`) USING BTREE,
  KEY `fk_table1_billing_producto1_idx` (`producto_id`) USING BTREE,
  KEY `fk_table1_bushorario1_idx` (`bushorario_id`) USING BTREE,
  CONSTRAINT `bill_transruta_ibfk_1` FOREIGN KEY (`bushorario_id`) REFERENCES `bill_transbushorario` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bill_transruta_ibfk_2` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transrutadestino
-- ----------------------------
DROP TABLE IF EXISTS `bill_transrutadestino`;
CREATE TABLE `bill_transrutadestino` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destino_id` int(11) NOT NULL,
  `costo` double NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`producto_id`,`destino_id`) USING BTREE,
  KEY `fk_bill_transruta_has_bill_transdestino_bill_transdestino1_idx` (`destino_id`) USING BTREE,
  KEY `fk_bill_transrutadestino_billing_producto1_idx` (`producto_id`) USING BTREE,
  CONSTRAINT `bill_transrutadestino_ibfk_1` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadestino_ibfk_2` FOREIGN KEY (`destino_id`) REFERENCES `bill_transdestino` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transrutadia
-- ----------------------------
DROP TABLE IF EXISTS `bill_transrutadia`;
CREATE TABLE `bill_transrutadia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ruta_id` int(11) NOT NULL,
  `dia_id` int(11) NOT NULL,
  `bus_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_primarykey` (`ruta_id`,`dia_id`) USING BTREE,
  KEY `fk_rutadia_ruta1_idx` (`ruta_id`) USING BTREE,
  KEY `fk_rutadia_Dia1_idx` (`dia_id`) USING BTREE,
  KEY `fk_rutadia_bus1_idx` (`bus_id`) USING BTREE,
  CONSTRAINT `bill_transrutadia_ibfk_1` FOREIGN KEY (`ruta_id`) REFERENCES `bill_transruta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadia_ibfk_2` FOREIGN KEY (`dia_id`) REFERENCES `bill_transdia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadia_ibfk_3` FOREIGN KEY (`bus_id`) REFERENCES `bill_transbus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_transrutadiabusasiento
-- ----------------------------
DROP TABLE IF EXISTS `bill_transrutadiabusasiento`;
CREATE TABLE `bill_transrutadiabusasiento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fechasalidabus` date NOT NULL,
  `rutadia_id` int(11) DEFAULT NULL,
  `busasiento_id` int(11) NOT NULL,
  `facturaventa_id` int(11) NOT NULL,
  `totasientos` int(11) NOT NULL DEFAULT '0',
  `stock` int(11) NOT NULL DEFAULT '0',
  `ruta_id` int(11) NOT NULL,
  `dia_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  `lugar` varchar(255) DEFAULT NULL,
  `horasalida` time DEFAULT NULL,
  `cliente_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `producto_id` bigint(20) NOT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `punit` double NOT NULL,
  `ptotal` double NOT NULL,
  `bus_id` int(11) NOT NULL,
  `fechaventa` date DEFAULT NULL,
  `horaventa` time DEFAULT NULL,
  `estado` tinyint(1) NOT NULL DEFAULT '1',
  `usuarioname` varchar(45) DEFAULT NULL,
  `asientosxfact` varchar(100) DEFAULT NULL,
  `factsecuencia` varchar(20) DEFAULT NULL,
  `entregado` tinyint(1) DEFAULT '0',
  `entregadoa` varchar(128) DEFAULT NULL,
  `observaciones` varchar(500) DEFAULT NULL,
  `entregadofecha` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_rutadiabusasiento_rutadia1_idx` (`rutadia_id`) USING BTREE,
  KEY `fk_rutadiabusasiento_busasiento1_idx` (`busasiento_id`) USING BTREE,
  KEY `fk_bill_transrutadiabusasiento_billing_facturaventa1_idx` (`facturaventa_id`) USING BTREE,
  KEY `bill_rutaidfk` (`ruta_id`) USING BTREE,
  KEY `bill_diaidfk` (`dia_id`) USING BTREE,
  KEY `fk_bill_transrutadiabusasiento_billing_personacomercio1_idx` (`cliente_id`) USING BTREE,
  KEY `fk_bill_transrutadiabusasiento_billing_producto1_idx` (`producto_id`) USING BTREE,
  KEY `fk_bill_transrutadiabusasiento_bill_transbus1_idx` (`bus_id`) USING BTREE,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_1` FOREIGN KEY (`bus_id`) REFERENCES `bill_transbus` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_2` FOREIGN KEY (`dia_id`) REFERENCES `bill_transdia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_3` FOREIGN KEY (`ruta_id`) REFERENCES `bill_transruta` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_4` FOREIGN KEY (`facturaventa_id`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_5` FOREIGN KEY (`busasiento_id`) REFERENCES `bill_transbusasiento` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_6` FOREIGN KEY (`rutadia_id`) REFERENCES `bill_transrutadia` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_transrutadiabusasiento_ibfk_7` FOREIGN KEY (`producto_id`) REFERENCES `billing_producto` (`codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Table structure for bill_ventatipopago
-- ----------------------------
DROP TABLE IF EXISTS `bill_ventatipopago`;
CREATE TABLE `bill_ventatipopago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venta_id` int(11) NOT NULL,
  `tipopago_id` varchar(3) COLLATE utf8_bin NOT NULL,
  `valor` double(255,2) NOT NULL,
  `fecha` date DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `usuario_id` int(11) NOT NULL,
  `cierre_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fx_ventatipopago_ventaid` (`venta_id`) USING BTREE,
  KEY `fk_ventatipopago_tipopago` (`tipopago_id`) USING BTREE,
  CONSTRAINT `bill_ventatipopago_ibfk_1` FOREIGN KEY (`tipopago_id`) REFERENCES `billing_tipopago` (`cod`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bill_ventatipopago_ibfk_2` FOREIGN KEY (`venta_id`) REFERENCES `billing_facturaventa` (`codigofactventa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=384 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for bill_venta_tipo
-- ----------------------------
DROP TABLE IF EXISTS `bill_venta_tipo`;
CREATE TABLE `bill_venta_tipo` (
  `id` int(11) NOT NULL,
  `tipo` varchar(25) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for cisessions
-- ----------------------------
DROP TABLE IF EXISTS `cisessions`;
CREATE TABLE `cisessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
