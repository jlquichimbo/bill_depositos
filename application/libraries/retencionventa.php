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
class Retencionventa {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    

    /* Anulamos la retencion */
    public function anular($retencion_id){
        $message = '';
        
        $ret_data = $this->ci->generic_model->get('bill_retencion_venta', array('id'=>$retencion_id), 'pagada', null, 1);
        
        $res = $this->ci->generic_model->update( 'bill_retencion_venta', array('estado'=>'-1'), array('id'=>$retencion_id) );
        if($res > 0){
            $message .= success_info_msg('La retencion ha sido anulada correctamente');
        }else{
            return false;
        }
        return $message;
    }
    
    public function get_id_by_doc($doc_id, $tipotransaccion_cod){
        $ret_id = $this->ci->generic_model->get_val_where(
                    'bill_retencion_venta', 
                    array('doc_id'=>$doc_id,'tipo_transaccion'=>$tipotransaccion_cod,'estado'=>'1'), 
                    'id', null, 
                    $empty_val = -1
                );
        return $ret_id;
    }
}
