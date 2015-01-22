<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Bodegas extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

	public function index()
	{
            $res['view'] = $this->load->view('bodegas_search','', TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);                           
            $this->load->view('templates/dashboard',$res);              
        }
        
	public function get_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);     
            $crud = new grocery_CRUD();
            $crud->set_table('billing_bodega');
            $crud->columns('id','nombre','descripcion','orden','vistaweb');
            $crud->set_subject('Bodegas');
            $output = $crud->render();
            $this->load->view('crud_view_datatable',$output); 
	}

}