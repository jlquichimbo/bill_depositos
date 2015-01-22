<?php

class Product_model extends CI_Model {

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

//	function SaveForm($form_data)
//	{
////            print_r($form_data);
//		$this->db->insert('billing_producto', $form_data);
//		
//		if ($this->db->affected_rows() == '1')
//		{
////			return TRUE;
//                        return $this->db->insert_id();
//		}
//		
//		return FALSE;
//	}

        
        function edit($data,$id)
	{
            $this->db->where('codigo', $id);
            $this->db->update('billing_producto', $data); 
            if ($this->db->affected_rows() == '1')
            {
                    return TRUE;
            }
            return FALSE;            
	}
        
/******************************************************************************/
        function find($data){
            $this -> db -> select( ' p.codigo, p.nombreUnico, p.descripcion, p.stockactual, p.costopromediokardex, p.costoultimokardex, p.esServicio servicio, p.marca_id, p.productotipo_id, p.ivaporcent, p.iceporcent, p.ajuste1, p.codigo2, p.codbarras1, p.codbarras2, p.codbarras3, p.productogrupo_codigo');
            $this -> db -> from('billing_producto p');           
            
            if(!empty($data['product_name'])){
                $parambuscaprod = explode(' ', $data['product_name']);
                foreach ( $parambuscaprod as $val ) {
                    $this->db->like('UPPER(p.nombreUnico)', strtoupper($val));
                }                
            }
            /* si se busca por id del producto, devolvemos los datos de unicamente ese producto*/
            if(!empty($data['id'])){
                $this->db->where( 'p.codigo', $data['id'] );
                $this->db->limit( 1 );
                $query = $this -> db -> get();
                return $query->row();
            }            
            if(!empty($data['stock'])){
                $this->db->where( 'p.stockactual >', 0 );
            }

            $query = $this -> db -> get();
            return $query->result();
        }

        function findTarifaImp($prodid,$impuestoid){
            $this -> db -> select( ' pit.impuestotarifa_id, pit.impuesto_id, it.tarporcent ');
            $this -> db -> from('bill_productoimpuestotarifa pit');
            $this -> db -> join('bill_impuestotarifa it', 'pit.impuestotarifa_id = it.id');
            $this -> db -> where('pit.producto_id', $prodid);
            $this -> db -> where('it.impuesto_id', $impuestoid); // impusesto_id = 2 , significa q estamos sacando el IVA -> cod. de IVA es 2
            $this -> db -> limit(1);
            
            $query = $this -> db -> get();
            $ret = $query->row();
//            print_r($ret);
            if($ret){
                return $ret->tarporcent;                
            }else{
                return 0;
            }
        }
        
        function update( $id, $data ) {
            $this->db->where('codigo', $id);
            $this->db->update('billing_producto', $data);
        }
/******************************************************************************/
       
}