<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

    echo Open('form', array('method'=>'post','action'=>  base_url().'admin/clients','style'=>'margin-top:10px'));
        
        $text_inputs = array(
            '0' => array('name'=>'ci','class'=>'form-control','placeholder'=>'C.I/RUC Cliente...')
        );
        echo get_field_group('C.I./RUC :', $text_inputs, 'col-md-3 form-group');
        
        $inp_btn = input(array('name'=>'search_text','class'=>'form-control','placeholder'=>'Nombres y/o Apellidos del CLiente'));
        $searchbtn = tagcontent('button', 'Buscar Cliente', array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'clientslistout','class'=>'btn btn-primary'));
        $add_client = tagcontent('button', '<span class="glyphicon glyphicon-plus"></span>', array('type'=>'button','id'=>'ajaxpanelbtn','data-target'=>'clientslistout','data-url'=>  base_url('admin/clients/index/add'),'class'=>'btn btn-primary'));
        $load_client = tagcontent('button', '<span class="glyphicon glyphicon-circle-arrow-up"></span>', array('type'=>'button','id'=>'ajaxpanelbtn','data-target'=>'clientslistout','data-url'=>  base_url('admin/clients/loadcl_view'),'class'=>'btn btn-primary'));
        echo Open('div',array('class'=>'input-group col-md-6'));
            echo $inp_btn; 
            echo tagcontent('span', $searchbtn, array('class'=>'input-group-btn'));
            echo tagcontent('span', $add_client, array('class'=>'input-group-btn'));
            echo tagcontent('span', $load_client, array('class'=>'input-group-btn'));
        echo Close('div');
    echo Close('form');
    echo tagcontent('div', '', array('id'=>'clientslistout'));