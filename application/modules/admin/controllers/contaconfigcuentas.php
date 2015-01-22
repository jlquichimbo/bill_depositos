<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Contaconfigcuentas extends MX_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->database();
		$this->load->helper('url');

		$this->load->library('grocery_CRUD');
	}

        public function index(){
            $res['view'] = $this->load->view('config_cuentas_search','',TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);
            $this->load->view('templates/dashboard',$res);
        }
        
	public function get_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);
          
            $crud = new grocery_CRUD();
            $crud->set_table('billing_contaconfigcuentas');
            $crud->columns('cod','nombre','descripcion','contacuentasplan_cod');
            $crud->set_subject('Config. Cuentas');
            $crud->unset_delete();
            $crud->set_relation('contacuentasplan_cod','billing_contacuentasplan','{cod} {nombre}');

            $output = $crud->render();

            $this->load->view('crud_view_datatable.php',$output);
	}

}