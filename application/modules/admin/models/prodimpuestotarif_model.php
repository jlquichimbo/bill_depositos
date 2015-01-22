<?php

class Prodimpuestotarif_model extends CI_Model {

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
		$this->db->insert('bill_productoimpuestotarifa', $form_data);
		
		if ($this->db->affected_rows() == '1')
		{
//			return TRUE;
                        return $this->db->insert_id();
		}
		
		return FALSE;
	}
        
        /* busca por impuesto y tarifa impuesto para comprobar si el producto tiene asignado esa tarifa de impuesto */
        function find($prodid, $imp_tarif) {
            $this -> db -> select('id');
            $this -> db -> from('bill_productoimpuestotarifa');
            $this -> db -> where('producto_id', $prodid);
            $this -> db -> where('impuestotarifa_id', $imp_tarif);
            $this -> db -> limit(1);
            $query = $this -> db -> get();
            $ret = $query->row();
//            print_r($ret);
            if($ret){
                return $ret->id;                
            }else{
                return 0;
            }
        }
        
        function delete_prodimptarif($data) {
            $this->db->delete('bill_productoimpuestotarifa', $data);
            if ($this->db->affected_rows() > 0)
                {
                        return TRUE;
                }
                    return FALSE;            
        }
        
	function getImpuestoByTarifa($id)
	{
            $this -> db -> select('impuesto_id');
            $this -> db -> from('bill_impuestotarifa');
            $this -> db -> where('id', $id);
            $this -> db -> limit(1);
            $query = $this -> db -> get();

        //    $query = $this->db->get();
            $ret = $query->row();
            return $ret->impuesto_id;    
	}

}