<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Proveedorparam extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

	public function index($prov_ci = '')
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
			$crud = new grocery_CRUD();
			$crud->where('proveedor_id',$prov_ci);
			$crud->set_table('bill_proveedor_puntoventa');
//			$crud->columns('id','nombre','descripcion','orden','vistaweb');
			$crud->display_as('tiposcomprobante_cod','Comprobante')
			->display_as('numautorizacion','Aut. SRI')
			->display_as('proveedor_PersonaComercio_cedulaRuc','Proveedor');
//				 ->display_as('customerName','Name')
//				 ->display_as('contactLastName','Last Name');
			$crud->set_subject('Parametrizacion Proveedor');
			$crud->set_relation('tiposcomprobante_cod','billing_tiposcomprobante','nombre');
			$crud->set_relation('proveedor_id','billing_proveedor','{nombres} {apellidos}',array('id'=>$prov_ci));
                        
			$output = $crud->render();
                        
			$this->load->view('crud_view_datatable',$output);
	}

}