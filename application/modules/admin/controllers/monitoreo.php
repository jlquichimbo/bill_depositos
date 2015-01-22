<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class Monitoreo extends MX_Controller {
               
	function __construct()
	{
 		parent::__construct();
	}	
        
        function index()
        {            
          $res1['num_ventas'] = $this->generic_model->count_all_results('billing_facturaventa', array('fechaCreacion'=>  date('Y-m-d', time()),'estado'=>'2'));
          $res1['num_compras'] = $this->generic_model->count_all_results('billing_facturacompra', array('fechaCreacion'=>  date('Y-m-d', time()),'estado'=>'2'));
          $res1['num_ventas_pendiente'] = $this->generic_model->count_all_results('billing_facturaventa', array('fechaCreacion'=>  date('Y-m-d', time()),'estado'=>'1'));
          $res1['num_compras_pendiente'] = $this->generic_model->count_all_results('billing_facturacompra', array('fechaCreacion'=>  date('Y-m-d', time()),'estado'=>'1'));

          $res1['num_ventas_anuladas'] = $this->generic_model->count_all_results('billing_facturaventa', array('fechaCreacion'=>  date('Y-m-d', time()),'estado <='=>'0'));
          $res1['num_compras_anuladas'] = $this->generic_model->count_all_results('billing_facturacompra', array('fechaCreacion'=>  date('Y-m-d', time()),'estado <='=>'0'));
          $res1['num_nuevos_clientes'] = $this->generic_model->count_all_results('billing_cliente', array('fecha'=>  date('Y-m-d', time())));
          
          $res1['costo_inventario'] = $this->generic_model->get_val_where('bill_kardex', array('estado'=>'1'), 'costo_inventario_ultimo', null, 0);
          
          $res['title']  = 'Monitoreo del Sistema';
          $res['view']  = $this->load->view('monitoreo',$res1,TRUE);
          $res['slidebar']  = $this->load->view('slidebar',$res1,TRUE);
          $this->load->view('templates/dashboard',$res);
        }
}
