<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Index extends MX_Controller {

 function __construct()
 {
   parent::__construct();
 }

 function index()
 {
          $this->load->model('productgroup_model');
          $this->load->model('prodimpuestotarif_model');
          
          $res['prodgroups'] = $this->productgroup_model->getAll();
          $res['prodtipos'] = $this->generic_model->get_all('billing_productotipo');
          $res['impuestostarif'] = $this->generic_model->get_all('bill_impuestotarifa');
          $res['marca'] = $this->generic_model->get_all('billing_marca');
        
          $res['view'] = $this->load->view('product',$res,TRUE);
          $res['slidebar'] = $this->load->view('slidebar',$res,TRUE);

          $this->load->view('templates/dashboard', $res);
          
 }
}