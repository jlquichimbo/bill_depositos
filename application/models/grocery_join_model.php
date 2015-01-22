<?php
class Grocery_join_model extends grocery_CRUD_Model
{
    private $select_join;
    private $where_join;
    private $join_clause;
    
    function set_where_join($val){ $this->where_join = $val; }
    function get_where_join(){ return $this->where_join; }

    function set_select_join($val){ $this->select_join = $val; }
    function get_select_join(){ return $this->select_join; }
    
    function set_join_clause($val){ 
        $this->join_clause = $val;         
    }
    function get_join_clause(){ 
        return $this->join_clause;         
    }    
    
    function get_list()
    {
    	if($this->table_name === null)
    		return false;
    	
    	$select = "{$this->table_name}.*";
    	
		// ADD YOUR SELECT FROM JOIN HERE <------------------------------------------------------
		// for example $select .= ", user_log.created_date, user_log.update_date";
//		$select .= ", billing_producto.stockactual, billing_producto.costopromediokardex, billing_producto.costoultimokardex, pg1.nombre nombregrupo ";
		$select .= $this->get_select_join();
    	if(!empty($this->relation))
    		foreach($this->relation as $relation)
    		{
    			list($field_name , $related_table , $related_field_title) = $relation;
    			$unique_join_name = $this->_unique_join_name($field_name);
    			$unique_field_name = $this->_unique_field_name($field_name);
    			
				if(strstr($related_field_title,'{'))
    				$select .= ", CONCAT('".str_replace(array('{','}'),array("',COALESCE({$unique_join_name}.",", ''),'"),str_replace("'","\\'",$related_field_title))."') as $unique_field_name";
    			else    			
    				$select .= ", $unique_join_name.$related_field_title as $unique_field_name";
    			
    			if($this->field_exists($related_field_title))
    				$select .= ", {$this->table_name}.$related_field_title as '{$this->table_name}.$related_field_title'";
    		}
    		
    	$this->db->select($select, false);
    	
		// ADD YOUR JOIN HERE for example: <------------------------------------------------------
		// $this->db->join('user_log','user_log.user_id = users.id');
//		 $this->db->join('billing_producto','billing_stockbodega.producto_codigo = billing_producto.codigo');
//		 $this->db->join('billing_productogrupo pg1','pg1.codigo = billing_producto.productogrupo_codigo AND billing_producto.productogrupo_codigo = 2');
		
        
        $join_cluase = $this->get_join_clause(); //es un array con todas las clausulas join
//        print_r($join_cluase);
        foreach ($join_cluase as $join) {
            if(!empty($join['option'])){
                $this->db->join($join['table'],$join['condition'],$join['option']);
            }else{
                $this->db->join($join['table'],$join['condition']);
            }
                        
        }        
        
    	$results = $this->db->get($this->table_name)->result();
    	
    	return $results;
    }
}