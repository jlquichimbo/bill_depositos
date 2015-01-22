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
class Recibo {
    private $ci;
//    private $tipotransaccion_cod = '18';
    
    function __construct(){
        $this->ci = & get_instance();
    }    

        
        public function save($client_id, $doc_id, $total_recibido, $tipotransaccion_cod, $tipo) {
            $recibo_data = array(
                'anio' => date('Y',time()),
                'client_id' => $client_id,
                'nota' => $this->ci->input->post('detalle'),
                'doc_id' => $doc_id,
                'tipotransaccion_cod' => $tipotransaccion_cod,
                'recibo_tipo_id' =>  $tipo, /* 2 = ANTICIPO CLIENTES*/
                'user_empleado_id' => $this->ci->user->id,
                'fecha' => date('Y-m-d',time()),
                'lugar' => get_settings('CIUDAD'),
                'cantidad_number' => $total_recibido,
                'cantidad_letras' => $this->ci->number_letter->convert_to_letter($total_recibido,''),
            );
            $recibo_id = $this->ci->generic_model->save( $recibo_data,'bill_recibo' );
            
            return $recibo_id;
        }
        
        public function save_detalle($recibo_id, $valor, $doc_id, $tipotransaccion_cod, $doc_pago_id) {
            $recibo_det_data = array(
                'recibo_id' =>  $recibo_id,
                'detalle' =>  'Recibo de anticipo, en efectivo . '.$doc_id,
                'valor' =>  $valor, 
                'doc_id' =>  $doc_id, 
                'tipotransaccion_cod' => $tipotransaccion_cod, /* 18 => anticipo de cliente */ 
                'tipopago_cod' => '01', /* 01 => Efectivo */ 
                'doc_pago_id' => $doc_pago_id,
                'user_id' => $this->ci->user->id,
            );
            $res = $this->ci->generic_model->save( $recibo_det_data, 'bill_recibo_det' );            
            
            return $res;
        }
        
        public function get_detalle($recibo_id) {
            $where_data = array( 'recibo_id'=>$recibo_id );
            $join_cluase = array(
                '0'=>array('table'=>'billing_tipotransaccion tt','condition'=>'rd.tipotransaccion_cod = tt.cod'),
                '1'=>array('table'=>'billing_tipopago tp','condition'=>'rd.tipopago_cod = tp.cod')
            );
            $recibo_det = $this->ci->generic_model->get_join( 'bill_recibo_det rd', $where_data, $join_cluase, $fields = 'rd.*, tp.nombre tipo_pago, tt.nombre tipo_trans', 0 );
            
            return $recibo_det;
        }
        
}
