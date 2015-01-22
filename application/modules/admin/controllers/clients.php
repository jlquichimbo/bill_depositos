<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Clients extends MX_Controller {

	public function __construct()
	{
            parent::__construct();
            $this->load->library('grocery_CRUD');
	}

        public function view(){
            $res['view'] = $this->load->view('clients_search','',TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);
            $this->load->view('templates/dashboard',$res);
        }
        
        public function loadcl_view(){
            $crud = new grocery_CRUD();
            $this->config->load('grocery_crud');            
            $crud->set_table('billing_clientetipo');
            $res['clientstipo'] = $crud->get_list_data();
            $this->load->view('loadcl_form',$res);
        }

	public function index()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
			$crud = new grocery_CRUD();
                        $crud->set_theme('datatables2');

                        $ci = $this->input->post('ci');                        
                        if(!empty($ci)){
                            $crud->where('billing_cliente.PersonaComercio_cedulaRuc', $ci);                            
                        }else{
                            $like = $this->input->post('search_text');                       
                            if(!empty($like)){                            
                                $parambuscaprod = explode(' ', $like);
                                $where = '';
                                $and = '';
                                foreach ( $parambuscaprod as $val ) {
                                    $where .= $and.'(UPPER(billing_cliente.nombres) LIKE "%'.strtoupper($val).'%" OR UPPER(billing_cliente.apellidos) LIKE "%'.strtoupper($val).'%" )';
                                    $and = ' AND ';    
                                }
                                $crud->where($where, null, false);
                            }                            
                        }
                                                
			$crud->set_table('billing_cliente');
                        $crud->columns('PersonaComercio_cedulaRuc','nombres','apellidos','razonsocial','direccion','telefonos','celular','email','clientetipo_idclientetipo');                        
			$crud->display_as('PersonaComercio_cedulaRuc','CI/RUC')
                             ->display_as('clientetipo_idclientetipo','Tipo');
                        
			$crud->set_subject('Clientes');
			$crud->set_relation('clientetipo_idclientetipo','billing_clientetipo','tipo');
			$crud->set_relation('docidentificacion_id','billing_docidentificaciontipo','nombre');
			$crud->set_relation('vendedor_id','billing_empleado','{nombres} {apellidos}');
                                                
                        
                        $crud->field_type('fecha', 'hidden', date('Y-m-d',time()));
                        $crud->unset_fields('fecha');                        
                        
                        $add_fields = array('es_pasaporte','PersonaComercio_cedulaRuc','nombres','apellidos','razonsocial','direccion','telefonos','celular','email','clientetipo_idclientetipo','vendedor_id');
                        $edit_fields = array('nombres','apellidos','razonsocial','direccion','telefonos','celular','email','vendedor_id');
                        $ver_datos_especiales = $this->user->check_permission( array('admin','config_client'), $this->user->id );
                        
                        if( $ver_datos_especiales OR ($this->user->essuperusuario == 1) ){
                            array_push($add_fields, 'diasCredito','cupocredito','cupo_temporal','descuentomaxporcent');
                            array_push($edit_fields, 'clientetipo_idclientetipo','diasCredito','cupocredito','cupo_temporal','descuentomaxporcent');
                        }
                                                    
                        $crud->add_fields2( $add_fields );
                        
                        
                        $crud->edit_fields2( $edit_fields );
                        
                        $crud->set_conf_insert_url(base_url('admin/clients/add'));
                        $crud->set_add_file('add_new.php');
                        
			$output = $crud->render();
                        
			$this->load->view('crud_view_datatable.php',$output);
	}
        
/* 
 * Agregamos un nuevo cliente, este es un metodo personalizado, sin
 * hacer uso de grocery crud, debido a la condiciones extrar para 
 * crear un cliente nuevo 
 */        
        public function add(){
            $this->load->library('docident');
            $this->load->model('client_model');
            
            unset( $_POST['is_ajax'] );
            
            if(empty($_POST['es_pasaporte'])){
                $tiporuc = 1; //1 es el codigo interno de RUC dato por el SRI, 2 para cedula, y 3 para pasaporte
                $docidvalid = $this->docident->validarCedula($_POST['PersonaComercio_cedulaRuc']);            
                if($docidvalid){ $tiporuc = 2; } // si es una cedula valida
                if(!$docidvalid){ $docidvalid = $this->docident->validarRucPersonaNatural($_POST['PersonaComercio_cedulaRuc']); }
                if(!$docidvalid){ $docidvalid = $this->docident->validarRucSociedadPrivada($_POST['PersonaComercio_cedulaRuc']); }
                if(!$docidvalid){ $docidvalid = $this->docident->validarRucSociedadPublica($_POST['PersonaComercio_cedulaRuc']); }
            }else{
                $docidvalid = $this->docident->validarPasaporte($_POST['PersonaComercio_cedulaRuc']);
                $tiporuc = 3; /* PASAPORTE */
            }
            
            if($docidvalid){
                $_POST['docidentificacion_id'] = $tiporuc;
                $_POST['nombres'] = strtoupper($_POST['nombres']);
                $_POST['apellidos'] = strtoupper($_POST['apellidos']);
                $_POST['razonsocial'] = strtoupper($_POST['razonsocial']);

                $res = $this->client_model->save($_POST);

                if($res){
                    echo 'Cliente agregado correctamente';
                }else{
                    echo 'No fue posible agregar el cliente';
                }                
            }else{
                echo tagcontent('strong', 'CI/RUC parece no ser v&aacute;lido', array('class'=>'text-danger'));
            }
            
        }
        
    /*
     *  Cargamos varios clientes desde un archivo..
     */    
    function loadfromfile(){
        set_time_limit(0);
        $this->load->library('excel');
        $this->load->library('docident');
        $this->load->model('client_model');
            
        $config['upload_path'] = './uploads/';
        $config['allowed_types'] = 'xlsx';
        $config['max_size']	= '0';
        $config['max_width']  = '0';
        $config['max_height']  = '0';

        $this->load->library('upload', $config);

        if ( ! $this->upload->do_upload())
        {
                $error = $this->upload->display_errors();
                echo tagcontent('strong', $error, array('class'=>'text-danger font20'));
                die();    
        }
        else
        {
            $upl_data = $this->upload->data();
        }

        $upl_data = $this->upload->data();

        if (file_exists ('./uploads/'.$upl_data['file_name'])) {
            // Cargando la hoja de c�lculo
            $Reader = new PHPExcel_Reader_Excel2007();
            $PHPExcel = $Reader->load('./uploads/'.$upl_data['file_name']);
            $objFecha = new PHPExcel_Shared_Date();
            // Asignar hoja de excel activa
            $PHPExcel->setActiveSheetIndex(0);

                $servicio = 0;
                $idtipoprod = $this->input->post('idtipoprod');
                if($idtipoprod == 3){ $servicio = 1; }

                for ($x = 2; $x <= $PHPExcel->getActiveSheet()->getHighestRow() ; $x++){
                        $ci = $this->getValueXLS($PHPExcel,0,$x); 
                        $nombres = $this->getValueXLS($PHPExcel,1,$x);                        
                        
                        $existe = $this->generic_model->count_all_results('billing_cliente', array('PersonaComercio_cedulaRuc'=>$ci));
                        if($existe > 0 OR empty($ci) OR empty($nombres)){
                            echo info_msg(' El cliente con C.I/RUC. '.$ci. ' ya existe');
                            continue;
                        }
                        
                        $apellidos = $this->getValueXLS($PHPExcel,2,$x);
                        $razon_social = $this->getValueXLS($PHPExcel,3,$x);
                        $direccion = $this->getValueXLS($PHPExcel,4,$x);
                        $telefonos = $this->getValueXLS($PHPExcel,5,$x);
                        $email = $this->getValueXLS($PHPExcel,6,$x);

                         $valuesprod = array(
                             'PersonaComercio_cedulaRuc'=>$ci,
                             'nombres'=>$nombres,
                             'apellidos'=>$apellidos,
                             'razonsocial'=>$razon_social,
                             'direccion'=>$direccion,
                             'telefonos'=>$telefonos,
                             'email'=>$email,
                             'fecha'=>date('Y-m-d',time()),
                             'clientetipo_idclientetipo'=>$this->input->post('clientetipo_id'),
                             'es_pasaporte'=>$this->input->post('es_pasaporte'),
                          );
                           
/********************************************************************************/
                        $docidvalid = true;  
                        if(empty($_POST['es_pasaporte'])){
                            $tiporuc = 1; //1 es el codigo interno de RUC dato por el SRI, 2 para cedula, y 3 para pasaporte
                            $docidvalid = $this->docident->validarCedula($ci);            
                            if($docidvalid){ $tiporuc = 2; } // si es una cedula valida
                            if(!$docidvalid){ $docidvalid = $this->docident->validarRucPersonaNatural($ci); }
                            if(!$docidvalid){ $docidvalid = $this->docident->validarRucSociedadPrivada($ci); }
                            if(!$docidvalid){ $docidvalid = $this->docident->validarRucSociedadPublica($ci); }
                        }else{
                            $docidvalid = $this->docident->validarPasaporte($ci);
                            $tiporuc = 3; /* PASAPORTE */
                        }

                        if($docidvalid){
                            $valuesprod['docidentificacion_id'] = $tiporuc;
                             $res1 = $this->client_model->save($valuesprod);                                         
                                if(!$res1){
                                    echo tagcontent('div', 'Ha ocurrido un problema, no se pudo crear el cliente '.$nombres, array('class'=>'text-danger font20'));
                                }                             
                        }else{
                            echo tagcontent('strong', 'CI/RUC parece no ser v&aacute;lido', array('class'=>'text-danger'));
                        }
/********************************************************************************/                            
                }
                echo tagcontent('strong', 'Se ha terminado de cargar el listado de clientes', array('class'=>'text-success font20'));
            } else {
                echo 'No se ha podido cargar el arcivo .xlsx';
            }
    }
    
    private function getValueXLS($PHPExcel,$col,$row){
        $res = $PHPExcel->getActiveSheet()->getCellByColumnAndRow($col,$row)->getCalculatedValue();
        return $res;
    }    
        
}