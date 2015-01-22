<?php

if (!defined('BASEPATH'))
    exit('No esta permitido el acceso');

include_once("soapclientauth.php");

//La primera línea impide el acceso directo a este script
class FactElectronica_XXXX {
    protected $xml = null;
    protected $path_xml_generado;
    protected $factura;
    protected $cliente;
    protected $detalles;
    protected $tipo_ident;
    protected $parametros;
    protected $ambiente;
    protected $emision;
    protected $ci;
    protected $empresa;
    protected $server;
    protected $contribuyente;
    protected $url_ws_recepcion;
    protected $url_ws_autorizacion;

    /* Parametros del constructor:
    Ambiente = 1 pruebas, 2 produccion
    Tipo de Emision = Normal 1, Emisión por Indisponibilidad del Sistema=2
    */
    function __construct(){
        $this->ambiente = 1;
        $this->emision = 1;
        $this->encript = new encript();
        $this->server = get_settings('TEST_ELECTRONIC_WS_FACT');
        $this->path_xml_generado = get_settings('TEST_ELECTRONIC_XML_PATH');
        
        $this->url_ws_recepcion = get_settings('TEST_SRI_URL_RECEPCION');
        $this->url_ws_autorizacion = get_settings('TEST_SRI_URL_AUTORIZACION');
        
        $this->ci = & get_instance();
    }

    /*
     * Metodo que carga la informacion de la factura que fue generada y posteriormente inicia el proceso
     * de armado del archivo xml
     */

    public function generar($id_factura) {
        $this->factura = $this->ci->generic_model->get_by_id('billing_facturaventa', $id_factura,'','codigofactventa');
        
        $this->generar_cabezera_xml();
        $this->generar_info_tributaria();

        $cliente_ci = $this->factura->cliente_cedulaRuc;
        $this->cliente = $this->ci->generic_model->get_by_id('billing_cliente', $cliente_ci,'','PersonaComercio_cedulaRuc');
        
//        print_r($this->cliente);
        
        $id_identificacion_tipo = $this->cliente->docidentificacion_id;

        $this->tipo_identificacion = $this->ci->generic_model->get_by_id('billing_docidentificaciontipo', $id_identificacion_tipo,'','iddocidentificaciontipo');
        $this->detalles = $this->ci->generic_model->get('billing_facturaventadetalle', array('facturaventa_codigofactventa'=>$id_factura), '', null );
        $this->generar_info_factura();
        $this->generar_detalles();
        
        $this->guardar_xml('fact_'.$id_factura.'.xml');
        $res = $this->send_file('fact_'.$id_factura.'.xml');
        
        return $res;
    }

    /*
     * Metodo que crea un clase SimpleXMLElement que sería el nodo raiz del xmnl
     */

    function generar_cabezera_xml() {
        $this->xml = new SimpleXMLElement('<factura id="comprobante" version="1.0.0"></factura>');
    }

    /*
     * Funcion genera la informacion para el nodo infoTributaria, esta informacion se refiera a datos relacionados
     * con datos de la empresa que emite la factura.
     */

    function generar_info_tributaria() {
        $this->empresa = $this->ci->generic_model->get('billing_empresa', array('id >'=> '0'), '', null, 1 );
        $this->contribuyente=$this->ci->generic_model->get_by_id('bill_contribuyente', $this->empresa->contribuyente_id, '', 'id');

        $info_tributaria = $this->xml->addChild("infoTributaria");
        $info_tributaria->addChild('ambiente', $this->ambiente);
        $info_tributaria->addChild('tipoEmision', $this->emision);
        if($this->ambiente==1){
            $info_tributaria->addChild('razonSocial', 'PRUEBAS SERVICIO DE RENTAS INTERNAS');
        }else{
            $info_tributaria->addChild('razonSocial', $this->empresa->razonSocial);
        }
        $info_tributaria->addChild('nombreComercial', $this->empresa->nombreComercial);
//        $info_tributaria->addChild('ruc', $this->parametros->getRuc());
        $info_tributaria->addChild('ruc', $this->encript->decryptbase64($this->empresa->ruc,  get_settings('PASSWORDSALTMAIN')));
//        $info_tributaria->addChild('ruc', '1191732525001');
        $info_tributaria->addChild('claveAcceso', "1111111111111111111111111111111111111111111111111");
        $info_tributaria->addChild('codDoc', str_pad(1,2,"0",STR_PAD_LEFT));
        $info_tributaria->addChild('estab', $this->factura->puntoventaempleado_establecimiento);
        $info_tributaria->addChild('ptoEmi', $this->factura->puntoventaempleado_puntoemision);
        $info_tributaria->addChild('secuencial', str_pad($this->factura->secuenciafactventa, 9, "0", STR_PAD_LEFT));
//        $info_tributaria->addChild('secuencial', str_pad(526, 9, "0", STR_PAD_LEFT));
        $info_tributaria->addChild('dirMatriz', $this->empresa->direccion);
    }

