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
class Proveedor_anticipo {
    private $ci;
    private $tipotransaccion_cod = '15';
    
    function __construct(){
        $this->ci = & get_instance();
    }    
    //put your code here
        /* Anulamos el anticipo generado por la nota de credito */
        public function anular($anticipo_id) {
            $res = false;
                if( $anticipo_id > 0 ){
                    $anticipo_data = $this->ci->generic_model->get('bill_proveedor_anticipo', array('id'=>$anticipo_id), '', null, 1 );
                    
                    if($anticipo_data){
                        $saldo_ultimo = $this->ci->generic_model->get_val_where('bill_proveedor_anticipo', array('proveedor_id'=>$anticipo_data->proveedor_id,'estado'=>'1'), 'saldo_ultimo', null, 0);
//                        echo '<br/>Saldo Ultimo: '.$saldo_ultimo .' - '. 'Anticipo:'.$anticipo_data->anticipo.'<br/>';
                        
                        $new_saldo_proveedor = $saldo_ultimo - $anticipo_data->anticipo;

                        /* Registramos el anticipo */
                        $anticipo_new_data = array(
                            'anticipo' => $anticipo_data->anticipo * -1,
                            'saldo' => $new_saldo_proveedor,
                            'proveedor_id' => $anticipo_data->proveedor_id,
                            'detalle' => 'ANULACION DEL ANTICIPO',
                            'empleado_id' => $this->ci->user->id,
                            'fecha' => date('Y-m-d',time()),
                            'hora' => date('H:i:s',time()),
                            'estado' => -3,
                        );
                        $new_anticipo_id = $this->ci->generic_model->save($anticipo_new_data,'bill_proveedor_anticipo');
                        /* Actualizamos saldo_ultimo */
                        $this->ci->generic_model->update( 'bill_proveedor_anticipo', array( 'saldo_ultimo'=>$new_saldo_proveedor), array('proveedor_id'=>$anticipo_data->proveedor_id) );                        
                        $this->ci->generic_model->update( 'bill_proveedor_anticipo', array('estado'=>'-1'), array('id'=>$anticipo_data->id) );                        
                        
                        /* Anulamos el asiento contable generado por ese anticipo */
                        $res = $this->ci->generic_model->update( 'billing_contaasientocontable', array('estado'=>'-1'), array('tipotransaccion_cod'=>$this->tipotransaccion_cod, 'docid'=>$anticipo_id) );
                    }
                    $this->anular_deposito_banco($anticipo_id);
                }
                
                return $res;
        }
        
        /*
         * Cuando el anticipo fue hecho con un deposito, se debe anular tambien ese deposito
         * que ya estaba reflejado en el banco
         */
        public function anular_deposito_banco($anticipo_id) {
            /* 
             * Cuando es un deposito directamente se refleja en el libro bancos, por lo que si anulamos el anticipo
             * se debe regresar todo ese valor, recibido con transferencia
             */
            $val_tarjetas = $this->ci->generic_model->sum_table_field( 'bill_proveedor_anticipo_tipopago', 'valor', array('tipopago_id'=>'03','anticipo_id'=>$anticipo_id) );
            $val_cheques = $this->ci->generic_model->sum_table_field( 'bill_proveedor_anticipo_tipopago', 'valor', array('tipopago_id'=>'04','anticipo_id'=>$anticipo_id) );
            $val_depositado = $this->ci->generic_model->sum_table_field( 'bill_proveedor_anticipo_tipopago', 'valor', array('tipopago_id'=>'06','anticipo_id'=>$anticipo_id) );
            if( $val_depositado > 0 ){
                $banco_id = $this->get_banco_pago($anticipo_id, 'bill_deposito_realizado');
                $this->update_cuenta_bancaria($banco_id, $val_depositado, $anticipo_id);
            }
            if( $val_cheques > 0 ){
                $banco_id = $this->get_banco_pago($anticipo_id, 'bill_cheque_pago');
                $this->update_cuenta_bancaria($banco_id, $val_cheques, $anticipo_id);
            }
            if( $val_tarjetas > 0 ){
                $banco_id = $this->get_banco_pago($anticipo_id, 'bill_tarjeta_cred_pago');
                $this->update_cuenta_bancaria($banco_id, $val_tarjetas, $anticipo_id);
            }
        }
        
