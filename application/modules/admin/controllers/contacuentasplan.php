<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Contacuentasplan extends MX_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->database();
		$this->load->helper('url');

		$this->load->library('grocery_CRUD');
	}

        public function index(){
            $res['view'] = $this->load->view('plan_cuentas_search','',TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);
            $this->load->view('templates/dashboard',$res);
        }
        
	public function get_crud()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
			$crud = new grocery_CRUD();
                        $crud->set_theme('flexigrid');
//$crud->set_theme('twitter-bootstrap');
			$crud->set_table('billing_contacuentasplan');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
			$crud->columns('cod','nombre','contacuentas_cod','parent','esdetalle');
			$crud->display_as('contacuentas_cod','Tipo.');
//				 ->display_as('bancotipocuenta_id','Tipo Cuenta');
//				 ->display_as('contactLastName','Last Name');
                        $crud->set_relation('contacuentas_cod','billing_contacuentas','nombre');
                        $crud->set_relation('parent','billing_contacuentasplan','{nombre} {cod}');
//                        $crud->set_relation('bancotipocuenta_id','billing_bancotipocuenta','tipocuenta');
			$crud->set_subject('Plan de Cuentas');
                        
//                        $crud->unset_jquery();
			$output = $crud->render();
                        
			$this->load->view('crud_view_flexgrid',$output);
	}

}