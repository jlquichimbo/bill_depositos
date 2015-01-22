<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Puntoventaempl extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

	public function index()
	{            
            $res['view'] = $this->load->view('puntos_venta_search','', TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);                           
            $this->load->view('templates/dashboard',$res);                
        }
	public function get_crud()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
			$crud = new grocery_CRUD();
                        $crud->set_theme('datatables2');
//$crud->set_theme('twitter-bootstrap');
			$crud->set_table('billing_puntoventaempleado');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
			$crud->columns('establecimiento','puntoemision','tiposcomprobante_cod','nroautorizacion','fvenceautorizacion','secuenciainicial','secuenciaultima');
			$crud->display_as('empleado_cedulaRuc','Usuario')
				 ->display_as('establecimiento','Est.')
				 ->display_as('puntoemision','P. Emision')
				 ->display_as('tiposcomprobante_cod','Comprobante')
				 ->display_as('nroautorizacion','Aut. SRI');
//				 ->display_as('contactLastName','Last Name');
			$crud->set_subject('Punto Venta');
//			$crud->set_relation('empleado_cedulaRuc','billing_empleado','{nombres} {apellidos}');
			$crud->set_relation( 'tiposcomprobante_cod','billing_tiposcomprobante','nombre',null,'cod ASC' );
			$crud->set_relation( 'bodega_id','billing_bodega','nombre' );
                         
                        $crud->field_type('fcreacionpunto', 'hidden', date('Y-m-d',time()));
                        $crud->set_relation_n_n('usuarios', 'bill_puntoventausers', 'billing_empleado', 'puntoventa_id', 'empleado_id', '{nombres} {apellidos}');
//                        $crud->unset_jquery();
                        
			$output = $crud->render();
                        
			$this->load->view('crud_view_datatable',$output); 
	}

}