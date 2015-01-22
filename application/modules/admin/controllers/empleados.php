<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Empleados extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

        public function index(){
            $res['view'] = $this->load->view('users_search','', TRUE);
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
			$crud->set_table('billing_empleado');
			//$crud->columns('customerName','contactLastName','phone','city','country','salesRepEmployeeNumber','creditLimit');
//			$crud->columns('nombres','apellidos','email','username','telefonos','celular');
			$crud->display_as('PersonaComercio_cedulaRuc','CI/RUC')
				 ->display_as('Departamento_idPerteneciente','Departamento')
				 ->display_as('cargosempleado_id','Cargo');
                        $crud->set_relation('Departamento_idPerteneciente','billing_departamento','nombre');
                        $crud->set_relation('cargosempleado_id','billing_cargosempleado','nombreCargo');
//                        $crud->set_relation('empresa_ruc','billing_empresa','nombreComercial');
                        
                        $crud->set_relation_n_n( 'permisos', 'billing_empleadocapacidad', 'billing_capacidad', 'empleado_id', 'Capacidades_capacidad', 'capacidad','priority' );
                        $crud->set_relation_n_n( 'bodega', 'bill_bodegaempleado', 'billing_bodega', 'id_empleado', 'id_bodega', 'nombre' );
//                        $crud->set_relation_n_n('punto_venta', 'bill_puntoventausers', 'billing_puntoventaempleado', 'empleado_id', 'puntoventa_id', '{puntoemision} {establecimiento}');
                        
                        $crud->field_type('fechaIngreso', 'hidden', date('Y-m-d',time()));
                        $crud->field_type('fechaSalida', 'hidden', date('Y-m-d',time()));
                        $crud->change_field_type('clave','password');
                        
                        $crud->callback_before_insert(array($this,'encrypt_password_callback'));
                        $crud->callback_before_update(array($this,'encrypt_password_callback'));
                        
                        $edit_fields = array('PersonaComercio_cedulaRuc','username','nombres','apellidos','email','telefonos','celular','permisos','bodega','Departamento_idPerteneciente','cargosempleado_id');
                        $crud->edit_fields($edit_fields);
                        
                        $crud->unset_columns('clave','sueldo','observaciones','estaActivo','accesoSistema','fechaIngreso','fechaSalida','esSuperUsuario','soloAdmin');
			$crud->set_subject('Usuarios');
//			$crud->set_relation('salesRepEmployeeNumber','employees','lastName');
                        
//                        $crud->unset_jquery();
			$output = $crud->render();
                        
                        $this->load->view('crud_view_datatable',$output); 
	}
        
        function encrypt_password_callback($post_array, $primary_key = null)
        {
            $post_array['clave'] = md5($post_array['clave'].get_settings('PASSWORDSALTMAIN')); 
            return $post_array;
        }        

}