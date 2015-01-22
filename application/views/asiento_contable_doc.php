<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//print_r($ac_data);

if($ac_data){
    echo tagcontent('div', 'Asiento No. :'.$ac_data[0]->anio.'-'.str_pad($ac_data[0]->id, 11, '0', STR_PAD_LEFT), array('class'=>'col-md-12','style'=>'font-size:18px'));
    echo tagcontent('div', 'Fecha :'.$ac_data[0]->ac_fecha.' '.$ac_data[0]->ac_hora, array('class'=>'col-md-12','style'=>'font-size:18px'));
    echo Open('table',array('class'=>'table table-condensed table-striped'));
        $thead = array('Cod.','Cuenta','Debito','Credito','Detalle');
        echo tablethead($thead);
        foreach ($ac_data as $value) {
            echo Open('tr');
                echo tagcontent('td', $value->cuenta_cont_id);
                echo tagcontent('td', $value->cta_name);
                echo tagcontent('td', $value->debito);
                echo tagcontent('td', $value->credito);
                echo tagcontent('td', $value->detalle);
            echo Close('tr');
        }
    echo Close('table');
}else{
    echo info_msg(' No se puede encontrar el asiento generado por la transacci&oacute;n');
//    
    echo Open( 'form', array('method'=>'post','action'=> base_url()) );
        $text_inputs = array(
            '0' => array('type'=>'text','id'=>'account_name_autosugg','data-url'=>  base_url('common/autosiggest/autosugest_plan_cuentas/%QUERY'), 'class'=>'form-control', 'style'=>'width:70%','placeholder'=>'Nombre de la Cuenta'),
            '1' => array('type'=>'text','id'=>'account_cod_autosugg','data-url'=>  base_url('common/autosiggest/autosugest_plan_cuentas/%QUERY'), 'class'=>'form-control', 'style'=>'width:30%','placeholder'=>'Codigo'),
        );
        echo get_field_group('Cta. Contable:', $text_inputs, $class = 'col-md-4 form-group');
//            
    echo Close('form');
}
