<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of proveedor_anticipo
 *
 * @author estebanch
 */
class Cliente_anticipo {
    private $ci;
    private $tipotransaccion_cod = '18';
    
    function __construct(){
        $this->ci = & get_instance();
    }    

        
        public function save_anticipo_data($client_id, $anticipo_val, $anticipo_anulado_id) {
            /* Obtenemos el ultimo registro activo de anticipos al proveedor */
            $saldo_client = $this->ci->generic_model->get_val_where('bill_cliente_anticipo', array('client_id'=>$client_id,'estado'=>'1'), 'saldo_ultimo', null, 0);
            
            $new_saldo_client = $saldo_client + $anticipo_val;
            
            $detalle_anulacion = $this->ci->input->post('detalle_anulacion');
            $user_id_anulacion = null;
            if(!empty($anticipo_anulado_id)){
                $user_id_anulacion = $this->ci->user->id;
            }
            
            /* Registramos el anticipo */
            $anticipo_data = array(
                'anticipo' => $anticipo_val,
                'saldo' => $new_saldo_client,
                'client_id' => $client_id,
                'detalle' => $this->ci->input->post('detalle'),
                'empleado_id' => $this->ci->user->id,
                'fecha' => date('Y-m-d',time()),
                'hora' => date('H:i:s',time()),
                'estado' => 1,
                'anticipo_anulado_id' => $anticipo_anulado_id,
                'detalle_anulacion' => $detalle_anulacion,
                'user_id_anulacion' => $user_id_anulacion,
            );
            $anticipo_id = $this->ci->generic_model->save($anticipo_data,'bill_cliente_anticipo');
            $upd_saldo_ultimo = $this->ci->generic_model->update( 'bill_cliente_anticipo', array('saldo_ultimo'=>$new_saldo_client), array('client_id'=>$client_id) );
            
            return $anticipo_id;
            
        }
        
}
