<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Grupoprecio extends MX_Controller {

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
                        $crud->set_theme('datatables2');
			$crud->set_table('bill_grupoprecio');
			$crud->set_relation('productogrupo_id', 'billing_productogrupo', 'nombre');
			$crud->set_relation('tiposprecio_id', 'billing_tiposprecio', 'tipoprecio', array('activo'=>'1'));
			$crud->columns('productogrupo_id','tiposprecio_id','utilidad');
			$crud->set_subject('Grupo/Precio');
                        $output = $crud->render();
                        $this->load->view('crud_view_datatable',$output);  
//                        $this->load->view('admin.php',$output);
	}
        
}