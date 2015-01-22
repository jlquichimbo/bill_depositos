<?php // Change the css classes to suit your needs    

//echo get_item_view('Nuevo', base_url('admin/index'), 'Nuevo Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-green');
//echo get_item_view('Buscar', base_url('admin/product/searchview'), 'Buscar Producto!', 'Crear Nuevo Producto','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Subir', base_url('admin/product/productsloadview'), 'Subri Pproductos!', 'Subir desde Archivo','fa fa-shopping-cart fa-5x', 'panel panel-primary');
//echo get_item_view('Grupos', base_url('admin/grupos'), 'Grupo Pproductos!', 'Revisar Grupos','fa fa-shopping-cart fa-5x', 'panel panel-primary');
            
echo Open('div', array('class'=>'container-fluid'));

    $groupinp = combobox($prodgroups, array('label'=>'nombre','value'=>'codigo'), array('class'=>'comboboxnewprod form-control','name'=>'productogrupo_codigo','id'=>'productogrupo_codigo'), FALSE, 1);
    $tiposinp = combobox($prodtipos, array('label'=>'nombre','value'=>'id'), array('class'=>'form-control','name'=>'productotipo_id','id'=>'productotipo_id'), false, 1);
    $marcasinp = combobox($marca, array('label'=>'nombre','value'=>'id'), array('class'=>'comboboxnewprod form-control','name'=>'marca_id','id'=>'marca_id'), false, 1);
    
    echo Open('form', array('class'=>'form-horizontal','method'=>'post','action'=>base_url().'admin/product/save'));
        $label = tagcontent('label', 'Nombre', array('class'=>'col-md-3'));
        $input = tagcontent('div', input(array('name'=>'nombreUnico','style'=>'text-transform:uppercase','id'=>'nombreUnico','maxlength'=>'256','class'=>'form-control')), array('class'=>'col-md-9'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

        $label = tagcontent('label', 'Descripcion', array('class'=>'col-md-3'));
        $input = tagcontent('div', input(array('name'=>'descripcion','id'=>'descripcion','class'=>'form-control')), array('class'=>'col-md-9'));
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
        $input = tagcontent('div', input(array('name'=>'codigo2','id'=>'codigo2','class'=>'form-control')), array('class'=>'col-md-9'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
        $label = tagcontent('label', 'Cod.Barras1', array('class'=>'col-md-3'));
        $input = tagcontent('div', input(array('name'=>'codbarras1','id'=>'codbarras1','class'=>'form-control')), array('class'=>'col-md-9'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
        $label = tagcontent('label', 'Cod.Barras2', array('class'=>'col-md-3'));
        $input = tagcontent('div', input(array('name'=>'codbarras2','id'=>'codbarras2','class'=>'form-control')), array('class'=>'col-md-9'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));
        $label = tagcontent('label', 'Cod.Barras3', array('class'=>'col-md-3'));
        $input = tagcontent('div', input(array('name'=>'codbarras3','id'=>'codbarras3','class'=>'form-control')), array('class'=>'col-md-9'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-6 form-group'));

        $label = tagcontent('label', 'Stock Min', array('class'=>'col-md-6'));
        $input = tagcontent('div', input(array('name'=>'existenciaMinima','value'=>'1','id'=>'existenciaMinima','maxlength'=>'2','class'=>'form-control positive')), array('class'=>'col-md-6'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

        $label = tagcontent('label', 'Stock Max', array('class'=>'col-md-6'));
        $input = tagcontent('div', input(array('name'=>'existenciaMaxima','value'=>'100','id'=>'existenciaMaxima','maxlength'=>'3','class'=>'form-control positive')), array('class'=>'col-md-6'));
        echo tagcontent('div', $label.$input, array('class'=>'col-md-3 form-group'));

        echo lineBreak2(1, array('class'=>'clr'));

        foreach ($impuestostarif as $i) {
            if($i->id == 2){
                $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','checked'=>'checked','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
                echo tagcontent('div', $check, array('class'=>''));            
                continue;
            }
                $check = tagcontent('label', input(array('type'=>'checkbox','name'=>'impuestotarif[]','value'=>$i->id)).$i->descripcion.' '.$i->tarporcent.'%');
            echo tagcontent('div', $check, array('class'=>''));
        }

        echo input(array('type'=>'submit','id'=>'ajaxformbtn','data-target'=>'newprodout','value'=>'Crear Producto','class'=>'btn btn-primary pull-right','style'=>'margin-right:10px'));
    echo Close('form');
    echo tagcontent('div', '', array('id'=>'newprodout'));

    echo tagcontent('script', "$('.comboboxnewprod').combobox()");
echo Close('div');    
