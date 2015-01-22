<?php

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of kardex
 *
 * @author estebanch
 */
class kardex_bodega {
    //put your code here
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }    
    
    /*
     * Obtenemos el nuevo stock (kardex) por producto
     * $tipo : add=>suma, diff=>resta
     */
    public function get_new_kardex_bodega_add($product_id, $bodega_id, $qty) {
        $kardex_bod = $this->ci->generic_model->get_val_where('bill_kardex_bodega', array('producto_id'=>$product_id,'bodega_id'=>$bodega_id,'estado'=>'1'), 'kardex_ultimo',null,0);
        $new_kardex_bod = $kardex_bod + $qty;
        return $new_kardex_bod;
    }
    public function get_new_kardex_bodega_diff($product_id, $bodega_id, $qty) {
        $kardex_bod = $this->ci->generic_model->get_val_where('bill_kardex_bodega', array('producto_id'=>$product_id,'bodega_id'=>$bodega_id,'estado'=>'1'), 'kardex_ultimo',null,0);
        $new_kardex_bod = $kardex_bod - $qty;
        return $new_kardex_bod;
    }
    
    public function update_stock_bodega($product_id, $bodega_id, $new_kardex_bod) {
        $res = false;
        $count_sb = $this->ci->generic_model->count_all_results( 'billing_stockbodega', array( 'bodega_id'=>$bodega_id, 'producto_codigo'=>$product_id ) );
        if($count_sb){ /* si ya existen registros de este producto en esta bodega, actualizamos el stock*/
            $res = $this->ci->generic_model->update( 'billing_stockbodega', array('stock'=>$new_kardex_bod), array('bodega_id'=>$bodega_id,'producto_codigo'=>$product_id) );
        }else{ /* caso contrario agregamos el registro con el stock correspondiente */
            $res = $this->ci->generic_model->save(array('bodega_id'=>$bodega_id,'producto_codigo'=>$product_id,'stock'=>$new_kardex_bod, 'fultimact'=>date('Y-m-d',time())),'billing_stockbodega');
        }
        return $res;
    }

}
