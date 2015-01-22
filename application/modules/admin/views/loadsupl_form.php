<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
echo Open('div',array('class'=>'container-fluid'));

//print_r($clientstipo);

        echo Open('form',array('method'=>'post','action'=>  base_url().'admin/proveedor/loadfromfile','enctype'=>'multipart/form-data'));
        
            echo combobox($suppliers_tipo, array('label'=>'tipo','value'=>'id'), array('name'=>'suppliertipo_id','class'=>''));
            echo tagcontent('div', input(array('type'=>'file', 'name' => 'userfile', 'required'=>'', 'class'=>'form-control')), array('class'=>'col-md-3'));
            echo 'Con Pasaporte'.input(array('type'=>'checkbox','name'=>'es_pasaporte','value'=>'1'));
            echo lineBreak2(1, array('class'=>'clr'));
            echo input(array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'loadfileout','class'=>'btn btn-primary pull-right','value'=>'Cargar Clientes'));
        echo Close('form');

        echo tagcontent('div', '', array('id'=>'loadfileout'));

        echo '<br class="clr"/><h2>Formato De Archivo .XLSX</h2>';
        echo '<table class="table">';
            $arrthead = array('CI/RUC','NOMBRES','APELLIDOS','RAZON SOCIAL','DIRECCION','TELEFONOS', 'EMAIL');
            echo tablethead($arrthead);
            tablethead($arrthead);
            $arrtd = array('1104555962','Esteban Yomairo','Chamba J.','CHAMBA JIMENEZ','LOJA, ...','2577441');
            foreach ($arrtd as $value) {
                echo tagcontent('td', $value);
            }
    //        echo tabletd($arrtd);
        echo '</table>';
echo Close('div');     