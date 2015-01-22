<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

echo Open('form', array('action'=>  base_url('admin/tipopago/get_crud'),'method'=>'post','class'=>'col-md-2'));                    
    echo Open('div',array('class'=>'col-md-2'));
        echo tagcontent('button', 'Cargar Tipos Pago', array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'search_out','class'=>'btn btn-primary'));
    echo Close('div');    
echo Close('form');

echo tagcontent('div', '', array('id'=>'search_out','class'=>'col-md-12'));