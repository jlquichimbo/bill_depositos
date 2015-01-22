<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

class Product extends MX_Controller {
               
	function __construct()
	{
 		parent::__construct();
		$this->load->library('form_validation');
		$this->load->library('excel');
		$this->load->library('grocery_CRUD');                
		$this->load->helper('form');
		$this->load->model('product_model');
	}	
        
        function index()
        {
          $this->load->model('productgroup_model');
          $this->load->model('prodimpuestotarif_model');
          
          $prodgroups['prodgroups'] = $this->productgroup_model->getAll();
          $prodgroups['prodtipos'] = $this->generic_model->get_all('billing_productotipo');
          $prodgroups['impuestostarif'] = $this->generic_model->get_all('bill_impuestotarifa');
          $prodgroups['marca'] = $this->generic_model->get_all('billing_marca');
          
          $prodgroups['view'] = $this->load->view('product',$prodgroups,TRUE);
          $prodgroups['slidebar'] = $this->load->view('slidebar',$prodgroups,TRUE);          
          $this->load->view('templates/dashboard',$prodgroups);
        }
        
        function searchview() {
          $res1['grupos'] = $this->generic_model->get('billing_productogrupo');
          $res1['marcas'] = $this->generic_model->get('billing_marca');              
          $res['view'] = $this->load->view('product_search',$res1,TRUE);
          $res['slidebar'] = $this->load->view('slidebar','',TRUE);          
          $this->load->view('templates/dashboard', $res);
        }
        
        function productsloadview() {
          $this->load->model('productgroup_model');
                    
          $prodgroups['prodgroups'] = $this->productgroup_model->getAll();
          $prodgroups['prodtipos'] = $this->generic_model->get_all('billing_productotipo');
          $prodgroups['impuestostarif'] = $this->generic_model->get_all('bill_impuestotarifa');
          $prodgroups['marca'] = $this->generic_model->get_all('billing_marca');
          
          $prodgroups['view'] = $this->load->view('productsloadview',$prodgroups, true);
          $prodgroups['slidebar'] = $this->load->view('slidebar',$prodgroups,TRUE);               
          $this->load->view('templates/dashboard', $prodgroups); 
        }
        
