/*instalacion de los tipos de transacciones*/
INSERT INTO `billing_tipotransaccion` VALUES ('01', 'Venta', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('02', 'Compra', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('03', 'Recibo Anticipo', 'Cuando se recibe un anticipo del cliente');
INSERT INTO `billing_tipotransaccion` VALUES ('04', 'Conciliacion Anticipo x Transferencia', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('05', 'Cobro CxC', 'Por cobro de las cuentas x cobrar');
INSERT INTO `billing_tipotransaccion` VALUES ('06', 'Conciliacion Cheques Custodio', 'cuando se realiza la conciliacion de los cheques en custodio');
INSERT INTO `billing_tipotransaccion` VALUES ('07', 'Conciliacion Anticipos con Tarj Credito', 'conciliacion de tarjetas de credito por recibo de anticipos');
INSERT INTO `billing_tipotransaccion` VALUES ('08', 'Ajuste Entrada', 'ser realiza el ajuste de entrada de productos');
INSERT INTO `billing_tipotransaccion` VALUES ('09', 'Anulacion Factura Venta', 'cuando se anula una factura de venta');
INSERT INTO `billing_tipotransaccion` VALUES ('10', 'Anulacion Factura Compra', 'cuando se anula una factura de compra');
INSERT INTO `billing_tipotransaccion` VALUES ('11', 'Prefactura Servicio Tecnico', 'cuando se deja facturas en pendiente desde servicio tecnico');
INSERT INTO `billing_tipotransaccion` VALUES ('12', 'Notas Credito Compra', '');
INSERT INTO `billing_tipotransaccion` VALUES ('13', 'Ajuste Salida', '');
INSERT INTO `billing_tipotransaccion` VALUES ('14', 'Retencion Compra', '');
INSERT INTO `billing_tipotransaccion` VALUES ('15', 'Anticipo a Proveedor', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('16', 'Deposito', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('17', 'Cuenta Bancaria', 'Creacion de nueva cuenta bancaria');
INSERT INTO `billing_tipotransaccion` VALUES ('18', 'Anticipo Cliente', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('19', 'Transferencia Bodegas', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('20', 'Retencion Venta', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('21', 'Pago CxP', 'Cuando es un pago de cuentas');
INSERT INTO `billing_tipotransaccion` VALUES ('22', 'Nota Credito Venta', NULL);
INSERT INTO `billing_tipotransaccion` VALUES ('23', 'Comprobante de Pago', NULL);

/*FIN tipos de transacciones*/
/*instalacion de los tipos de pago*/
INSERT INTO `billing_tipopago` VALUES ('01', 'EFECTIVO', 'SIN UTILIZACION DEL SISTEMA FINANCIERO', 'en efectivo', 1, '10101', '10101');
INSERT INTO `billing_tipopago` VALUES ('02', 'CREDITO', NULL, NULL, 1, '10102060101', '201030101');
INSERT INTO `billing_tipopago` VALUES ('03', 'TARJETA DE CREDITO', NULL, NULL, 1, '10102060102', '101020601');
INSERT INTO `billing_tipopago` VALUES ('04', 'CHEQUE', NULL, NULL, 1, '10102060103', '101020601');
INSERT INTO `billing_tipopago` VALUES ('05', 'DIFERIDO', NULL, NULL, 1, '10102060101', '201030101');
INSERT INTO `billing_tipopago` VALUES ('06', 'TRANSFERENCIA', NULL, 'ALSKDFLKFSDA', 1, '101', '101');
INSERT INTO `billing_tipopago` VALUES ('07', 'ANTICIPO', NULL, 'al hacer uso de anticipos', 1, '20110', '1010404');
INSERT INTO `billing_tipopago` VALUES ('08', 'RETENCION', 'Cuando se usa la retencion como parte de pago de la factura', NULL, 1, '20110', '101');
INSERT INTO `billing_tipopago` VALUES ('09', 'FACT. COMPRA', 'Para llenar en el comprobante de pago', NULL, 1, '20110', '20110');
INSERT INTO `billing_tipopago` VALUES ('10', 'OTRO TIPO', 'Usado cuando en el proveedor se configura otra cuenta q no sea cxp proveedores', NULL, 1, '20110', '20110');
INSERT INTO `billing_tipopago` VALUES ('11', 'NOTA CREDITO', 'Cuando pagamos con una nota de credito', NULL, 1, '20110', '20110');

/*FIN instalacion de tipos de pago*/

/*Instalacion tarjetas de creditos*/
INSERT INTO `billing_tarjetacredito` VALUES ('01', 'AMERICAN EXPRESS', null);
INSERT INTO `billing_tarjetacredito` VALUES ('02', 'DINERS CLUB', null);
INSERT INTO `billing_tarjetacredito` VALUES ('04', 'MASTERCARD', null);
INSERT INTO `billing_tarjetacredito` VALUES ('05', 'VISA', null);
INSERT INTO `billing_tarjetacredito` VALUES ('07', 'OTRA TARJETA', null);

/*Fin tarjetas de credito*/

/*Instalacion de Tipos de precio*/
INSERT INTO `billing_tiposprecio` VALUES ('pA', 'Usuario final', 1);
INSERT INTO `billing_tiposprecio` VALUES ('pB', 'Usuario fina con descuento', 1);
INSERT INTO `billing_tiposprecio` VALUES ('pC', 'Usuario fina con descuento', 1);
INSERT INTO `billing_tiposprecio` VALUES ('pD', 'Usuario distribuidor', 1);
INSERT INTO `billing_tiposprecio` VALUES ('pE', 'Usuario concecionario', 1);
INSERT INTO `billing_tiposprecio` VALUES ('pF', 'no especificado', 0);
INSERT INTO `billing_tiposprecio` VALUES ('pG', 'no especificado', 0);

/*FIN Instalacion de Tipos de precio*/

/*Instalacion de tipo de cliente*/
        INSERT INTO `billing_clientetipo` VALUES (1, 'Usuario Final', 'Cliente final', 1, 20.00);
        INSERT INTO `billing_clientetipo` VALUES (2, 'Distribuidores', 'Clientes en compras al por mayor reseller', 1, 10.00);
        INSERT INTO `billing_clientetipo` VALUES (3, 'Concesionarios', 'Franquicias MasterPc', 0, 4.00);

        INSERT INTO `billing_clientetipotiposprecio` VALUES (1, 'pA', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (1, 'pB', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (1, 'pC', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (2, 'pA', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (2, 'pB', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (2, 'pC', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (2, 'pD', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (3, 'pA', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (3, 'pB', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (3, 'pC', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (3, 'pD', NULL);
        INSERT INTO `billing_clientetipotiposprecio` VALUES (3, 'pE', NULL);

/*Fin instalacion de tipÃƒÂ² de cliente*/

/*INSTALACION TIPOS DE TIPOS DE CUENTA*/
	INSERT INTO billing_bancotipocuenta (`id`, `tipocuenta`, `descripcion`)
	VALUES (1, 'ahorros', 'Cta. Ahorros');

	INSERT INTO billing_bancotipocuenta   (`id`, `tipocuenta`, `descripcion`)
	VALUES   (2, 'corriente', 'Cta. Corriente');
/*FIN INSTALACION DE TIPOS DE CUENTA*/

/*Creacion de capacidades (permisos)*/
INSERT INTO `billing_capacidad` VALUES ('admin', 'Administracion del Sistemaddd', '2014-2-12 00:00:00', 1, 'admin.png', 1, 1, '/admin/monitoreo/index', 'Admin', 1, 'enroled', 'module', 'glyphicon glyphicon-cog');
INSERT INTO `billing_capacidad` VALUES ('admin_client', 'PUEDE MODIFICAR LOS DATOS IMPORTANTES DEL CLIENTE COMO CUPO DE CREDITO, ETC', '2014-11-28 10:59:03', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('ajuste_entrada', 'Modulo Ajustes de Entrada', '2014-10-9 19:07:57', 1, NULL, 22, 0, '/ajustentrada/ajustentrada/view', 'Aj. Entrada', 1, 'enroled', 'module', 'glyphicon glyphicon-retweet');
INSERT INTO `billing_capacidad` VALUES ('ajuste_salida', 'Ajustes de Salida', '2014-10-9 19:38:09', 1, NULL, 23, 0, '/ajustesalida/index', 'Aj. Salida', 1, 'enroled', 'module', 'glyphicon glyphicon-new-window');
INSERT INTO `billing_capacidad` VALUES ('anular_compras', '', '2015-1-2 19:49:52', 1, NULL, 1, 0, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('anular_ventas', '', '2015-1-2 20:24:46', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('aplicar_pagos', '', '2015-1-2 19:49:48', 1, NULL, 1, 0, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('archivar_fact', '', '2015-1-5 04:48:29', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('bancos', 'Bancos', '2014-11-3 13:06:10', 1, NULL, 20, 0, '/bancos/index', 'Bancos', 1, 'enroled', 'cargo', 'glyphicon glyphicon-usd');
INSERT INTO `billing_capacidad` VALUES ('boleteria', 'Venta de Boletos', '2014-2-12 00:00:00', 1, NULL, 11, 0, '/modules/trans/vista/boleteria.php', 'Venta de Boletos', 1, 'enroled', 'module', 'glyphicon glyphicon-bookmark');
INSERT INTO `billing_capacidad` VALUES ('caja', 'Cierre de Caja....', '2014-5-23 00:00:00', 1, 'caja.png', 10, 1, '/cierrecaja/index', 'Caja', 1, 'enroled', 'module', 'fa fa-money fa-fw');
INSERT INTO `billing_capacidad` VALUES ('codbarras', 'Codigos Barra', '2014-2-12 00:00:00', 1, 'barcode.png', 9, 0, '/modules/codbarras/vista/vista.php', 'Cod.Barras', 1, 'enroled', 'module', 'glyphicon glyphicon-barcode');
INSERT INTO `billing_capacidad` VALUES ('compras', 'Registro de Compras', '2014-6-10 00:00:00', 1, 'compras.png', 2, 1, '/compras/compras/view', 'Compras', 1, 'enroled', 'module', 'glyphicon glyphicon-download-alt');
INSERT INTO `billing_capacidad` VALUES ('conciliaciones', 'Conciliacion Bancos', '2014-6-10 00:00:00', 1, 'conciliaciones.png', 24, 1, '/modules/conciliaciones/vista/vista.php', 'Conciliaciones', 1, 'enroled', 'module', 'glyphicon glyphicon-transfer');
INSERT INTO `billing_capacidad` VALUES ('contabilidad', 'Contabilidad', '2014-2-12 00:00:00', 1, 'conta.png', 8, 1, '/contabilidad/index', 'Contabilidad', 1, 'enroled', 'module', 'glyphicon glyphicon-book');
INSERT INTO `billing_capacidad` VALUES ('cotizaciones', 'Modulo Cotizaciones', '2014-3-18 11:55:52', 1, 'glyphic_465_server_minus.png', 4, 1, '/cotizacion/ventas/view', 'Cotizaciones', 1, 'enroled', 'module', 'glyphicon glyphicon-shopping-cart');
INSERT INTO `billing_capacidad` VALUES ('cxc', 'Cuentas x Cobrar', '2014-2-12 00:00:00', 1, 'cxc.png', 6, 1, '/cxc/cxc', 'C x C', 1, 'enroled', 'module', 'glyphicon glyphicon-log-in');
INSERT INTO `billing_capacidad` VALUES ('cxp', 'Cuentas x Pagar', '2014-2-12 00:00:00', 1, 'cxp.png', 7, 1, '/cxp/index', 'C x P', 1, 'enroled', 'module', 'glyphicon glyphicon-log-out');
INSERT INTO `billing_capacidad` VALUES ('electronic_fact', '', '2015-1-2 20:24:42', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('garantias', 'Tramite de garantias', '2014-11-21 13:17:11', 1, 'garantias.png', 21, 0, '/garantias/index', 'Garantias', 1, 'enroled', 'module', 'glyphicon glyphicon-transfer');
INSERT INTO `billing_capacidad` VALUES ('inventario', 'Reporte Inventarios', '2014-2-12 00:00:00', 1, 'inventario.png', 5, 1, '/inventario/index', 'Inventario', 1, 'enroled', 'module', 'glyphicon glyphicon-list-alt');
INSERT INTO `billing_capacidad` VALUES ('make_nota_credito', '', '2015-1-2 18:39:22', 1, NULL, 1, 0, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('make_retencion', '', '2015-1-2 19:17:44', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('notra_credito', 'Nota de Credito', '2014-12-16 18:48:00', 1, NULL, 1, 0, '/nota_credito/index', 'Nota Credito', 1, 'enroled', 'module', 'glyphicon glyphicon-usd');
INSERT INTO `billing_capacidad` VALUES ('reportes', 'Visualizacion Reportes', '2014-2-12 00:00:00', 1, 'reportes.png', 11, 1, '/modules/reportes/vista/vista.php', 'Reportes', 1, 'enroled', 'module', 'glyphicon glyphicon-stats');
INSERT INTO `billing_capacidad` VALUES ('servicios', 'Servicios', '2014-12-2 17:05:31', 1, NULL, 10, 1, '/servicios/index', 'Servicios', 1, 'enroled', 'module', 'glyphicon glyphicon-wrench');
INSERT INTO `billing_capacidad` VALUES ('stecnico', 'Servicio Tecnico', '2014-6-30 10:36:06', 1, '', 9, 0, '/stecnico/index/index', 'Servicio Tecnico', 1, 'enroled', 'module', 'glyphicon glyphicon-briefcase');
INSERT INTO `billing_capacidad` VALUES ('tecnico', 'usuarios con rol de tecnico', '2014-7-1 11:51:38', 1, '', 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('transportes', 'Admin Transportes', '2014-6-16 10:26:26', 1, NULL, 12, 0, '/modules/trans/vista/admin.php', 'Transportes', 1, 'enroled', 'module', 'glyphicon glyphicon-road');
INSERT INTO `billing_capacidad` VALUES ('vendedor', 'Usuario para establecerse covmo vendedor en la factura', '2014-2-17 00:00:00', 1, NULL, 1, 1, '', '', 1, 'enroled', 'cargo', NULL);
INSERT INTO `billing_capacidad` VALUES ('ventas', 'Facturacion', '2014-2-12 00:00:00', 1, 'ventas.png', 3, 1, '/ventas/ventas/view', 'Ventas', 1, 'enroled', 'module', 'glyphicon glyphicon-usd');

/*Fin creacion de capacidades (permisos)*/

/*CREAR CARGO GLOBAL */
INSERT INTO billing_cargosempleado (`id`, `nombreCargo`, `descripcion`, `numorden`, `fCreacion`, `estaActivo`) VALUES (1, 'Global', 'Creado por el sistema', 1,CURRENT_DATE(), 1);

/*Instalacion documento de tipo de identificacion*/
INSERT INTO `billing_docidentificaciontipo` VALUES (1, 'ruc', 'registro unico de comprobante', '04');
INSERT INTO `billing_docidentificaciontipo` VALUES (2, 'cedula', 'cedula de identidad ecuatoriana', '05');
INSERT INTO `billing_docidentificaciontipo` VALUES (3, 'pasaporte', 'para extrajeros', '06');
INSERT INTO `billing_docidentificaciontipo` VALUES (4, 'venta a consumidor final', NULL, '07');
INSERT INTO `billing_docidentificaciontipo` VALUES (5, 'identificacion del exterior', NULL, '08');
INSERT INTO `billing_docidentificaciontipo` VALUES (6, 'placa', NULL, '09');

/*FIn Instalacion documento de tipo de identificacion*/


/*Instalacion de tipos de producto*/
INSERT INTO `billing_productotipo` VALUES (1, 'Almacenable/Inventario', 'Se definen de este tipo los productos cuya reposiciÃƒÆ’Ã‚Â³n debe ser mÃƒÆ’Ã‚Â¡s o menos automatizada, segÃƒÆ’Ã‚Âºn reglas definidas en el sistema. Crean movimientos de almacÃƒÆ’Ã‚Â©n y se controla su stock', 1, NULL);
INSERT INTO `billing_productotipo` VALUES (2, 'Consumible/Activo', 'Se pueden recibir, distribuir o fabricar. Sin embargo, su nivel de existencias no estÃƒÆ’Ã‚Â¡ gestionado por el sistema. En el ERP se da por supuesto que hay un nivel suficiente de existencias en todo momento. No generan movimientos de entrada y salida de almacÃƒÆ’Ã‚Â©n automÃƒÆ’Ã‚Â¡ticos.', 1, NULL);
INSERT INTO `billing_productotipo` VALUES (3, 'Servicio', 'Sin control de stock. No aparecen en las diversas operaciones de almacÃƒÆ’Ã‚Â©n. Por ejemplo, un servicio de consultorÃƒÆ’Ã‚Â­a. Pueden generar compras (si es un servicio que se compra: SubcontrataciÃƒÆ’Ã‚Â³n) o puede generar tareas (si es un servicio que se produce).', 1, NULL);

/*Instalacion de bodegas*/
INSERT INTO `billing_bodega` VALUES (1, 'General', 'Bodega Por Default', 1, 1, 0, 0);
INSERT INTO `billing_bodega` VALUES (2, 'Servicios', 'Bodega Pen donde se agrupan los servicios', 1, 0, 0, 0);


/* CREAR SUCURSAL Y DEPARTAMENTOS iniciales */
	INSERT INTO billing_sucursal (`idSucursal`, `nombre`, `pais`, `ciudad`, `direccion`, `telefono`, `email`, `sitioWeb`, `prefix`, `fechaRegistroSucursal`, `estaActiva`)
	VALUES (0, 'Principal', 'Ecuador', 'Loja', '...', '25783933', 'admin@nn.com', 'www.softwarepuntopymes.com', NULL, CURRENT_DATE(), 1 );

/* CREAR DEPARTAMENTO GLOBAL*/
	INSERT INTO billing_departamento
 	  (`idDepartamento`, `nombre`, `ubicacion`, `descripcion`, `numorden`, `eliminado`, `fechacreacion`)
	VALUES
  	 (1, 'Global', '..', 'Dep. Global creado en la instalacion', 1, 0, CURRENT_DATE());

/* creamos un superusuario */

INSERT INTO `billing_empleado` VALUES (1, '1111111111', 'admin', 'a34d4c0c4b70b4bcbc95c15e13f6a84c', 'Esteban', 'Chamba', 'eychamba@masterpc.com.ec', NULL, NULL, 1, NULL, '2014-8-21', NULL, NULL, NULL, 1, 1, 1, 0);

/* Atributos del producto -- por default solo serie , se usa al momento en que se realiza la compra */
INSERT INTO `bill_prodattr` VALUES (1, 'SERIE');

/* Creamos los impuestos tabla bill_impuesto */
INSERT INTO `bill_impuesto` VALUES (2, 'IVA');
INSERT INTO `bill_impuesto` VALUES (3, 'ICE');

INSERT INTO `bill_impuestotarifa` VALUES (1, 0, 0, 'IVA - TARIFA CERO', 2);
INSERT INTO `bill_impuestotarifa` VALUES (2, 2, 12, 'IVA - TARIFA DOCE', 2);
INSERT INTO `bill_impuestotarifa` VALUES (6, 6, 0, 'IVA - NO OBJETO DE IMPUESTOS', 2);

/*..Tipos de proveedor..*/
INSERT INTO `bill_proveedortipo` VALUES (1, 'Nacional', NULL);
INSERT INTO `bill_proveedortipo` VALUES (2, 'Extranjero', NULL);

/*.. Tipo de asiento contable */
INSERT INTO `bill_contasientotipo` VALUES (1, 'Venta', 'Asiento contable de una compra, los de este tipo se muestran en el cierre de caja');
INSERT INTO `bill_contasientotipo` VALUES (2, 'Costo de Ventas', 'costo ventas para resultados, se registra junto con las ventas, pero no se muestra en el cierre de caja');
INSERT INTO `bill_contasientotipo` VALUES (3, 'Compra', 'Cuando se realiza una compra, no se refleja en el cierre de caja');
INSERT INTO `bill_contasientotipo` VALUES (4, 'Ajuste Entrada', 'Cuando se registra el asiento contable de un ajuste de entrada');
INSERT INTO `bill_contasientotipo` VALUES (5, 'CxP', 'Por pago de cuentas a proveedores');
INSERT INTO `bill_contasientotipo` VALUES (6, 'Anticipo Proveedor', NULL);
INSERT INTO `bill_contasientotipo` VALUES (7, 'Nueva cuenta bancaria', NULL);
INSERT INTO `bill_contasientotipo` VALUES (8, 'Cobro CxC', 'Por cobro de cuentas por cobrar');
INSERT INTO `bill_contasientotipo` VALUES (9, 'Retencion Compra', 'Cuando se realiza una retencion de la compra');
INSERT INTO `bill_contasientotipo` VALUES (10, 'Retencion Venta', 'Cuando registramos una retencion de una ventas');
INSERT INTO `bill_contasientotipo` VALUES (11, 'Nota Credito Compra', 'Cuando registramos una nota de credito que nos dejan (compra)');
INSERT INTO `bill_contasientotipo` VALUES (12, 'Nota Credito Venta', NULL);

/* Tipos de compra */
INSERT INTO `bill_compratipo` VALUES (1, 'Mercaderia', 'compra normal, se carga a mercaderias');
INSERT INTO `bill_compratipo` VALUES (2, 'Gasto', NULL);
INSERT INTO `bill_compratipo` VALUES (3, 'Activo Fijo', NULL);


-- ----------------------------
-- Records of bill_sri_forma_pago
-- ----------------------------
INSERT INTO `bill_sri_forma_pago` VALUES ('01', 'SIN UTILIZACION DEL SISTEMA FINANCIERO');
INSERT INTO `bill_sri_forma_pago` VALUES ('02', 'CHEQUE PROPIO');
INSERT INTO `bill_sri_forma_pago` VALUES ('03', 'CHEQUE CERTIFICADO');
INSERT INTO `bill_sri_forma_pago` VALUES ('04', 'CHEQUE DE GERENCIA');
INSERT INTO `bill_sri_forma_pago` VALUES ('05', 'CHEQUE DEL EXTERIOR');
INSERT INTO `bill_sri_forma_pago` VALUES ('06', 'DÉBITO DE CUENTA');
INSERT INTO `bill_sri_forma_pago` VALUES ('07', 'TRANSFERENCIA PROPIO BANCO');
INSERT INTO `bill_sri_forma_pago` VALUES ('08', 'TRANSFERENCIA OTRO BANCO NACIONAL');
INSERT INTO `bill_sri_forma_pago` VALUES ('09', 'TRANSFERENCIA  BANCO EXTERIOR');
INSERT INTO `bill_sri_forma_pago` VALUES ('10', 'TARJETA DE CRÉDITO NACIONAL');
INSERT INTO `bill_sri_forma_pago` VALUES ('11', 'TARJETA DE CRÉDITO INTERNACIONAL');
INSERT INTO `bill_sri_forma_pago` VALUES ('12', 'GIRO');
INSERT INTO `bill_sri_forma_pago` VALUES ('13', 'DEPOSITO EN CUENTA (CORRIENTE/AHORROS)');
INSERT INTO `bill_sri_forma_pago` VALUES ('14', 'ENDOSO DE INVERSIÒN');
INSERT INTO `bill_sri_forma_pago` VALUES ('15', 'COMPENSACIÓN DE DEUDAS');

/*
 * Codigos de retencion RENTA , IVA
*/
INSERT INTO `bill_sri_retencion` VALUES (328, '303', 'Honorarios profesionales y dietas', 10, '101010101', '101010101', 'RENTA', 'iva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (329, '304', 'Servicios predomina el intelecto', 8, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (330, '307', 'Servicios predomina la mano de obra', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (331, '308', 'Servicios entre sociedades', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (332, '309', 'Servicios publicidad y comunicación', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (333, '310', 'Servicio transporte privado de pasajeros o servicio público o privado de carga', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (334, '312', 'Transferencia de bienes muebles de naturaleza corporal', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (335, '319', 'Arrendamiento mercantil', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (336, '320', 'Arrendamiento bienes inmuebles', 8, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (337, '322', 'Seguros y reaseguros (primas y cesiones)', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (338, '323', 'Por rendimientos financieros (No aplica para IFIs)', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (339, '323A', 'Por RF: depósitos Cta Corriente', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (340, '323B1', 'Por RF:  depósitos Cta Ahorros Sociedades', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (341, '323B2', 'Por RF:  depósitos Cta Ahorros Persona Natural', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (342, '323C', 'Por rendimientos financieros:  depósitos en cuentas exentas', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (343, '323D', 'Por rendimientos financieros: compra, cancelación o redención de mini bem´s y bem´s', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (344, '323E', 'Por RF: depósito a plazo', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (345, '323F', 'Por rendimientos financieros: operaciones de reporto - repos', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (346, '323G', 'Por RF: inversiones (captaciones)', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (347, '323H', 'Por RF: obligaciones', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (348, '323I', 'Por RF: bonos convertible en acciones', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (349, '323J', 'Por RF: bonos de organismos y gobiernos extranjeros', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (350, '323K', 'Por RF: entre IFI\'s', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (351, '325', 'Por loterías, rifas, apuestas y similares', 15, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (352, '327', 'Por venta de combustibles a comercializadoras ', 2000, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (353, '328', 'Por venta de combustibles a distribuidores', 3000, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (354, '332', 'Otras compras de bienes y servicios no sujetas a retención', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (355, '333', 'Convenio de Débito o Recaudación', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (356, '334', 'Por compras con tarjeta de crédito', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (357, '336', 'Reembolso de Gasto - Compra Intermediario', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (358, '337', 'Reembolso de Gasto - Compra de quien asume el gasto', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (359, '340', 'Otras retenciones aplicables el 1%', 1, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (360, '341', 'Otras retenciones aplicables el 2%', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (361, '342', 'Otras retenciones aplicables el 8%', 8, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (362, '343', 'Otras retenciones aplicables a la tarifa de impuesto a la renta prevista para sociedades', 22, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (363, '344', 'Otras retenciones aplicables a otros porcentajes', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (364, '345', 'Dividendos personas naturales residentes', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (365, '346', 'Dividendos sociedades en paraísos fiscales', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (366, '347', 'Dividendos anticipados', 22, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (367, '348', 'Compra local de banano a productor', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (368, '349', 'Impuesto a la actividad bananera productor-exportador', 2, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (369, '500', 'Pago al exterior - Rentas Inmobiliarias', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (370, '501', 'Pago al exterior - Beneficios Empresariales', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (371, '502', 'Pago al exterior - Servicios Empresariales', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (372, '503', 'Pago al exterior - Navegación Marítima y/o aérea', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (373, '504', 'Pago al exterior - Dividendos', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (374, '505', 'Pago al exterior - Intereses', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (375, '506', 'Pago al exterior - Intereses por Finaciamiento de proveedores externos', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (376, '507', 'Pago al exterior - Intereses de créditos externos', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (377, '508', 'Pago al exterior - Créditos de IFI\'s organismos y gobierno a gobierno', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (378, '509', 'Pago al exterior - Cánones o regalías', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (379, '510', 'Pago al exterior - Ganancias de capital', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (380, '511', 'Pago al exterior - Servicios profesionales independientes', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (381, '512', 'Pago al exterior - Servicios profesionales dependientes', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (382, '513', 'Pago al exterior - Artistas y deportistas', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (383, '514', 'Pago al exterior - Participación de consejeros', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (384, '515', 'Pago al exterior - Entretenimiento Público', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (385, '516', 'Pago al exterior - Pensiones', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (386, '517', 'Pago al exterior - Reembolso de Gastos', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (387, '518', 'Pago al exterior - Funciones Pùblicas', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (388, '519', 'Pago al exterior - Estudiantes', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (389, '520', 'Pago al exterior - Por otros conceptos ', 0, '101010101', '101010101', 'RENTA', 'baseiva', 'baseiva');
INSERT INTO `bill_sri_retencion` VALUES (390, '1', 'Retencion de IVA bienes ', 30, '101010101', '101010101', 'IVA', 'iva_bienes', 'ivaval');
INSERT INTO `bill_sri_retencion` VALUES (391, '2', 'Retencion de IVA Servicios ', 70, '101010101', '101010101', 'IVA', 'iva_servicios', 'ivaval');
INSERT INTO `bill_sri_retencion` VALUES (392, '3', 'Retencion de IVA total (Arriendos, honorarios, etc)', 100, '101010101', '101010101', 'IVA', 'iva', 'ivaval');
/******************************************************/
INSERT INTO `bill_sri_retencionimpuesto` VALUES (1, 'RENTA', NULL);
INSERT INTO `bill_sri_retencionimpuesto` VALUES (2, 'IVA', NULL);
/******************************************************/
/* Los meses */
INSERT INTO `bill_mes` VALUES (1, 'ENERO');
INSERT INTO `bill_mes` VALUES (2, 'FEBRERO');
INSERT INTO `bill_mes` VALUES (3, 'MARZO');
INSERT INTO `bill_mes` VALUES (4, 'ABRIL');
INSERT INTO `bill_mes` VALUES (5, 'MAYO');
INSERT INTO `bill_mes` VALUES (6, 'JUNIO');
INSERT INTO `bill_mes` VALUES (7, 'JULIO');
INSERT INTO `bill_mes` VALUES (8, 'AGOSTO');
INSERT INTO `bill_mes` VALUES (9, 'SEPTIEMBRE');
INSERT INTO `bill_mes` VALUES (10, 'OCTUBRE');
INSERT INTO `bill_mes` VALUES (11, 'NOVIEMBRE');
INSERT INTO `bill_mes` VALUES (12, 'DICIEMBRE');

/************************************************************/
INSERT INTO `bill_recibo_tipo` VALUES (1, 'CxC');
INSERT INTO `bill_recibo_tipo` VALUES (2, 'ANTICIPO_CLIENTE');
INSERT INTO `bill_recibo_tipo` VALUES (3, 'OTROS');

/************************************************************/
INSERT INTO `bill_cuentabancaria_tipo` VALUES (1, 'CHEQUE');
INSERT INTO `bill_cuentabancaria_tipo` VALUES (2, 'DEPOSITO/TRANSFERENCIA');
INSERT INTO `bill_cuentabancaria_tipo` VALUES (3, 'TARJETA CREDITO');
INSERT INTO `bill_cuentabancaria_tipo` VALUES (4, 'SALDO INICIAL');
/************************************************************/

INSERT INTO `bill_settings` VALUES (1, 'IVA', '12', 'iva vigente');
INSERT INTO `bill_settings` VALUES (2, 'SRI_FORMA_PAGO', '02', 'codigo x default de la forma de pago para ventas mayores a 100 dolares');
INSERT INTO `bill_settings` VALUES (3, 'PAGO_COMPRA_AFTER', '1', 'mostrar o no las formas de pago despues de grabar la factura');
INSERT INTO `bill_settings` VALUES (4, 'DESTROY_AFTER_COMPRA', '0', 'vaciar carrito de compras despues de la compra');
INSERT INTO `bill_settings` VALUES (5, 'DESRTOY_AFTER_VENTA', '0', 'vaciar carrito de compras despues de la venta');
INSERT INTO `bill_settings` VALUES (6, 'RAZON_SOCIAL', 'MASTER PC CIA. LTDA.', NULL);
INSERT INTO `bill_settings` VALUES (7, 'CIUDAD', 'Loja', NULL);
INSERT INTO `bill_settings` VALUES (8, 'NUM_DECIMALES', '2', 'Numero de decimales q se usara en el sistema');
INSERT INTO `bill_settings` VALUES (9, 'DIAS_DIFERIDO', '30', 'A cuantos dias se hace el calculo de las cuotas en diferido');
INSERT INTO `bill_settings` VALUES (11, 'DEFAULT_UTILIDAD', '50', '50 por ciento.. utilidad por defecto');
INSERT INTO `bill_settings` VALUES (12, 'GTIN_PAIS_COD_BARRAS', '786', 'Dijitos para identificador del pais, para codigo barras');
INSERT INTO `bill_settings` VALUES (13, 'GTIN_EMPR_COD_BARRAS', '12345', 'Dijitos para identificador de la empresa, para codigo barras');
INSERT INTO `bill_settings` VALUES (14, 'SYSTEM_NAME', 'Billingsof', 'Nombre del Sistema');
INSERT INTO `bill_settings` VALUES (15, 'ELECTRONIC_WS_FACT', 'http://186.5.31.52:8080/MavenEnterpriseApp-web/FacturacionWS?WSDL', NULL);
INSERT INTO `bill_settings` VALUES (16, 'ELECTRONIC_WS_RETENCION', 'http://186.5.31.52:8080/MavenEnterpriseApp-web/RetencionWS?WSDL', NULL);
INSERT INTO `bill_settings` VALUES (17, 'ELECTRONIC_XML_PATH', 'c:\\archivos\\', 'xml de la factura para enviarla al webservice');
INSERT INTO `bill_settings` VALUES (18, 'ELECTRONIC_FACT', '1', '1 Si se debe aplicar la factura electronica, 0 si no se debe aplicar');
INSERT INTO `bill_settings` VALUES (19, 'ELECTRONIC_RETENCION', '0', '1 Si se debe aplicar la retencion electronica, 0 si no se debe aplicar');
INSERT INTO `bill_settings` VALUES (20, 'PASSWORDSALTMAIN', 'A3!1VGDDAifLJSRWI0p?gH:y', 'clave de encriptacion');
INSERT INTO `bill_settings` VALUES (21, 'COSTO_VENTA_FIELD', 'costopromediokardex', 'Costo para calcular el precio de venta ( costo promedio o costo ultimo )');
INSERT INTO `bill_settings` VALUES (22, 'NO_RETENCION_COD', '', 'Codigo para las facturas que no aplican retencion ');
INSERT INTO `bill_settings` VALUES (23, 'ACTIVATE_KEY', '', NULL);
INSERT INTO `bill_settings` VALUES (24, 'DOWNLOAD_FACT_XML', 'http://186.5.31.52:8080/MavenEnterpriseApp-web/', NULL);


/* CLASE DE CONTRIBUYENTE */
INSERT INTO `bill_contribuyente_clase` VALUES (1, 'ESPECIAL', 'CONTRIBUYENTE ESPECIAL');
INSERT INTO `bill_contribuyente_clase` VALUES (2, 'OTROS', 'OTROS');
INSERT INTO `bill_contribuyente_clase` VALUES (3, 'RISE', 'RISE');

/* TIPO DE CONTRIBUYENTE */
INSERT INTO `bill_contribuyente_tipo` VALUES (1, 'NATURAL', 'NATURAL');
INSERT INTO `bill_contribuyente_tipo` VALUES (2, 'SOCIEDAD', 'SOCIEDADES');

INSERT INTO `bill_ndc_tipo_cobro` VALUES (1, 'ANTICIPO PROVEEDOR', 'SE USA COMO UN ANTICIPO AL PROVEEDOR');
INSERT INTO `bill_ndc_tipo_cobro` VALUES (2, 'BAJA CXP', 'SE BAJA LA CXP DE ESA FACTURA');
INSERT INTO `bill_ndc_tipo_cobro` VALUES (3, 'ANTICIPO CLIENTE', 'SE CREA COMO ANTICIPO AL CLIENTE');

/* identifica los dos tipos de venta, que puede ser a credito y a contado */
INSERT INTO `bill_venta_tipo` VALUES (1, 'EFECTIVO');
INSERT INTO `bill_venta_tipo` VALUES (2, 'CREDITO');


/* Estadi de cheques en custodio */
INSERT INTO `bill_cheque_estado` VALUES (-1, 'Anulado');
INSERT INTO `bill_cheque_estado` VALUES (0, 'Protestado');
INSERT INTO `bill_cheque_estado` VALUES (1, 'Registrado');
INSERT INTO `bill_cheque_estado` VALUES (2, 'Por confirmar');
INSERT INTO `bill_cheque_estado` VALUES (3, 'Depositado');
