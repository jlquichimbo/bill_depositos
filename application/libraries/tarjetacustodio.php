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
class Tarjetacustodio {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    

    /* Tipo de transaccion y documento de donde salio el cheque */
    public function anular_by_doc($tipotransaccion_cod, $doc_id, $estado_info) {
            $res = $this->ci->generic_model->update( 'bill_tarjetascustodio', array('estado'=>'-1','estado_info'=>$estado_info), array('tipotransaccion_cod'=>$tipotransaccion_cod,'docid'=>$doc_id) );
            return $res;      
    }
    
}
