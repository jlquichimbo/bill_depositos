<?php

class Proveedor_model extends CI_Model {

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

	function save($form_data)
	{
//            print_r($form_data);
		$this->db->insert('billing_proveedor', $form_data);
		
		if ($this->db->affected_rows() == '1')
		{
			return TRUE;
//                        return $this->db->insert_id();
		}
		
		return FALSE;
	}
 
}