<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Retencionconf extends MX_Controller {

	public function __construct()
	{
		parent::__construct();
                $this->load->model('generic_model');
                $this->load->library('grocery_CRUD');
	}

        public function index(){
            $res['view'] = $this->load_config_view();
            $res['slidebar'] = $this->load->view('slidebar');
            $this->load->view('templates/dashboard',$res);
        }
        
        private function load_config_view() {
            $output = Open('form',array('method'=>'post','class'=>'col-md-6','action'=>  base_url('admin/retencionconf/load_file')));
                $output .= 'Reemplazar:'.input(array('type'=>'checkbox','name'=>'reemplazar','value'=>'1'));
                $output .= tagcontent('div', input(array('type'=>'file','name'=>'userfile','class'=>'form-control')), array('class'=>'col-md-5'));
                $output .= tagcontent('button', 'Subir..', array('id'=>'ajaxformbtn','data-target'=>'load_ret_file_out','class'=>'btn btn-primary'));
            $output .= Close('form');
            
            $ret_imp = $this->generic_model->get_all('bill_sri_retencionimpuesto');
            
            $output .= Open('form',array('method'=>'post','class'=>'col-md-6','action'=>  base_url('admin/retencionconf/get_crud')));
                $combo_ret_imp = combobox($ret_imp, array('label'=>'nombre','value'=>'id'), array('name'=>'ret_tipo','class'=>'form-control'), true);
                $output .= tagcontent('div', $combo_ret_imp, array('class'=>'col-md-4'));
                $output .= tagcontent('button', 'Listar..', array('id'=>'ajaxformbtn','data-target'=>'load_ret_file_out','class'=>'btn btn-primary'));
            $output .= Close('form');
            $output .= tagcontent('div', '', array('id'=>'load_ret_file_out','class'=>'col-md-12'));
            
            $output .= tagcontent('div', '', array('id'=>'load_ret_file_out','class'=>'col-md-12'));
            
            return $output;
        }
                
	public function get_crud()
	{
            $this->config->load('grocery_crud');
            $this->config->set_item('grocery_crud_dialog_forms',true);
//		$this->config->set_item('grocery_crud_default_per_page',10);            
            $crud = new grocery_CRUD();
            $crud->set_theme('datatables2');
            
            $ret_tipo = $this->input->post('ret_tipo');
            if($ret_tipo != -1){
                $crud->where('impuesto_renta',$ret_tipo);
            }
            $crud->set_table('bill_sri_retencion');
//            $crud->set_relation('impuesto_renta', 'bill_sri_retencionimpuesto', 'nombre');
//            $crud->columns('id','nombre','descripcion','orden','vistaweb');
            $crud->set_subject('Tipos Retencion');
            $output = $crud->render();
            $this->load->view('crud_view_datatable', $output);
    	}
        
    /*
     *  Cargamos varios clientes desde un archivo..
     */    
    function load_file(){
        $this->load->library('excel');
            
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
            // Asignar hoja de excel activa
            $PHPExcel->setActiveSheetIndex(0);

                 /* 
                  * Si esta marcada la opcion reemplazar, entonces primero
                  * eliminarmos todos los registros para luego ingresar todos los datos del archivo
                  */
                 $reemplazar = $this->input->post('reemplazar');
                 if(!empty($reemplazar)){
//                     $this->retencion_model->delete_all();
                     $this->generic_model->delete_all('bill_sri_retencion');
                 }

                for ($x = 2; $x <= $PHPExcel->getActiveSheet()->getHighestRow() ; $x++){
                        $cod = $this->getValueXLS($PHPExcel,0,$x); 
                        $detalle_retencion = $this->getValueXLS($PHPExcel,1,$x);
                        $porcent_retencion = $this->getValueXLS($PHPExcel,2,$x);
                        $impuesto_renta = $this->getValueXLS($PHPExcel,3,$x);                        
                        $cta_cont_compras = $this->getValueXLS($PHPExcel,4,$x);
                        $cta_cont_ventas = $this->getValueXLS($PHPExcel,5,$x);

                         $data = array(
                             'cod' => $cod,
                             'detalle_retencion' => $detalle_retencion,
                             'porcent_retencion' => $porcent_retencion,
                             'impuesto_renta' => $impuesto_renta,
                             'cta_cont_compras' => $cta_cont_compras,
                             'cta_cont_ventas' => $cta_cont_ventas,
                         );
                         
                         $res1 = $this->generic_model->save($data,'bill_sri_retencion');

/********************************************************************************/                                                                                    
                        if(!$res1){
                            echo tagcontent('div', 'Ha ocurrido un problema, no se pudo cargar el codigo '.$cod, array('class'=>'text-danger font20'));
                        }
                }
                echo tagcontent('strong', 'El proceso se ha completado', array('class'=>'text-success font20'));
            } else {
                echo 'No se ha podido cargar el arcivo .xlsx';
            }
    }

    private function getValueXLS($PHPExcel,$col,$row){
        $res = $PHPExcel->getActiveSheet()->getCellByColumnAndRow($col,$row)->getCalculatedValue();
        return $res;
    }

}