<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//echo get_item_view('Nuevo', base_url('admin/index'), 'Nuevo Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Buscar', base_url('admin/product/searchview'), 'Buscar Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Subir', base_url('admin/product/productsloadview'), 'Subri Pproductos!', 'Subir desde Archivo','fa fa-shopping-cart fa-5x', 'panel panel-green');
//echo get_item_view('Grupos', base_url('admin/grupos'), 'Grupo Pproductos!', 'Revisar Grupos','fa fa-shopping-cart fa-5x', 'panel panel-primary');
      
echo Open('div',array('class'=>'container-fluid col-md-12'));
    $groupopt = ''; 
    foreach ($prodgroups as $g) {
        $groupopt .= tagcontent('option', $g->nombre, array('value'=>$g->codigo)); 
    }
    $groupinp = tagcontent('select', $groupopt, array('class'=>'comboboxnewprod form-control','name'=>'productogrupo_codigo','id'=>'productogrupo_codigo'));

    $prodtiposopt = ''; 
    foreach ($prodtipos as $t) {
        $prodtiposopt .= tagcontent('option', $t->nombre, array('value'=>$t->id)); 
    }
    $tiposinp = tagcontent('select', $prodtiposopt, array('class'=>'form-control','name'=>'idtipoprod'));

    $marcasopt = ''; 
    foreach ($marca as $t) {
        $marcasopt .= tagcontent('option', $t->nombre, array('value'=>$t->id)); 
    }
    $marcasinp = tagcontent('select', $marcasopt, array('class'=>'comboboxnewprod form-control','name'=>'marca_id','id'=>'marca_id'));

        echo Open('form',array('method'=>'post','action'=>  base_url().'admin/product/loadfromfile','enctype'=>'multipart/form-data'));
            $label = tagcontent('label', 'Grupo:', array('class'=>'col-md-3')); 
            $input = tagcontent('div', $groupinp, array('class'=>'col-md-9'));    
            echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

            $label = tagcontent('label', 'Tipo:', array('class'=>'col-md-3')); 
            $input = tagcontent('div', $tiposinp, array('class'=>'col-md-9'));    
            echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

            $label = tagcontent('label', 'Marca:', array('class'=>'col-md-3')); 
            $input = tagcontent('div', $marcasinp, array('class'=>'col-md-9'));    
            echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

            echo tagcontent('div', input(array('type'=>'file', 'name' => 'userfile', 'required'=>'', 'class'=>'form-control')), array('class'=>'col-md-3'));


            echo lineBreak2(1, array('class'=>'clr'));
            foreach ($impuestostarif as $i) {
                if($i->id == 2){
                    $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','checked'=>'checked','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
                    echo tagcontent('div', $check, array('class'=>'checkbox'));            
                    continue;
                }
                    $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
                echo tagcontent('div', $check, array('class'=>'checkbox'));
            }        

            echo input(array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'loadfileout','class'=>'btn btn-primary pull-right','value'=>'Cargar Productos'));
        echo Close('form');    

        echo tagcontent('div', '', array('id'=>'loadfileout'));

        echo '<br class="clr"/><h2>Formato De Archivo .XLSX</h2>';
        echo '<table class="table">';
            $arrthead = array('NOMBRE','DESCRIPCION','COD. COMUN','COD. BARRAS1','COD. BARRAS2','COD. BARRAS3');
            echo tablethead($arrthead);
            tablethead($arrthead);
            $arrtd = array('Portatil toshiba CI7 14 pulg. negra','3ra generacion, incluye mouse y mochila, ..','','','','');
            foreach ($arrtd as $value) {
                echo tagcontent('td', $value);
            }
    //        echo tabletd($arrtd);
        echo '</table>';
echo Close('div');        