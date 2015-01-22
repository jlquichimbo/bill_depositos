<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

echo Open('form', array('action'=>  base_url('admin/retencion/get_crud'),'method'=>'post'));

    echo Open('div',array('class'=>'col-md-3 form-group'));
        echo Open('div',array('class'=>'input-group'));
          echo tagcontent('span', 'F. Emision', array('class'=>'input-group-addon'));
          echo input(array('name'=>"fecha_desde",'id'=>"fecha_desde", 'type'=>"text",'class'=>"form-control datepicker",'placeholder'=>"Desde", 'style'=>"width: 50%"));
          echo input(array('name'=>"fecha_hasta",'id'=>"fecha_hasta", 'type'=>"text", 'class'=>"form-control datepicker", 'placeholder'=>"Hasta", 'style'=>"width: 50%"));
        echo Close('div');
    echo Close('div'); 
    
    echo Open('div',array('class'=>'col-md-2 form-group'));
        echo Open('div',array('class'=>'input-group'));
          echo tagcontent('span', 'Nro.', array('class'=>'input-group-addon'));
          echo input(array('name'=>"nro",'id'=>"nro", 'type'=>"text",'class'=>"form-control positive",'placeholder'=>"Nro Retencion", 'style'=>"width: 100%"));
        echo Close('div');
    echo Close('div'); 
                    
    echo Open('div',array('class'=>'col-md-2'));
        echo tagcontent('button', 'Buscar', array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'retencioneslist_out','class'=>'btn btn-primary btn-block'));
    echo Close('div');
    
echo Close('form');

echo tagcontent('div', '', array('id'=>'retencioneslist_out','class'=>'col-md-12'));