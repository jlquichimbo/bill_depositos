<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Clientetipo extends MX_Controller {

	public function __construct()
	{
		parent::__construct();

		$this->load->database();
		$this->load->helper('url');

		$this->load->library('grocery_CRUD');
	}
        
	public function index()
	{
            $res['view'] = $this->load->view('tipos_cliente_search','', TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);                           
            $this->load->view('templates/dashboard',$res);              
        }
        
	public function get_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);
            $crud = new grocery_CRUD();
            $crud->set_table('billing_clientetipo');
            $crud->columns('tipo','descripcion','descuento');
            $crud->set_relation_n_n('precios', 'billing_clientetipotiposprecio', 'billing_tiposprecio', 'clientetipo_idclientetipo', 'tiposprecio_tipoprecio', 'tipoprecio');
            $crud->set_subject('Tipos Cliente');
            $output = $crud->render();

            $this->load->view('crud_view_datatable',$output);
	}

}