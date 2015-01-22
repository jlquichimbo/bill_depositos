<?php

if (!defined('BASEPATH'))
    exit('No esta permitido el acceso');

include_once("SoapClientAuth.php");

//La primera línea impide el acceso directo a este script
class RetencionElectronica {
    protected $xml = null;
    protected $path_xml_generado;
    protected $facturaCompra;
    protected $proveedor;
    protected $impuestos;
    protected $tipo_identificacion;
    protected $parametros;
    protected $ambiente;
    protected $emision;
    protected $ci;
    protected $empresa;
    protected $retencion;
    protected $server;
    protected $contribuyente;

    /* Parametros del constructor:
    Ambiente = 1 pruebas, 2 produccion
    Tipo de Emision = Normal 1, Emisión por Indisponibilidad del Sistema=2
    */
    function __construct(){
//        $this->parametros = new parametros();
        $this->ambiente = 1;
        $this->emision = 1;
        $this->ci = & get_instance();
        $this->encript = new encript();
        $this->server=get_settings('ELECTRONIC_WS_RETENCION');
        $this->path_xml_generado = get_settings('ELECTRONIC_XML_PATH');

    }

    /*
     * Metodo que carga la informacion de la factura que fue generada y posteriormente inicia el proceso
     * de armado del archivo xml
     */

    public function generar($id_fact_comp, $retencion_id) {
        $this->facturaCompra = $this->ci->generic_model->get_by_id('billing_facturaCompra', $id_fact_comp,'','codigoFacturaCompra');
        
        $this->retencion = $this->ci->generic_model->get_by_id('bill_retencion', $retencion_id,'','id');

        $this->proveedor = $this->ci->generic_model->get_by_id('billing_proveedor', $this->retencion->proveedor_id,'','id');
        
        $id_identificacion_tipo = $this->proveedor->docidentificacion_id;

        
        $this->tipo_identificacion = $this->ci->generic_model->get_by_id('billing_docidentificaciontipo', $id_identificacion_tipo,'','iddocidentificaciontipo');
                
//        print_r($this->tipo_identificacion);
        
        $this->impuestos = $this->ci->generic_model->get('bill_retencion_det', array('retencion_id'=>$this->retencion->id), '', null );
        
        $this->generar_cabezera_xml();
        $this->generar_info_tributaria();
        
        $this->generar_info_retencion();
        $this->generar_impuestos();
        $this->info_adicional();
        $this->guardar_xml('factura.xml');
        $this->send_file('factura.xml');
    }

    /*
     * Metodo que crea un calse SimpleXMLElement que sería el nodo raiz del xmnl
     */

    function generar_cabezera_xml() {
        $this->xml = new SimpleXMLElement('<comprobanteRetencion id="comprobante" version="1.0.0"></comprobanteRetencion>');
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
        $info_tributaria->addChild('ruc', $this->encript->decryptbase64($this->empresa->ruc, get_settings('PASSWORDSALTMAIN')));
//        $info_tributaria->addChild('ruc', '1191732525001');
        $info_tributaria->addChild('claveAcceso', "1111111111111111111111111111111111111111111111111");
        $info_tributaria->addChild('codDoc', str_pad(7,2,"0",STR_PAD_LEFT));
        $info_tributaria->addChild('estab', $this->retencion->establecimiento);
        $info_tributaria->addChild('ptoEmi', $this->retencion->pemision);
        $info_tributaria->addChild('secuencial', str_pad($this->facturaCompra->noFacturaCompra, 9, "0", STR_PAD_LEFT));
//        $info_tributaria->addChild('secuencial', str_pad(519, 9, "0", STR_PAD_LEFT));
        $info_tributaria->addChild('dirMatriz', $this->empresa->direccion);
    }

    /*
     * Metodo que genera la informacion para el nodo infoFactura, este informacion esta relacionada
     * al datos generales de la factura
     */

