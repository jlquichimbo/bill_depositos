<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Centroscosto extends MX_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->database();
		$this->load->helper('url');

		$this->load->library('grocery_CRUD');
	}
        
	public function index()
	{
            $res['view'] = $this->load->view('centros_costo_search','', TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);                           
            $this->load->view('templates/dashboard',$res);              
        }        
        
	public function get_crud()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
			$crud = new grocery_CRUD();
                        $crud->set_language("spanish");
//$crud->set_theme('twitter-bootstrap');
			$crud->set_table('billing_centroscosto');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
			$crud->columns('nombre','descripcion','activo','fechacreacion');
//			$crud->display_as('salesRepEmployeeNumber','from Employeer')
//				 ->display_as('customerName','Name')
//				 ->display_as('contactLastName','Last Name');
                        
//                        $crud->callback_add_field('fechacreacion', function () {
//                        return '<input type="hidden" maxlength="10" value="'.date('Y-m-d',time()).'" name="fechacreacion", class="datepicker-input hasDatepicker">';
//                        });
                        $crud->field_type('fechacreacion', 'hidden', date('Y-m-d',time()));
//                        $crud->field_type('fechacreacion', 'date');
                        $crud->fields('nombre','descripcion','activo','fechacreacion');
			$crud->set_subject('Centros de Costo');
//			$crud->set_relation('salesRepEmployeeNumber','employees','lastName');
                        
//                        $crud->unset_jquery();
			$output = $crud->render();
                        
                        $this->load->view('crud_view_datatable',$output);
	}

}