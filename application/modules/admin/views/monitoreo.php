<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>

<!--<div id="page-wrapper">-->
            <!-- /.row -->
    <?php
        echo Open('div', array('class'=>'row'));
            echo get_item_view($num_ventas, base_url('ventas/ventas/view'), 'Ventas Archivadas!', 'Ver Detalles','fa fa-shopping-cart fa-5x', 'panel panel-green');
            echo get_item_view($num_ventas_anuladas, base_url('ventas/ventas/view'), 'Ventas Anuladas!', 'Ver Detalles','fa fa-shopping-cart fa-5x', 'panel panel-red');
            echo get_item_view($num_compras, base_url('compras/compras/view'), 'Compras Archivadas!', 'Ver Detalles','fa fa-tasks fa-5x', 'panel panel-yellow');
            echo get_item_view($num_compras_anuladas, base_url('compras/compras/view'), 'Compras Anuladas!', 'Ver Detalles','fa fa-tasks fa-5x', 'panel panel-red');
            
            echo get_item_view($costo_inventario, base_url('compras/compras/view'), 'Costo Inventario!', 'Ver Detalles','glyphicon glyphicon-usd fa-5x', 'panel panel-green');
            echo get_item_view($num_compras_anuladas, base_url('compras/compras/view'), 'Ventas en Pendiente!');
            echo get_item_view($num_compras_anuladas, base_url('compras/compras/view'), 'Compras en Pendiente!');
            
            echo get_item_view($num_nuevos_clientes, base_url('admin/clients/view'), 'Nuevos Clientes!', 'Ver Detalles','glyphicon glyphicon-user fa-5x', 'panel panel-primary');
        echo Close('div');    
    ?>