    function generar_info_retencion() {
        $info_factura = $this->xml->addChild("infoCompRetencion");
        $info_factura->addChild('fechaEmision', date("d/m/Y", strtotime($this->retencion->fecha)));
        $info_factura->addChild('dirEstablecimiento', $this->proveedor->direccion);
//      Campo no obligatorio
        if($this->contribuyente->clase=="ESPECIAL"){
            $info_factura->addChild('contribuyenteEspecial', $this->contribuyente->resolucion);
        }
//      Campo no obligatorio
        if($this->contribuyente->contabilidad=="SI"){
            $info_factura->addChild('obligadoContabilidad', $this->contribuyente->contabilidad);
        }

        $info_factura->addChild('tipoIdentificacionSujetoRetenido', $this->tipo_identificacion->cod);
        if($this->tipo_identificacion->cod=='07'){
            $info_factura->addChild('razonSocialSujetoRetenido', 'CONSUMIDOR FINAL');
            $info_factura->addChild('identificacionSujetoRetenido', str_pad(9,13,"9",STR_PAD_LEFT));
        }else{
            if($this->ambiente==1){
                $info_factura->addChild('razonSocialSujetoRetenido', 'PRUEBAS SERVICIO DE RENTAS INTERNAS');
                
            }else{
                $info_factura->addChild('razonSocialSujetoRetenido', $this->proveedor->razonSocial);
            }
            $info_factura->addChild('identificacionSujetoRetenido', $this->proveedor->PersonaComercio_cedulaRuc);
        }

//      Campo no obligatorio
//      $info_factura->addChild('guiaRemision', '111-111-111111111');
        //$info_factura->addChild('razonSocialSujetoRetenido', $this->proveedor->razonsocial);
        //$info_factura->addChild('identificacionSujetoRetenido', $this->proveedor->PersonaComercio_cedulaRuc);
        $info_factura->addChild('periodoFiscal', date("m/Y", strtotime($this->facturaCompra->fechaemisionfactura)));
    }

    /*
     * Se genera la informacion para el nodo detalles, referente a los detalles del comprobante
     */

    function generar_impuestos() {
        $impuestos = $this->xml->addChild("impuestos");

        foreach ($this->impuestos as $item) {
            $impuesto = $impuestos->addChild('impuesto');
            if($item->impuesto_renta =='RENTA'){
                $impuesto ->addChild('codigo',1);    
            }else{
                if($item->impuesto_renta =='IVA'){
                    $impuesto ->addChild('codigo',2);    
                }else{
                    $impuesto ->addChild('codigo',6);    
                }
            }
            $impuesto ->addChild('codigoRetencion',$item->cod_impuesto);    
            $impuesto ->addChild('baseImponible',$item->base_imponible);
            $impuesto ->addChild('porcentajeRetener',$item->porcent_ret);
            $impuesto ->addChild('valorRetenido',$item->val_retenido);
            $impuesto ->addChild('codDocSustento',$this->facturaCompra->sustento_cod);
            //$impuesto ->addChild('numDocSustento',$item->val_retenido);
            //$impuesto ->addChild('fechaEmisionDocSustento',$this->facturaCompra->sustento_cod);
        }
    }

    function info_adicional(){
        /*$adicional = $this->xml->addChild("infoAdicional");
        $adicional ->addChild('campoAdicional', );
        $adicional ->addChild('campoAdicional', );
        $adicional ->addChild('campoAdicional', );*/
    }

   
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

    /*
     * Funcion que permite enviar el archivo xml generado al WebService de facturacion, y este
     * posteriormente lo enviara el web service del sri
     */

    public function send_file($name_xml) {
        $this->webService($this->path_xml_generado.$name_xml);
    }

    function webService($filename) {
//        Se inicia una clase SoapClientAuth, donde se fija la direccion del servicio web y crea un cliente soap
//        para el web service establecido
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
        $message = array('buffer' => $byteFile, 'user' => 'admin');
        $respuesta = $soapClient->recepcion($message)->{"return"};
        echo $respuesta;
    }
}

?>