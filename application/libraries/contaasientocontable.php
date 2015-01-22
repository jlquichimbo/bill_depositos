<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of contaasientocontable
 *
 * @author estebanch
 */
class Contaasientocontable {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    
    //put your code here
    public function generate_id() {
        $curr_year = date('Y',time());
        $ac_id = $this->ci->generic_model->save(array('idasientocontable'=>'0'),'billing_auxidasientocontable');
        $ac_id = $curr_year.'-'.str_pad($ac_id, '12', '0',STR_PAD_LEFT);
        return $ac_id;
    }
    
    
    /*
     *  Crear un nuevo asiento contable
     */
    public function save( $data, $ac_id, $doc_id, $tipo, $tipotransaccion_cod, $tiposcomprobante_cod = null ) {
        $a_c = array(
           'contacuentasplan_cod' => $data['cta_contable'],
           'debe' => $data['debe'],
           'haber' => $data['haber'],
           'descripcion' => $data['desc'],
           'empleado_cedulaRuc' => $this->ci->user->userid,
           'fecha' => date('Y-m-d',time()),
           'tiposcomprobante_cod' => $tiposcomprobante_cod,
           'tipotransaccion_cod' => $tipotransaccion_cod,
           'idasientocontable' => $ac_id,
           'hora' => date('H:i:s',time()),
           'docid' => $doc_id,
           'tipo' => $tipo, // tipo = 3  -  compras
           'user_id' => $this->ci->user->id
        );
        /* ingresamos cuenta al debe */
        $res = $this->ci->generic_model->save( $a_c, 'billing_contaasientocontable' );

        return $res;
    }
    
    
    public function get_asiento($doc_id, $tipotransaccion_cod){
        $res = $this->ci->generic_model->get( 'billing_contaasientocontable', array('docid'=>$doc_id,'tipotransaccion_cod'=>$tipotransaccion_cod));
        return $res;
    } 
    
//    public function print_asiento($doc_id, $client_id, $tipotransaccion_cod){
//        $res['data_asiento'] = $this->get_asiento($doc_id, $tipotransaccion_cod);
//        $res['cliente'] = $this->generic_model->get_by_id('billing_cliente',$client_id,'','PersonaComercio_cedulaRuc');            
//        $this->load->view('vista_asiento_contable',$res);
//    }    
    
    /* Anular el asiento contable */
    public function anular($tipo_transaccion, $doc_id){
        $res = $this->ci->generic_model->update( 'billing_contaasientocontable', array('estado'=>'-1','activo'=>'0'), array('tipotransaccion_cod'=>$tipo_transaccion,'docid'=>$doc_id) );
        return $res;
    }      
}
