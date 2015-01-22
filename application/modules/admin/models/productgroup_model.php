<?php

class Productgroup_model extends CI_Model {

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

	function getAll()
	{
            $this -> db -> select('codigo,nombre,descripcion,vista_web, meses_garantia, activo esta_activo');
            $this -> db -> from('billing_productogrupo');
            $this -> db -> where('activo', 1);
            $query = $this -> db -> get();

            return $query->result();
	}
}