        function loadfromfile(){
          $this->load->model('prodimpuestotarif_model');    
            $config['upload_path'] = './uploads/';
            $config['allowed_types'] = 'xlsx';
            $config['max_size']	= '100';
            $config['max_width']  = '1024';
            $config['max_height']  = '768';

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
                        $nombre = get_value_xls($PHPExcel,0,$x); 
                        $codcomun = get_value_xls($PHPExcel,2,$x);

                        $existe = $this->generic_model->count_all_results('billing_producto', array('nombreUnico'=>$nombre));
                        if( $existe OR empty($nombre) ){
                            echo warning_msg(' El producto '.  get_short_string($nombre, 25).' ya existe');
                            continue;
                        }else{
                            $existe2 = $this->generic_model->count_all_results('billing_producto', array('codigo2'=>$codcomun)); 
                            if($existe2){
                                echo warning_msg(' El producto con codigo '.  $codcomun.' ya existe');
                                continue;                                
                            }
                        }
                        
                        $codbarras1 = get_value_xls($PHPExcel,3,$x);
                        $codbarras2 = get_value_xls($PHPExcel,4,$x);
                        $codbarras3 = get_value_xls($PHPExcel,5,$x);                        
                        $descripcion = get_value_xls($PHPExcel,1,$x);
                            
                             $valuesprod = array(
                                 'nombreUnico'=>$nombre,
                                 'descripcion'=>$descripcion,
                                 'fechacreacion'=>date('Y-m-d',time()),
                                 'fechaultactualizacion'=>date('Y-m-d',time()),
                                 'esServicio'=>$servicio,
                                 'marca_id'=>$this->input->post('marca_id'),
                                 'productogrupo_codigo'=>$this->input->post('productogrupo_codigo'),
                                 'productotipo_id'=>$this->input->post('idtipoprod'),
                                 'codigo2'=>$codcomun,
                                 'codbarras1'=>$codbarras1,
                                 'codbarras2'=>$codbarras2,
                                 'codbarras3'=>$codbarras3,
                              );
                                $prodid = $this->generic_model->save($valuesprod,'billing_producto');
                                
                                /*********************************/
                                        $impuestos = $this->input->post('impuestotarif');
                                        
                                        if(empty($impuestos)){
                                            echo info_msg(' Debe seleccionar al menos un impuesto para el producto');
                                            echo tagcontent('script', 'alertaError("Debe seleccionar al menos un impuesto para el producto")');                                            
                                            $this->db->trans_rollback();
                                            die();
                                        }
                                                                                    
                                        foreach ($impuestos as $value) {
                                            $impuesto_id = $this->prodimpuestotarif_model->getImpuestoByTarifa($value);
                                            $dataprodimptarif = array(
                                                'producto_id'=>$prodid,
                                                'impuestotarifa_id'=>$value,
                                                'impuesto_id'=>$impuesto_id,
                                            );
                                            $this->generic_model->save($dataprodimptarif,'bill_productoimpuestotarifa');
                                        }                                
                                /*********************************/
                                
                                if(!$prodid){
                                    echo tagcontent('div', 'No se pudo agregar el producto '.$nombre, array('class'=>'text-danger'));
                                }
                    }
                    echo success_msg(', la lista de productos ha sido procesada.');

                } else {
                    echo warning_msg(' No se ha podido cargar el arcivo .xlsx');
                }
        }        
        
	public function find()
	{
                $this->config->load('grocery_crud');
		$this->config->set_item('grocery_crud_dialog_forms',true);
                $crud = new grocery_CRUD();
                        
                $product_id = $this->input->post('product_id');
                if(!empty($product_id)){
                    $crud->where('codigo', $product_id);
                }

                $grupo_id = $this->input->post('grupo_id');
                if( $grupo_id != -1 ){
                    $crud->where('productogrupo_codigo', $grupo_id);
                }

                $marca_id = $this->input->post('marca_id');
                if($marca_id != -1){
                    $crud->where('marca_id', $marca_id);
                }
                
                
                 $like = $this->input->post('product_name');
                if(!empty($like)){                            
                    $parambuscaprod = explode(' ', $like);
                    $where = '';
                    $and = '';
                    foreach ( $parambuscaprod as $val ) {
                        $crud->like('UPPER(nombreUnico)', strtoupper($val) );
                    }
                }

                $crud->set_table('billing_producto');
                $crud->columns('codigo','nombreUnico','stockactual','costopromediokardex','costoultimokardex','esServicio','productogrupo_codigo','marca_id','productotipo_id','ajuste','ajuste2');

                $edif_fields = array('nombreUnico','codigo2','descripcion','es_promo','es_promo2','ajuste1','ajuste2','ajuste2cuantos');
                $crud->edit_fields2($edif_fields);

                $crud->set_subject('Productos');

                $crud->callback_column('nombreUnico',array($this,'get_link_edit'));

                $crud->unset_add()->unset_delete();
                $output = $crud->render();
                $this->load->view('crud_view_datatable',$output);     
	}        
        
        
        public function get_link_edit($value, $row)
        {
            $link = tagcontent('a', $value, array('id'=>'ajaxpanelbtn','data-url'=>  base_url('admin/product/findbyid/'.$row->codigo),'title'=>'Modificacion del Producto','data-target'=>'productslistout','href'=>'#'));
            return $link;
        }         
        
