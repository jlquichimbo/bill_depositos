<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function get_item_view($num_items, $url, $title, $description='Ver Detalles', $icon='glyphicon glyphicon-certificate fa-5x', $panel_class='panel panel-primary',$item_class='col-lg-3 col-md-6') {
    $output = '';
    $output .= Open('div', array('class'=>$item_class));
        $output .= Open('div', array('class'=>$panel_class));
            $output .= Open('div', array('class'=>'panel-heading'));
                $output .= Open('div', array('class'=>'row'));
                    $output .= tagcontent('div', '<i class="'.$icon.'"></i>', array('class'=>'col-xs-3'));
                    $output .= tagcontent('div', '<div class="huge">'.$num_items.'</div><div>'.$title.'</div>', array('class'=>'col-xs-9 text-right'));
                $output .= Close('div');
            $output .= Close('div');
            
            $output .= Open('a', array('href'=>$url));
                $output .= Open('div', array('class'=>'panel-footer'));
                    $output .= tagcontent('span', $description, array('class'=>'pull-left'));
                    $output .= tagcontent('span', '<i class="fa fa-arrow-circle-right"></i>', array('class'=>'pull-right'));
                    $output .= tagcontent('div', '', array('class'=>'clearfix'));
                $output .= Close('div');
            $output .= Close('a');
        $output .= Close('div');
    $output .= Close('div');
    
    return $output;
}

function get_combo_group($label, $combo, $class = 'col-md-2 form-group'){
    $output = '';
    $output .= Open('div',array('class'=>$class));
        $output .= Open('div',array('class'=>'input-group'));
          $output .= tagcontent('span', $label, array('class'=>'input-group-addon'));
          $output .= $combo;
        $output .= Close('div');
    $output .= Close('div');    
    return $output;
}

function get_check_group($label_array, $checkbox_data, $label_attr){
    $output = '';
    $output .= Open('div',array('class'=>'btn-group','data-toggle'=>"buttons"));
        $cont = 0;
        foreach ($checkbox_data as $key => $value) {
            $input = input($value);
            $output .= tagcontent('label', $input.' '.$label_array[$cont], $label_attr[$cont]);
            $cont++;
        }
    $output .= Close('div');
    return $output;
}

function get_field_group($label, $text_inputs, $class = 'col-md-2 form-group') {
    $output = '';
        $output .= Open('div',array('class'=>$class));
            $output .= Open('div',array('class'=>'input-group'));
              $output .= tagcontent('span', $label, array('class'=>'input-group-addon'));
                foreach ($text_inputs as $attr_input) {
                  $output .= input($attr_input);                  
                }
            $output .= Close('div');
        $output .= Close('div');
    return $output; 
}
