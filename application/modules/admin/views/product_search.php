<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//echo get_item_view('Nuevo', base_url('admin/index'), 'Nuevo Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Buscar', base_url('admin/product/searchview'), 'Buscar Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-green');
//echo get_item_view('Subir', base_url('admin/product/productsloadview'), 'Subri Pproductos!', 'Subir desde Archivo','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Grupos', base_url('admin/grupos'), 'Grupo Pproductos!', 'Revisar Grupos','fa fa-shopping-cart fa-5x', 'panel panel-primary');
      
echo Open('div', array('class'=>'container-fluid'));
    echo Open('form', array('class'=>'form-horizontal','method'=>'post','action'=>base_url().'admin/product/find'));

    $combo_grupos = combobox($grupos, array('label'=>'nombre','value'=>'codigo'), array('name'=>'grupo_id','class'=>'form-control'), true);
    $combo_marcas = combobox($marcas, array('label'=>'nombre','value'=>'id'), array('name'=>'marca_id','class'=>'form-control'), true);
    
    echo get_combo_group('Grupo', $combo_grupos, $class = 'col-md-3 form-group');
    echo get_combo_group('Marca', $combo_marcas, $class = 'col-md-3 form-group');
    
    $text_inputs = array(
        '0' => array('name'=>'product_name','id'=>'product_name','placeholder'=>'Nombre del Producto','maxlength'=>'256','class'=>'form-control','style'=>'width:70%'),
        '1' => array('name'=>'product_id','id'=>'product_id','placeholder'=>'Codigo','maxlength'=>'256','class'=>'form-control','style'=>'width:30%')
    );
    echo get_field_group('Producto', $text_inputs, $class = 'col-md-4 form-group');
    
//        $input = tagcontent('div', input(array('name'=>'product_name','id'=>'product_name','placeholder'=>'Nombre del Producto','maxlength'=>'256','class'=>'form-control','required'=>'')), array('class'=>'col-md-12'));
//        echo tagcontent('div', $input, array('class'=>'col-md-4 form-group'));
    
        echo input(array('type'=>'hidden','name'=>'cuantos','value'=>'100')); //indicamos q se van a cargar bloques de 100 productos 
        echo input(array('type'=>'hidden','name'=>'desde','value'=>'0')); //indicamos desde q numero se comienzan a cargar los siguientes (100) productos    
        echo tagcontent('label', input(array('type'=>'checkbox','name'=>'stock','value'=>'1')).'Stock', array('class'=>'checkbox-inline'));

        echo input(array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'productslistout','value'=>'Buscar','class'=>'btn btn-primary pull-right','style'=>'margin-right:10px'));
    echo Close('form');
    echo lineBreak2(1, array('class'=>'clr'));
    echo tagcontent('div', '', array('id'=>'productslistout','class'=>'col-md-12'));
echo Close('div');