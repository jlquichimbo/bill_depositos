<?php // Change the css classes to suit your needs    
$groupinp = combobox($prodgroups, array('label'=>'nombre','value'=>'codigo'), array('class'=>'form-control','name'=>'productogrupo_codigo','id'=>'productogrupo_codigo'), false, $products->productogrupo_codigo);

$prodtiposopt = ''; 
foreach ($prodtipos as $t) {    
    if( $products->productotipo_id == $t->id ){
        $prodtiposopt .= tagcontent('option', $t->nombre, array('value'=>$t->id,'selected'=>'selected'));
        continue;
    }
    $prodtiposopt .= tagcontent('option', $t->nombre, array('value'=>$t->id)); 
}
$tiposinp = tagcontent('select', $prodtiposopt, array('class'=>'form-control','name'=>'productotipo_id','id'=>'productotipo_id'));

$marcasopt = ''; 
foreach ($marca as $t) {    
    if( $products->marca_id == $t->id ){
        $prodtiposopt .= tagcontent('option', $t->nombre, array('value'=>$t->id,'selected'=>'selected'));
        continue;
    }
    $marcasopt .= tagcontent('option', $t->nombre, array('value'=>$t->id)); 
}
$marcasinp = tagcontent('select', $marcasopt, array('class'=>'comboboxeditprod form-control','name'=>'marca_id','id'=>'marca_id'));

echo Open('form', array('class'=>'form-horizontal','method'=>'post','action'=>base_url().'admin/product/edit'));
echo Open('div',array('class'=>'col-md-12'));
    echo input(array('type'=>'hidden','name'=>'id','value'=>$products->codigo));
    $label = tagcontent('label', 'Nombre', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'nombreUnico','id'=>'nombreUnico','value'=>$products->nombreUnico,'maxlength'=>'256','class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

    $label = tagcontent('label', 'Descripcion', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'descripcion','id'=>'descripcion','value'=>$products->descripcion,'class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

    $label = tagcontent('label', 'Grupo:', array('class'=>'col-md-3')); 
    $input = tagcontent('div', $groupinp, array('class'=>'col-md-9'));    
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

    $label = tagcontent('label', 'Tipo:', array('class'=>'col-md-3')); 
    $input = tagcontent('div', $tiposinp, array('class'=>'col-md-9'));    
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

    $label = tagcontent('label', 'Marca:', array('class'=>'col-md-3')); 
    $input = tagcontent('div', $marcasinp, array('class'=>'col-md-9'));    
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
    
    $label = tagcontent('label', 'Cod.Comun', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'codigo2','value'=>$products->codigo2,'id'=>'codigo2','class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
    $label = tagcontent('label', 'Cod.Barras1', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'codbarras1','value'=>$products->codbarras1,'id'=>'codbarras1','class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
    $label = tagcontent('label', 'Cod.Barras2', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'codbarras2','value'=>$products->codbarras2,'id'=>'codbarras2','class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
    $label = tagcontent('label', 'Cod.Barras3', array('class'=>'col-md-3'));
    $input = tagcontent('div', input(array('name'=>'codbarras3','value'=>$products->codbarras3,'id'=>'codbarras3','class'=>'form-control')), array('class'=>'col-md-9'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
        
    $label = tagcontent('label', 'Stock Min', array('class'=>'col-md-6'));
    $input = tagcontent('div', input(array('name'=>'existenciaMinima','value'=>'1','id'=>'existenciaMinima','maxlength'=>'2','class'=>'form-control positive')), array('class'=>'col-md-6'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

    $label = tagcontent('label', 'Stock Max', array('class'=>'col-md-6'));
    $input = tagcontent('div', input(array('name'=>'existenciaMaxima','value'=>'100','id'=>'existenciaMaxima','maxlength'=>'3','class'=>'form-control positive')), array('class'=>'col-md-6'));
    echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));
echo Close('div');    
echo Open('div',array('class'=>'col-md-12'));    
    foreach ($impuestostarif as $i) {
        $res = $this->prodimpuestotarif_model->find($products->codigo, $i->id);
        if($res > 0){
            $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','checked'=>'checked','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
            echo tagcontent('div', $check, array('class'=>'checkbox'));            
            continue;            
        }
        $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
        echo tagcontent('div', $check, array('class'=>'checkbox'));
    }
echo Close('div');    

    echo input(array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'editprodout','value'=>'Modificar Producto','class'=>'btn btn-primary pull-right','style'=>'margin-right:10px'));
echo Close('form');
echo tagcontent('div', '', array('id'=>'editprodout'));

//echo tagcontent('script', "$('.comboboxeditprod').combobox()");