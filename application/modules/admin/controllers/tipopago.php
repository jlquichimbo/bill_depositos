<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Tipopago extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

        public function index(){
            $res['view'] = $this->load->view('tipopago_search','',TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);
            $this->load->view('templates/dashboard',$res);
        }
        
	public function get_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);          
            $crud = new grocery_CRUD();
            $crud->set_table('billing_tipopago');

            $crud->columns('cod','nombre','descripcion','alias','contacuentasplan_codventa','cta_pago_compras');
            $crud->display_as('contacuentasplan_codventa','Cta. Ventas')
                 ->display_as('cta_pago_compras','Cta. Compras');

            $crud->unset_delete();
            $crud->set_subject('Tipos Pago');
            $crud->set_relation('contacuentasplan_codventa','billing_contacuentasplan','{cod} {nombre}');
            $crud->set_relation('cta_pago_compras','billing_contacuentasplan','{cod} {nombre}');
            $output = $crud->render();

            $this->load->view('crud_view_datatable', $output);
	}

}