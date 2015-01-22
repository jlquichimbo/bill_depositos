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
class Asientocontable {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    
 
    public function get_ac_data($tipo_trans, $doc_id) {
        $join_cluase = array(
               '0' => array('table'=>'bill_asiento_contable_det acd','condition'=>'ac.id = acd.asiento_contable_id'),
               '1' => array('table'=>'billing_contacuentasplan pl','condition'=>'acd.cuenta_cont_id = pl.cod')
            );
        $where_data = array('ac.tipotransaccion_cod'=>$tipo_trans,'ac.doc_id'=>$doc_id);
        
        $ac_data = $this->ci->generic_model->get_join(
                    'bill_asiento_contable ac', 
                    $where_data, 
                    $join_cluase, 
                    'ac.id, ac.anio, ac.fecha ac_fecha, ac.hora ac_hora, acd.debito, acd.credito, acd.detalle, acd.cuenta_cont_id, acd.tipo_pago, acd.doc_id_pago, pl.nombre cta_name'
                );
        return $ac_data;
    }
    
    public function open_ac($tipo_trans, $doc_id) {
        $res['ac_data'] = $this->get_ac_data($tipo_trans, $doc_id);
        $this->ci->load->view('asiento_contable_doc',$res);
    }
}