//        function find(){
//             $this->load->model('admin/product_model','',TRUE);   
//             $data = array(
//                 'product_name'=>$this->input->post('product_name'),
//                 'product_cod'=>$this->input->post('product_cod'),
//                 'tiposprecio_id'=>$this->input->post('tiposprecio_id'),
//                 'stock'=>$this->input->post('stock'),
//                 'cuantos'=>$this->input->post('cuantos'),
//                 'desde'=>$this->input->post('desde'),
//             );
//             
//             $result['products']= $this->product_model->find($data);
//             $this->load->view('admin/productslist',$result);
//        }        

        function findbyid($id){
          $this->load->model('productgroup_model');
          $this->load->model('prodimpuestotarif_model');
          $this->load->model('product_model','',TRUE);   

             $data = array(
                 'id' => $id
             );
             
            $result['products']= $this->product_model->find($data);
            $result['prodgroups'] = $this->productgroup_model->getAll();
            $result['prodtipos'] = $this->generic_model->get_all('billing_productotipo');
            $result['impuestostarif'] = $this->generic_model->get_all('bill_impuestotarifa');
            $result['marca'] = $this->generic_model->get_all('billing_marca');
             
//             print_r($result);
//             $result['result'] = $this->product_model->find($data);
//             $result['searchdata'] = $data;
//             $result['tipo'] = $this->input->post('tipo');
             $this->load->view('admin/producteditview',$result);
        }        
        
	function save()
	{
          $this->load->model('prodimpuestotarif_model');
        
		$this->form_validation->set_rules('nombreUnico', 'Nombre', 'required|trim|max_length[256]');			
		$this->form_validation->set_rules('descripcion', 'Descripcion', '');			
		$this->form_validation->set_rules('existenciaMinima', 'Stock Min.', 'required|trim');			
		$this->form_validation->set_rules('existenciaMaxima', 'Stock Max.', 'required|trim');			
		$this->form_validation->set_rules('productogrupo_codigo', 'Grupo', 'required');			
		$this->form_validation->set_rules('productotipo_id', 'Tipo Prod.', 'required');			
		$this->form_validation->set_rules('marca_id', 'Marca', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras1', 'Cod. Barras1', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras2', 'Cod. Barras2', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras3', 'Cod Barras3', 'max_length[128]');
			
		$this->form_validation->set_error_delimiters('<br /><span class="error">', '</span>');
	
		if ($this->form_validation->run() == FALSE) // validation hasn't been passed
		{
                    echo tagcontent('div', 'Algunos campos requeridos estan incompletos! <span class="glyphicon glyphicon-remove"></span>', array('class'=>'text-danger font20','style'=>'font-weight: bold'));
		}
		else // passed validation proceed to post success logic
		{
		 	// build array for the model
                        $prodtipo_id = set_value('productotipo_id');
                        $es_servicio = 0;
                        if($prodtipo_id == 3){
                            $es_servicio = 1;
                        }
                    
                        $nombreUnico = strtoupper(set_value('nombreUnico'));
			$form_data = array(
                            'nombreUnico' => $nombreUnico,
                            'descripcion' => set_value('descripcion'),
                            'existenciaMinima' => set_value('existenciaMinima'),
                            'existenciaMaxima' => set_value('existenciaMaxima'),
                            'codbarras1' => set_value('codbarras1'),
                            'codbarras2' => set_value('codbarras2'),
                            'codbarras3' => set_value('codbarras3'),
                            'productogrupo_codigo' => set_value('productogrupo_codigo'),
                            'marca_id' => set_value('marca_id'),
                            'productotipo_id' => set_value('productotipo_id'),
                            'esServicio' => $es_servicio
                        );
//				print_r($form_data);	
			// run insert model to write data to db
		    $this->db->trans_start();
                    
                        $prodid = $this->generic_model->save($form_data,'billing_producto');

                            $impuestos = $this->input->post('impuestotarif');
                                if(empty($impuestos)){
                                    echo info_msg(' Debe seleccionar al menos un impuesto para el producto');
                                    echo tagcontent('script', 'alertaError("Debe seleccionar al menos un impuesto para el producto")');
                                    $this->db->trans_rollback();
                                    die();
                                }
                            foreach ($impuestos as $value) {
                                $impuesto_id = $this->prodimpuestotarif_model->getImpuestoByTarifa($value);
                                $dataprodimptarif = array(
                                    'producto_id'=>$prodid,
                                    'impuestotarifa_id'=>$value,
                                    'impuesto_id'=>$impuesto_id,
                                );
                                $this->generic_model->save($dataprodimptarif,'bill_productoimpuestotarifa');
                            }
                    $this->db->trans_complete();
		    redirect('admin/product/success');   // or whatever logic needs to occur                    
		}
	}

        function edit()
	{
          $this->load->model('prodimpuestotarif_model');            
		$this->form_validation->set_rules('nombreUnico', 'Nombre', 'required|trim|max_length[256]');			
		$this->form_validation->set_rules('descripcion', 'Descripcion', '');			
		$this->form_validation->set_rules('existenciaMinima', 'Stock Min.', 'required|trim');			
		$this->form_validation->set_rules('existenciaMaxima', 'Stock Max.', 'required|trim');			
		$this->form_validation->set_rules('productogrupo_codigo', 'Grupo', 'required');			
		$this->form_validation->set_rules('productotipo_id', 'Tipo Prod.', 'required');			
		$this->form_validation->set_rules('marca_id', 'Marca', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras1', 'Cod. Barras1', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras2', 'Cod. Barras2', 'max_length[128]');			
		$this->form_validation->set_rules('codbarras3', 'Cod Barras3', 'max_length[128]');
			
		$this->form_validation->set_error_delimiters('<br /><span class="error">', '</span>');
	
		if ($this->form_validation->run() == FALSE) // validation hasn't been passed
		{
                    echo tagcontent('div', 'Algunos campos requeridos estan incompletos! <span class="glyphicon glyphicon-remove"></span>', array('class'=>'text-danger font20','style'=>'font-weight: bold'));
		}
		else // passed validation proceed to post success logic
		{
		 	// build array for the model
                        $prodtipo_id = set_value('productotipo_id');
                        $es_servicio = 0;
                        if($prodtipo_id == 3){
                            $es_servicio = 1;
                        }
                    
			$form_data = array(
                            'nombreUnico' => set_value('nombreUnico'),
                            'descripcion' => set_value('descripcion'),
                            'existenciaMinima' => set_value('existenciaMinima'),
                            'existenciaMaxima' => set_value('existenciaMaxima'),
                            'codbarras1' => set_value('codbarras1'),
                            'codbarras2' => set_value('codbarras2'),
                            'codbarras3' => set_value('codbarras3'),
                            'productogrupo_codigo' => set_value('productogrupo_codigo'),
                            'marca_id' => set_value('marca_id'),
                            'productotipo_id' => set_value('productotipo_id'),
                            'esServicio' => $es_servicio
                        );
//				print_r($form_data);	
			// run insert model to write data to db
		    $this->db->trans_start();
                    $prodid = $this->input->post('id');
                        $res = $this->product_model->edit($form_data,$prodid);
                            if($res){
                                $del = $this->prodimpuestotarif_model->delete_prodimptarif(array('producto_id' => $prodid));
                                $impuestos = $this->input->post('impuestotarif');
                                foreach ($impuestos as $value) {
                                    $impuesto_id = $this->prodimpuestotarif_model->getImpuestoByTarifa($value);
                                    $dataprodimptarif = array(
                                        'producto_id'=>$prodid,
                                        'impuestotarifa_id'=>$value,
                                        'impuesto_id'=>$impuesto_id,
                                    );
                                    $this->prodimpuestotarif_model->save($dataprodimptarif);
                                }
                            }
                    $this->db->trans_complete();
		    redirect('admin/product/success');   // or whatever logic needs to occur
		}
	}
	function success()
	{
            echo tagcontent('div', 'El producto ha sido agregado correctamente <span class="glyphicon glyphicon-ok"></span>', array('class'=>'text-success font20','style'=>'font-weight: bold'));
	}
}
