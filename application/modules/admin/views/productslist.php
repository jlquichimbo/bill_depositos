<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//print_r($formdata);
//$USER = $this->user;
if($products){
        echo Open('table', array('class'=>'table table-condensed table-striped'));
            $thead = array('Cod.','Nombre','Stock','<span class="pull-right">Costo Prom.</span>','<span class="pull-right">Costo Prom. + IVA</span>','<span class="pull-right">Ajuste1</span>');
            echo tablethead($thead);
            foreach ($products as $p) {
                $tarifaice = $this->product_model->findTarifaImp($p->codigo,3);
                $tarifaiva = $this->product_model->findTarifaImp($p->codigo,2);
                                
                //$price = $p->costopromediokardex + (($p->costopromediokardex * $p->utilidad)/100);
                $price = $p->costopromediokardex;
                $priceiva = $price + ( ($price * $tarifaiva)/100 );

                if( $p->stockactual < 1 ){ echo Open('tr',array('class'=>'danger text-danger')); }else{ echo Open('tr'); }
                    echo tagcontent('td', $p->codigo);
//                    echo tagcontent('td', anchor('#', $p->nombreUnico, array('id'=>"ajaxpanelbtnproductget",'data-target'=>"cxcpaneloutput",'title'=>"Modificacion del Producto",'data-url'=>base_url().'admin/product/findbyid/'.$p->codigo)) );
                    echo tagcontent('td', tagcontent('a', $p->nombreUnico, array('id'=>"ajaxpanelbtnproductget",'data-target'=>"cxcpaneloutput",'title'=>"Modificacion del Producto",'data-url'=>base_url().'admin/product/findbyid/'.$p->codigo,'href'=>'#')));

//                    echo tagcontent('td', anchor(base_url().'admin/product/findbyid/'.$p->codigo, $p->nombreUnico, array('data-title'=>"Modificacion del Producto",'data-trigger'=>'modal')) );
                    echo tagcontent('td', $p->stockactual);
                    echo tagcontent('td', number_decimal($price),array('class'=>'number'));
                    echo tagcontent('td', number_decimal($priceiva),array('class'=>'number'));
                    echo tagcontent('td', number_decimal($p->ajuste1),array('class'=>'number'));
                echo Close('tr');
            }
        echo Close('table');
}