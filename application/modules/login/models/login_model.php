<?php
Class Login_model extends CI_Model
{
 function login($username, $password)
 {

    $query = $this->db->query('SELECT em.id, em.PersonaComercio_cedulaRuc cedulausu, em.username username,  em.esSuperUsuario essuperusuario,
	em.nombres nombres, em.apellidos apellidos, em.email email, em.telefonos telefonos, em.celular celular
	FROM  billing_empleado em
	WHERE em.username = "'.$username.'" AND em.clave = "'.MD5($password.get_settings('PASSWORDSALTMAIN')).'"');     

   if($query -> num_rows() == 1)
   {
     return $query->result();
   }
   else
   {
     return false;
   }
 }
}
