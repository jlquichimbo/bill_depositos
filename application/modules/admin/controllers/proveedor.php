<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Proveedor extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
		$this->load->library('grocery_CRUD');
	}

        public function view(){
            $res['view'] = $this->load->view('proveedor_searhc','',TRUE);
            $res['slidebar'] = $this->load->view('slidebar','',TRUE);
            $this->load->view('templates/dashboard',$res);
        }        
        
        public function loadsupl_view(){
            $crud = new grocery_CRUD();
            $this->config->load('grocery_crud');
            
            $crud->set_table('bill_proveedortipo');
            $res['suppliers_tipo'] = $crud->get_list_data(); 
                        
            $this->load->view('loadsupl_form',$res);
        }        
        
	public function index()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
			$crud = new grocery_CRUD();
                        
                        $like = $this->input->post('search_text');

                        $ci = $this->input->post('ci');                        
                        if(!empty($ci)){
                            $crud->where('billing_proveedor.PersonaComercio_cedulaRuc', $ci);                            
                        }                        
                        
                        if(!empty($like)){                            
                            $parambuscaprod = explode(' ', $like);
                            $where = '';
                            $and = '';
                            foreach ( $parambuscaprod as $val ) {
                                $where .= $and.'(UPPER(nombres) LIKE "%'.strtoupper($val).'%" OR UPPER(apellidos) LIKE "%'.strtoupper($val).'%" )';
                                $and = ' AND ';    
                            }
                            $crud->where($where, null, false);
                        }
                        
			$crud->set_table('billing_proveedor');
			$crud->display_as('PersonaComercio_cedulaRuc','CI/RUC')
				 ->display_as('contacuentasplan_cod','Cta. Cont.');
//				 ->display_as('contactLastName','Last Name');
                        
                        
                        $crud->set_relation('contacuentasplan_cod','billing_contacuentasplan','{cod} {nombre}',array('contacuentas_cod'=>'2'));                        
			$crud->set_relation('proveedortipo_id','bill_proveedortipo','tipo');
			$crud->set_relation('docidentificacion_id','billing_docidentificaciontipo','nombre');                        
                        
                        $crud->set_relation_n_n('cod_retencion', 'bill_proveedor_sri_retencion', 'bill_sri_retencion', 'proveedor_id', 'sri_retencion_id', '{cod} {detalle_retencion}', 'priority');
//                        $crud->set_relation('contacuentasplan_cod ','billing_contacuentasplan','nombre',array('parent'=>'1'));
                        
                        $crud->required_fields('PersonaComercio_cedulaRuc');
                        $crud->required_fields('nombres');
                        $crud->unique_fields('razonsocial');                        
			$crud->set_subject('Proveedores');
                        
                        $crud->field_type('fecha', 'hidden', date('Y-m-d',time()));
                        $crud->unset_columns('fecha');
//                        $crud->unset_columns('contacuentasplan_cod');
                        $crud->callback_column('nombres',array($this,'open_param'));
//                        $crud->add_action('Parametrizacion', '', base_url('admin/proveedorparam/index/'),'glyphicon glyphicon-cog');
			$output = $crud->render();
                        
			$this->load->view('crud_view_datatable',$output);
	}
        
        
        public function open_param($value, $row)
        {
            $open = tagcontent('a', $value, array('id'=>'ajaxpanelbtn','data-url'=>base_url('admin/proveedorparam/index/'.$row->id),'data-target'=>'clientslistout','href'=>'#'));
            return $open;
        }             
        
    /*
     *  Cargamos varios clientes desde un archivo..
     */    
    function loadfromfile(){
        $this->load->library('excel');
        $this->load->library('docident');
        $this->load->model('proveedor_model');
            
        $config['upload_path'] = './uploads/';
        $config['allowed_types'] = 'xlsx';
        $config['max_size']	= '500';
        $config['max_width']  = '1024';
        $config['max_height']  = '768';

        $this->load->library('upload', $config);

        if ( ! $this->upload->do_upload())
        {
                $error = $this->upload->display_errors();
                echo tagcontent('strong', $error, array('class'=>'text-danger font20'));
            exit(0);    
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
                        $apellidos = $this->getValueXLS($PHPExcel,2,$x);
                        $razon_social = $this->getValueXLS($PHPExcel,3,$x);
                        $direccion = $this->getValueXLS($PHPExcel,4,$x);
                        $telefonos = $this->getValueXLS($PHPExcel,5,$x);
                        $email = $this->getValueXLS($PHPExcel,6,$x);

                    if(empty($ci)){ continue; }
                         $valuesprod = array(
                             'PersonaComercio_cedulaRuc'=>$ci,
                             'nombres'=>$nombres,
                             'apellidos'=>$apellidos,
                             'razonsocial'=>$razon_social,
                             'direccion'=>$direccion,
                             'telefonos'=>$telefonos,
                             'email'=>$email,
                             'fecha'=>date('Y-m-d',time()),
                             'proveedortipo_id'=>$this->input->post('suppliertipo_id'),
                             'es_pasaporte'=>$this->input->post('es_pasaporte'),
                             'contacuentasplan_cod'=>'201030101',
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
                            $_POST['nombres'] = strtoupper($_POST['nombres']);
                            $_POST['apellidos'] = strtoupper($_POST['apellidos']);
                            $_POST['razonsocial'] = strtoupper($_POST['razonsocial']);                            
                             $res1 = $this->proveedor_model->save($valuesprod);                                         
                        }else{
                            echo tagcontent('strong', 'CI/RUC parece no ser v&aacute;lido', array('class'=>'text-danger'));
                        }
/********************************************************************************/                                                        
                        if(!$res1){
                            echo tagcontent('div', 'Ha ocurrido un problema, no se pudo crear el cliente '.$nombres, array('class'=>'text-danger font20'));
                        }
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