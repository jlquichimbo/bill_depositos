<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Tiposprecio extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

	public function get_crud()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
			$crud = new grocery_CRUD();
//                        $crud->set_theme('twitter-bootstrap');
                        $crud->set_language("spanish");
//$crud->set_theme('twitter-bootstrap');
			$crud->set_table('billing_tiposprecio');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
			$crud->columns('tipoprecio','descripcion','activo');
                        $crud->unset_delete();
			$crud->set_subject('Tipos Precio');
                        $crud->required_fields('tipoprecio');
                        $crud->unique_fields('tipoprecio');
//			$crud->set_relation('empleado_director','billing_empleado','{nombres} {apellidos} {username}');
//			$crud->set_relation_n_n('director','billing_empleado','billing_personacomercio','PersonaComercio_cedulaRuc','PersonaComercio_cedulaRuc','{nombres} {apellidos}');
                        
//			$crud->set_relation('empresa_ruc','billing_empresa','nombrecomercial');
//                        $crud->unset_add_fields('sucursal_idsucursal');
//                        $crud->unset_columns('sucursal_idsucursal');
//                        $crud->unset_jquery();
			$output = $crud->render();
                        
                        $this->load->view('crud_view_datatable',$output);  
	}

}