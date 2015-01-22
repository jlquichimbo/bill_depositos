<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

echo Open('form', array('action'=>  base_url('admin/empresa/get_crud'),'method'=>'post','class'=>'col-md-2'));                    
    echo Open('div',array('class'=>'col-md-2'));
        echo tagcontent('button', 'Cargar Empresas', array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'empresa_search_out','class'=>'btn btn-primary'));
    echo Close('div');    
echo Close('form');

echo Open('form', array('action'=>  base_url('admin/empresa/get_departamentos_crud'),'method'=>'post','class'=>'col-md-2'));                    
    echo Open('div',array('class'=>'col-md-2'));
        echo tagcontent('button', 'Cargar Departamentos', array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'empresa_search_out','class'=>'btn btn-primary'));
    echo Close('div');    
echo Close('form');

echo tagcontent('div', '', array('id'=>'empresa_search_out','class'=>'col-md-12'));