        private function update_cuenta_bancaria($banco_id, $val, $anticipo_id){
            /* Anulamos el registro en el libro bancos */
            $this->ci->generic_model->update( 'bill_cuentabancaria', array('estado'=>'-1','estado_info'=>'ANULACION DE ANTICIPO'), array('doc_id'=>$anticipo_id,'tipo_transaccion'=>$this->tipotransaccion_cod) );
                /* Registramos la cuenta bancaria / libro bancos */
                $mes = date('m', time());
                $saldo_cuenta = $this->ci->generic_model->get_val_where('bill_cuentabancaria_saldos', array('banco_id'=>$banco_id,'mes_id'=>$mes), 'saldo', null, 0);
                $new_saldo_cuenta = $saldo_cuenta + $val;

                $saldo_cta_mes = $this->ci->generic_model->count_all_results('bill_cuentabancaria_saldos', array('banco_id'=>$banco_id,'mes_id'=>$mes));
                if($saldo_cta_mes == 0){
                    $cuentabancaria_saldos = array('banco_id'=>$banco_id,'saldo'=>$new_saldo_cuenta,'mes_id'=>$mes,'user_id'=>$this->ci->user->id,'fecha'=>  date('Y-m-d',time()),'hora'=>  date('H:i:s',time()));
                    $this->ci->generic_model->save($cuentabancaria_saldos,'bill_cuentabancaria_saldos');
                }else{
                    $this->ci->generic_model->update( 'bill_cuentabancaria_saldos', array('saldo'=>$new_saldo_cuenta, 'user_id'=>$this->ci->user->id, 'fecha'=>  date('Y-m-d',time()), 'hora'=>  date('H:i:s',time())), array('banco_id'=>$banco_id,'mes_id'=>$mes) );
                }            
        }
        
        /*
         * Devuelve el id del banco del cual salio el valor pagado
         * tipo: deposito, cheque, tarjeta 
         * $table_name : tabla que guarda los datos del pago
         * Tablas pueden ser: bill_deposito_realizado, bill_cheque_pago, bill_tarjeta_cred_pago
         */
        public function get_banco_pago($anticipo_id, $table_name) {
            $res = $this->ci->generic_model->get($table_name, array('tipotransaccion_cod'=>$this->tipotransaccion_cod,'docid'=>$anticipo_id), 'banco_id', null, 1 );
            return $res->banco_id;                
        }
        
        
        /* Obtener comprobante de pago por anticipo a proveedor */
        public function get_comprobante_pago($anticipo_id){
            $res['anticipo_id'] = $anticipo_id;
            $res['comprob_pago'] = $this->ci->generic_model->get_by_id('bill_comprob_pago',$anticipo_id,'','doc_id');
            $res['proveedor'] = $this->ci->generic_model->get_by_id('billing_proveedor',$res['comprob_pago']->proveedor_id);
            $where_data = array( 'comprob_pago_id'=>$res['comprob_pago']->id );
            $join_cluase = array(
                '0'=>array('table'=>'billing_contacuentasplan cta','condition'=>'cp.cta_contable = cta.cod'),
                '1'=>array('table'=>'billing_tipopago tp','condition'=>'cp.tipopago_cod = tp.cod')
            );
            $res['comprob_pago_det'] = $this->ci->generic_model->get_join('bill_comprob_pago_det cp', $where_data, $join_cluase, $fields = 'cp.*, cta.nombre nombre_cta_cont, tp.nombre tipo_pago', 0);
            
            $this->ci->load->view('comprobante_pago',$res);
        }
        
        public function get_saldo_anticipos($proveedor_id) {
            $saldo_ultimo = $this->ci->generic_model->get_val_where('bill_proveedor_anticipo', array('proveedor_id'=>$proveedor_id,'estado'=>'1'), 'saldo_ultimo', null, 0);
            return $saldo_ultimo;
        }
        
        public function save_anticipo_tipopago($anticipo_id, $valor, $tipo_pago, $doc_pago_id){
            $tipopago_data = array(
                'anticipo_id' => $anticipo_id,
                'tipopago_id' => $tipo_pago,
                'valor' => $valor,
                'fecha' => date('Y-m-d', time()),
                'hora' => date('H:i:s', time()),
                'doc_pago_id' => $doc_pago_id,
            );
            $res = $this->ci->generic_model->save($tipopago_data,'bill_proveedor_anticipo_tipopago');
            return $res;
        }
}