    /*
     * Metodo que genera la informacion para el nodo infoFactura, este informacion esta relacionada
     * al datos generales de la factura
     */

    function generar_info_factura() {
        $info_factura = $this->xml->addChild("infoFactura");
        $fecha_aux = $this->factura->fechaCreacion;
        $fecha_emision = date("d/m/Y", strtotime($fecha_aux));
        $info_factura->addChild('fechaEmision', $fecha_emision);
        $info_factura->addChild('dirEstablecimiento', $this->cliente->direccion);
//      Campo no obligatorio
        if($this->contribuyente->clase=="ESPECIAL"){
            $info_factura->addChild('contribuyenteEspecial', $this->contribuyente->resolucion);
        }
//      Campo no obligatorio
        if($this->contribuyente->contabilidad=="SI"){
            $info_factura->addChild('obligadoContabilidad', $this->contribuyente->contabilidad);
        }
//        $info_factura->addChild('tipoIdentificacionComprador', str_pad($this->cliente->docidentificacion_id,2,"0",STR_PAD_LEFT));
        $info_factura->addChild('tipoIdentificacionComprador', $this->tipo_identificacion->cod);
//      Campo no obligatorio, se puede llenar
//      $info_factura->addChild('guiaRemision', '111-111-111111111');
//        if($this->cliente->docidentificacion_id==7){
        
        if($this->tipo_identificacion->cod=='07'){
            $info_factura->addChild('razonSocialComprador', 'CONSUMIDOR FINAL');
            $info_factura->addChild('identificacionComprador', str_pad(9,13,"9",STR_PAD_LEFT));
        }else{
            if($this->ambiente==1){
                $info_factura->addChild('razonSocialComprador', 'PRUEBAS SERVICIO DE RENTAS INTERNAS');
                
            }else{
                $info_factura->addChild('razonSocialComprador', $this->cliente->razonSocial);
            }
            $info_factura->addChild('identificacionComprador', $this->cliente->PersonaComercio_cedulaRuc);
        }
        $totalSinImpuestos = number_decimal($this->factura->subtotalNeto);
        $info_factura->addChild('totalSinImpuestos', $totalSinImpuestos);
        $totalDescuento = number_decimal($this->factura->descuentovalor);
        $info_factura->addChild('totalDescuento', $totalDescuento);
        $this->armar_total_con_impuestos($info_factura);
        $info_factura->addChild('propina', '0.00');
        $importeTotal = number_decimal($this->factura->totalCompra);
        $info_factura->addChild('importeTotal', $importeTotal);
//      Campo no obligatorio, se puede llenar
//        $info_factura->addChild('moneda', '');
    }

    /*
     * Se genera la informacion para el nodo detalles, referente a los detalles del comprobante
     */

    function generar_detalles() {
        $detalles = $this->xml->addChild("detalles");

        foreach ($this->detalles as $item) {
            $detalle = $detalles->addChild('detalle');
            $producto = $this->ci->generic_model->get_by_id('billing_producto', $item->Producto_codigo,'','codigo');
            $detalle->addChild('codigoPrincipal', $producto->codigo);
            $detalle->addChild('descripcion', $producto->nombreUnico);
            $detalle->addChild('cantidad', $item->itemcantidad);
            $precioUnitario = number_decimal($item->itempreciobruto);
            $detalle->addChild('precioUnitario', $precioUnitario);
            $descuento = number_decimal($item->descuentofactvalor);
            $detalle->addChild('descuento', $descuento);
            $precioTotalSinImpuesto = number_decimal($item->itemprecioxcantidadneto);
            $detalle->addChild('precioTotalSinImpuesto', $precioTotalSinImpuesto);
            $this->armar_detalles_adicionales($detalle, $producto->marca_id);
            $this->armar_impuestos($detalle, $item);
        }
    }

    /*
     * Se genera informacion adicional , no es obligatorio
     */

    function generar_info_adicional() {
        $info_adicional = $this->xml->addChild("infoAdicional");
        $campo_adicional = $info_adicional->addChild("campoAdicional");
        $campo_adicional->addAttribute('xxx', 'yyyyy');
    }

    /*
     * Se genera informacion del total para cada impuesto generado en el comprobante
     */

    function armar_total_con_impuestos($info_factura) {
        $total_con_impuestos = $info_factura->addChild("totalConImpuestos");
        $this->armar_total_impuesto_iva($total_con_impuestos);
    }

    /*
     * Metodo que genera el valor total del IVA 
     */

    function armar_total_impuesto_iva($total_con_impuestos) {
        $total_impuesto = $total_con_impuestos->addChild('totalImpuesto');
        $where_data=array('facturaventa_codigofactventa'=>$this->factura->codigofactventa);
        $detalle=$this->ci->generic_model->get('billing_facturaventadetalle', $where_data, '', null );
        $baseImponible=0;
        $valor=0;
        foreach ($detalle as $value) {
            $baseImponible = $baseImponible + number_decimal($value->totalpriceice);
            $valor = $valor + number_decimal($value->totivaval);
        }
        $rta = $this->codigo_porcentaje_iva($value->Producto_codigo);
        $total_impuesto->addChild('codigo', $rta[0]->impuesto_id);
        $total_impuesto->addChild('codigoPorcentaje', $rta[0]->cod);
        
        $total_impuesto->addChild('baseImponible', $baseImponible);
        $total_impuesto->addChild('valor', $valor);   
    }

