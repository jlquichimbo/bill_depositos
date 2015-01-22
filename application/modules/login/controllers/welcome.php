<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');
class Welcome extends MX_Controller {

function __construct()
 {
   parent::__construct();
 }
 
 function index() {
   if($this->session->userdata('userid'))
   {
       
//    session_start(); //we need to call PHP's session object to access it through CI
//    session_name('billingsofv1');  

     $session_data = $this->session->userdata('userid');
        $join_cluase = array(
            '0'=>array('table'=>'billing_capacidad c','condition'=>'ec.Capacidades_capacidad = c.capacidad')
        );
        $res['assignedrole'] = $this->generic_model->get_join('billing_empleadocapacidad ec', array('ec.empleado_id'=>$this->user->id), $join_cluase, $fields = 'ec.empleado_id, ec.Capacidades_capacidad, c.capacidad capacidad, ec.fecha, c.interno, c.acceso, c.ubicacion, c.tabid label');
              
        
        foreach ($res['assignedrole'] as $r) {
            $permiso = $r->capacidad;
            $this->session->set_userdata($permiso, 1);
        }

        $this->load->view('welcome_message',$res);
   }
   
   else
   {
     //If no session, redirect to login page
     redirect('login/login', 'refresh');
   }
 }
 
 function logout()
 {
   $this->session->sess_destroy();
   redirect('login/welcome', 'refresh');
 }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */