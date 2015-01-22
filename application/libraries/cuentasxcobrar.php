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
class Cuentasxcobrar {
    
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    

    public function update_cxc_saldos($client_id, $new_saldo) {
        $res = false;
        $count_sb = $this->ci->generic_model->count_all_results( 'bill_cxc_saldos', array( 'client_id'=>$client_id ) );
        if($count_sb){ /* si ya existen registros de este producto en esta bodega, actualizamos el stock*/
            $res = $this->ci->generic_model->update( 'bill_cxc_saldos', array('saldo'=>$new_saldo), array('client_id'=>$client_id) );
        }else{ /* caso contrario agregamos el registro con el stock correspondiente */
            $res = $this->ci->generic_model->save(array('saldo'=>$new_saldo,'client_id'=>$client_id),'bill_cxc_saldos');
        }
        return $res;
    }    
    
    public function get_client_saldo($client_id) {
       $saldo_client = $this->ci->generic_model->get_val_where( 'bill_cxc_saldos', array('client_id'=>$client_id) , 'saldo', '', 0 );        
       return $saldo_client;
    }
    
}
