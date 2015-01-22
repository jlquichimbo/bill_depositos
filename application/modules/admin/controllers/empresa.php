<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Empresa extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

	public function index()
	{
            $res['view'] = $this->load->view('empresa_search','', TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);                           
            $this->load->view('templates/dashboard',$res);              
        }
        
	public function get_crud()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
		$this->config->set_item('grocery_crud_default_per_page',2);
			$crud = new grocery_CRUD();
                        $crud->set_language("spanish");
			$crud->set_table('billing_empresa');
			$crud->columns('razonSocial','nombreComercial','representanteLegal','direccion','mision','vision','logo');
                        $crud->edit_fields('razonSocial','nombreComercial','representanteLegal','direccion','mision','vision');
                        $crud->unset_add();
                        $crud->unset_delete();
//                        $crud->unset_list();
			$crud->set_subject('Empresa');
//			$crud->set_relation('salesRepEmployeeNumber','employees','lastName');
                        
			$output = $crud->render();
                        
                        $this->load->view('crud_view_datatable',$output);  
	}
        
	public function get_departamentos_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);
            $crud = new grocery_CRUD();
            $crud->set_table('billing_departamento');
            $crud->columns('nombre','ubicacion','descripcion','numorden');
            $crud->required_fields('nombre');
            $crud->unique_fields('nombre');                        
            $crud->set_subject('Departamentos Empresa');
//			$crud->set_relation('salesRepEmployeeNumber','employees','lastName');

            $output = $crud->render();

            $this->load->view('crud_view_datatable',$output);  
	}

}