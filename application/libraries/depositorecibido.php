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
class Depositorecibido {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    

    /* Tipo de transaccion y documento de donde salio el cheque */
    public function anular_by_doc($tipotransaccion_cod, $doc_id, $estado_info) {
//        $message = '';
            /* Comprobamos el estado del deposito, 
             * si es uno, significa que no ha sido procesado aun
             * o sea q no ha sido registrado en el banco, caso contrario no se puede anular el anticipo, y antes debe
             * reversar este deposito en el banco
             */ 
            $estado = $this->ci->generic_model->get_val_where('bill_deposito_recibido', array('tipotransaccion_cod'=>$tipotransaccion_cod,'docid'=>$doc_id), 'estado', $alias_val = null, $empty_val = 0);            
            if($estado != 0){ /* si existe algun deposito para este anticipo*/
                if( $estado == 1 ){
                    $res = $this->ci->generic_model->update( 'bill_deposito_recibido', array('estado'=>'-1','estado_info'=>$estado_info), array('tipotransaccion_cod'=>$tipotransaccion_cod,'docid'=>$doc_id) );
                    return $res;
                }else{
//                    $message .= error_info_msg(' El dep&oacute;sito generado por el anticipo se encuentra en un estado que no se puede anular desde este m&oacute;dulo.');
                    return false;
                }                            
            }else{
                return true;
            }    
    }
    
}
