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
class kardex {
    //put your code here
    private $ci;
    
    function __construct(){
        $this->ci = & get_instance();
    }
    
    /* 
     * Obtenemos el nuevo stock (kardex) por producto
     * $tipo : add=>suma, diff=>resta
    */
    public function get_new_kardex_ultimo_add($product_id, $qty) {
        $kardex_ultimo = $this->ci->generic_model->get_val_where('bill_kardex', array('producto_id'=>$product_id), 'kardex_ultimo', null, 0);
            $new_kardex_ultimo = $kardex_ultimo + $qty;                
        return $new_kardex_ultimo;
    }
    
    public function get_new_kardex_ultimo_diff($product_id, $qty) {
        $kardex_ultimo = $this->ci->generic_model->ci->get_val_where('bill_kardex', array('producto_id'=>$product_id), 'kardex_ultimo', null, 0);
            $new_kardex_ultimo = $kardex_ultimo - $qty;                
        return $new_kardex_ultimo;
    }
    
    /*
     * Obtenemos el ultimo costo de inventario por producto
     * $valor_total : num productos x cantidad
     */
    
    public function get_costo_inv_producto_add($product_id, $valor_total) {
        $costo_inv_product_ultimo = $this->ci->generic_model->get_val_where('bill_kardex', array('producto_id'=>$product_id), 'costo_inv_product_ultimo', null, 0);
        $res = $costo_inv_product_ultimo + $valor_total;
        return $res;
    }
    public function get_costo_inv_producto_diff($product_id, $valor_total) {
        $costo_inv_product_ultimo = $this->ci->generic_model->get_val_where('bill_kardex', array('producto_id'=>$product_id), 'costo_inv_product_ultimo', null, 0);
        $res = $costo_inv_product_ultimo - $valor_total;
        return $res;
    }
    
    /*
     * Actulizamos el total del costo de inventario
     */
    public function get_costo_inv_total_add($valor_total) {
        $costo_inventario_ultimo = $this->ci->generic_model->get_val_where('bill_kardex', array('estado'=>'1'), 'costo_inventario_ultimo', null, 0);
        $res = $costo_inventario_ultimo + $valor_total;        
        return $res;
    }
    public function get_costo_inv_total_diff($valor_total) {
        $costo_inventario_ultimo = $this->ci->generic_model->get_val_where('bill_kardex', array('estado'=>'1'), 'costo_inventario_ultimo', null, 0);
        $res = $costo_inventario_ultimo - $valor_total;        
        return $res;
    }
}
