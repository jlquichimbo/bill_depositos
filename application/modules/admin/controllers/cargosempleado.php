<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Cargosempleado extends MX_Controller {

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
                        $crud->set_language("spanish");
//$crud->set_theme('twitter-bootstrap');
			$crud->set_table('billing_cargosempleado');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
			$crud->columns('nombreCargo','descripcion','numorden','fCreacion','estaActivo');
//			$crud->display_as('salesRepEmployeeNumber','from Employeer')
//				 ->display_as('customerName','Name')
//				 ->display_as('contactLastName','Last Name');
			$crud->set_subject('Cargos Empleado');
//			$crud->set_relation('salesRepEmployeeNumber','employees','lastName');
                        
//                        $crud->unset_jquery();
			$output = $crud->render();
                        
                        $this->load->view('crud_view_datatable',$output);
	}

}