    /*
     * Funcion que genera detalles adicionales referentes a los productos, no es obligatorio
     */

    function armar_detalles_adicionales($detalle, $id_marca) {
        $marca = $this->ci->generic_model->get_by_id('billing_marca', $id_marca,'','id');
        $detalles_adicionales = $detalle->addChild("detallesAdicionales");
        $det_adicional = $detalles_adicionales->addChild('detAdicional');
        $det_adicional->addAttribute('nombre', 'Marca');
        $det_adicional->addAttribute('valor', $marca->nombre);
    }

    /*
     * Funcion que genera los valores de los impuestos por cada detalle del comprobante
     */

    function armar_impuestos($detalle, $item) {
        $impuestos = $detalle->addChild("impuestos");
        $this->armar_impuesto_iva($impuestos, $item);
    }

    /*
     * Funcion que genera los valores del IVA por cada detalle del comprobante
     */

    function armar_impuesto_iva($impuestos, $item) {
        $impuesto = $impuestos->addChild('impuesto');
        $rta = $this->codigo_porcentaje_iva($item->Producto_codigo);
        $impuesto->addChild('codigo', $rta[0]->impuesto_id);
        $impuesto->addChild('codigoPorcentaje', $rta[0]->cod);
        $impuesto->addChild('tarifa', $rta[0]->tarporcent);
        $baseImponible = number_decimal($item->itemprecioxcantidadneto);
        $impuesto->addChild('baseImponible', $baseImponible);
        $valor = number_decimal($item->ivavalprecioxcantidadneto);
        $impuesto->addChild('valor', $valor);
    }

    /*
      Funcion que guarda el documento xml
     */

    function guardar_xml($name_xml) {
        $dom_sxe = dom_import_simplexml($this->xml);
        if (!$dom_sxe) {
            echo 'Error al convertir a XML';
            exit;
        }

        $dom = new DOMDocument('1.0', 'UTF-8');
        $dom_sxe = $dom->importNode($dom_sxe, true);
        $dom_sxe = $dom->appendChild($dom_sxe);
        $dom->formatOutput = true;
        $el_xml = $dom->saveXML();
        $dom->save($this->path_xml_generado.$name_xml);
    }

    private function codigo_porcentaje_iva($codigo_producto){
        $where_data=array('bill_productoimpuestotarifa.producto_id'=>$codigo_producto);
        $join_cluase=array(
                '0'=>array('table'=>'bill_impuestotarifa','condition'=>'bill_impuestotarifa.id = bill_productoimpuestotarifa.impuestotarifa_id'));
        $fields=array('bill_impuestotarifa.cod','bill_impuestotarifa.tarporcent','bill_impuestotarifa.impuesto_id');
        $rta=$this->ci->generic_model->get_join('bill_productoimpuestotarifa', $where_data, $join_cluase, $fields, 0);
        //print_r($rta);
        return $rta;
    }

    /*
     * Funcion que permite enviar el archivo xml generado al WebService de facturacion, y este
     * posteriormente lo enviara el web service del sri
     */

    public function send_file($name_xml) {
        $res = $this->webService($this->path_xml_generado.$name_xml);
        return $res;
    }

    function webService($filename) {
//        Se inicia una clase SoapClientAuth, donde se fija la direccion del servicio web y crea un cliente soap
//        para el web service establecido
//        $soapClient = new SoapClientAuth('http://localhost:8080/MavenEnterpriseApp-web/FacturacionWS?WSDL', array(
//            'login' => 'username',
//            'password' => 'password'
//        ));

        libxml_disable_entity_loader(false);
        $soapClient = new SoapClientAuth($this->server, array(
            'login' => 'username',
            'password' => 'password'
        ));

//        Se verifica que exita el archivo xml y posteriormente se lo transforma a un arreglo 
//        de bytes de base 64
        if (!($fp = fopen($filename, "r"))) {
            echo "Error opening file";
            exit;
        }
        $data = "";
        while (!feof($fp)) {
            $data .= fread($fp, 1024);
        }
        fclose($fp);
        $byteFile = base64_encode($data);
//        Se establecen los variables y sus valores para ser enviados al metodo recepcion 
//        expuesto en el web service, el mismo que nos devolvera un mensaje con informacion
//        referente al proceso de facturacion electronica
        $message = array('buffer' => $byteFile, 'user' => 'admin', 'email'=>$this->cliente->email);
        $respuesta = $soapClient->recepcion($message)->{"return"};
        return $respuesta;
    }
}

?>