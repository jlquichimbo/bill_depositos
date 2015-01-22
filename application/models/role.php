<?php
Class Role extends CI_Model {
    function __construct() {
        parent::__construct();
    }
    
 /*  */
    function getUserRoles($userid, $param2){           
//       $query = $this->db->query("CALL billing_comunes_empleadocapacidadget('{$userid}',{$param2})");
       
       if( $param2 == 0 ){ /* Obtenemos las capacidades asignadas */
            $this -> db -> select('ec.empleado_id, ec.Capacidades_capacidad, c.capacidad capacidad, ec.fecha, c.interno, c.acceso, c.ubicacion, c.tabid label');
            $this -> db -> from('billing_empleadocapacidad ec');
            $this -> db -> join('billing_capacidad c', 'ec.Capacidades_capacidad = c.capacidad');
            $this->db->where('ec.empleado_id', $userid);
            $query = $this -> db -> get();            
       }else{ /* Obtenemos las capacidades no asignadas */
            $query = $this->db->query(                                        
                    "SELECT c.capacidad, c.acceso, c.interno, c.ubicacion ubicacion
		FROM billing_capacidad c
		WHERE  c.capacidad
			NOT IN (
				SELECT ec.Capacidades_capacidad capacidad
				FROM billing_empleadocapacidad ec
				WHERE  c.capacidad = ec.Capacidades_capacidad AND ec.empleado_id = {$userid}
			)"
            );
       }

        return $query->result();
   }
   
 /* obtenemos todos los permisos que us usuario podria tener */
    function getAllCapabilities(){
//        $query = $this->db->query("CALL billing_comunes_capacidadesget(1,1)");
        
//	SELECT capacidad, UPPER(capacidad) capacidadview, descripcion, imagen, ubicacion, tabid label, interno, acceso, tipo, icon 
//	FROM billing_capacidad 
//	WHERE estaActiva=pactivo 
//	AND modulovisible = pvisible ORDER BY orden;
        
            $query = $this->db->query(
                    "	SELECT capacidad, UPPER(capacidad) capacidadview, descripcion, imagen, ubicacion, tabid label, interno, acceso, tipo, icon 
                        FROM billing_capacidad 
                        WHERE estaActiva= 1  
                        AND modulovisible = 1 ORDER BY orden"
                );
       return $query->result();
   }
   
   function check_permission( $cap, $user, $type = 'OR'){
        $this -> db -> where('empleado_id', $user);
        
        if($type == 'OR'){
            $where = ''; $and = '';
            foreach ( $cap as $val ) {
                $where .= $and.'Capacidades_capacidad = "'.$val.'"';
                $and = ' OR ';
            }
            $this -> db -> where('('.$where.')', null, false);            
        }
        
        if($type == 'AND'){
            foreach ($cap as $val) {
                $this -> db -> where('Capacidades_capacidad', $val);
            }
        }
        
        $this -> db -> select('id');
        $this -> db -> from('billing_empleadocapacidad');
        $this -> db -> limit(1);
        $query = $this -> db -> get();
        $ret = $query->row();
        if($ret){
            return true;
        }else{
            return false;
        }       
   }
}