<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
echo tagcontent('button', '<span class="glyphicon glyphicon-print"></span>', array('id'=>'printbtn','data-target'=>'retencion_view','class'=>'btn btn-default'));
echo lineBreak2(1, array('class'=>'clr'));
echo Open('div',array('style'=>'font-size:14px;font-family:monospaced','id'=>'retencion_view'));
    echo Open('div',array('class'=>'col-md-7'));
        echo tagcontent('div', 'PROVEEDOR:', array('class'=>'col-md-4'));
        echo tagcontent('div', $proveedor->nombres.' '.$proveedor->apellidos, array('class'=>'col-md-8 clr'));
        
        echo tagcontent('div', 'RUC:', array('class'=>'col-md-4'));
        echo tagcontent('div', $proveedor->PersonaComercio_cedulaRuc, array('class'=>'col-md-8'));
        
        echo tagcontent('div', 'DIRECCI&Oacute;N:', array('class'=>'col-md-4'));
        echo tagcontent('div', $proveedor->direccion.'.', array('class'=>'col-md-8'));
        
        echo tagcontent('div', 'FECHA FACT', array('class'=>'col-md-4'));
        echo tagcontent('div', $ret->fechaemisionfactura.'.', array('class'=>'col-md-8'));
        
        echo tagcontent('div', 'NRO. FACT', array('class'=>'col-md-4'));
        echo tagcontent('div', str_pad($ret->doc_id, 9, '0', STR_PAD_LEFT), array('class'=>'col-md-8'));
        
        echo tagcontent('div', 'TIPO DE COMPROBANTE:', array('class'=>'col-md-4'));
        echo tagcontent('div', 'FACTURA',array('class'=>'col-md-8'));
    echo Close('div');

    echo Open('div',array('class'=>'col-md-5'));
        echo tagcontent('div', 'Nro.', array('class'=>'col-md-4'));
        echo tagcontent('div', $ret->establecimiento.$ret->pemision.'-'.str_pad($ret->nro, 9, '0', STR_PAD_LEFT), array('class'=>'col-md-8'));

        echo tagcontent('div', 'Aut. SRI', array('class'=>'col-md-4'));
        echo tagcontent('div', $ret->autorizacion_sri, array('class'=>'col-md-8'));

        echo tagcontent('div', 'Vence Aut.', array('class'=>'col-md-4'));
        echo tagcontent('div', $ret->vence_autorizacion_sri, array('class'=>'col-md-8'));

        echo tagcontent('div', 'Fecha', array('class'=>'col-md-4'));
        echo tagcontent('div', $ret->fecha, array('class'=>'col-md-8'));
    echo Close('div');
    
    echo Open('div',array('class'=>'col-md-12'));
        if($ret_detalle){
            echo Open('table',array('class'=>'table table-striped'));
                $thead = array('Base Imponible','Impuesto','Cod. Impuesto','Porcentaje Retencion','Valor Retenido');
                echo tablethead($thead);
                foreach ($ret_detalle as $val) {
                    echo Open('tr');
                        echo tagcontent('td', $val->base_imponible);
                        echo tagcontent('td', $val->impuesto_renta);
                        echo tagcontent('td', $val->cod_impuesto);
                        echo tagcontent('td', $val->porcent_ret);
                        echo tagcontent('td', $val->val_retenido);
                    echo Close('tr');
                }
            echo Close('table');
            echo tagcontent('label', 'Total:', array('class'=>'col-md-2'));
            echo tagcontent('label', $ret->total, array('class'=>'col-md-3'));
        }
    echo Close('div');    
echo Close('div');
