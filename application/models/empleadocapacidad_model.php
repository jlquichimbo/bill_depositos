<?php

class Empleadocapacidad_model extends CI_Model {

	function __construct()
	{
		parent::__construct();
	}
	
	// --------------------------------------------------------------------

      /** 
       * function SaveForm()
       *
       * insert form data
       * @param $form_data - array
       * @return Bool - TRUE or FALSE
       */

	function get($capacidad)
	{
            $this -> db -> select( 'ec.Capacidades_capacidad capacidad, e.username, e.nombres, e.apellidos, CONCAT_WS("",e.nombres," ",e.apellidos) empleado,e.id empl_id', FALSE );
            $this -> db -> from( 'billing_empleadocapacidad ec' );
            $this -> db -> join( 'billing_empleado e', 'e.id = ec.empleado_id' );
            $this -> db -> where( 'ec.Capacidades_capacidad', $capacidad );
            $query = $this -> db -> get();

            return $query->result();
	}
}