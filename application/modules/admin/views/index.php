<?php
$css = array(
    base_url('resources/bootstrap-3.2.0/css/bootstrap.min.css'),
    base_url('resources/bootstrap-3.2.0/css/bootstrap-theme.css'),
    base_url('resources/bootstrap-3.2.0/css/dashboard.css'),
    base_url('resources/js/libs/combobox/css/bootstrap-combobox.css'),
       
    base_url('assets/grocery_crud/css/ui/simple/jquery-ui-1.10.1.custom.min.css'),   
    base_url('assets/grocery_crud/themes/datatables/css/demo_table_jui.css'),
    base_url('assets/grocery_crud/themes/datatables/css/datatables.css'),
    base_url('assets/grocery_crud/themes/datatables/css/jquery.dataTables.css'),
    base_url('assets/grocery_crud/themes/datatables/extras/TableTools/media/css/TableTools.css'),
    
    base_url('resources/css/datepicker.css'),
    base_url('resources/js/libs/sco.js/css/scojs.css'),
    base_url('resources/js/libs/sco.js/css/sco.message.css'),
    base_url('resources/js/libs/jsPanel-bootstrap/source/jsPanel.css'),
    base_url('resources/js/libs/autosuggest/css/style.css')
);
echo csslink($css);

$js = array(
    base_url('assets/grocery_crud/js/jquery-1.10.2.min.js'),
    base_url().'assets/grocery_crud/js/jquery_plugins/jquery.noty.js',
    base_url().'assets/grocery_crud/js/jquery_plugins/config/jquery.noty.config.js',
    base_url().'assets/grocery_crud/js/common/lazyload-min.js',
    base_url().'assets/grocery_crud/js/common/list.js',
    base_url().'assets/grocery_crud/themes/datatables/js/jquery.dataTables.min.js',
    base_url().'assets/grocery_crud/themes/datatables/js/datatables-extras.js',
    base_url().'assets/grocery_crud/themes/datatables/extras/TableTools/media/js/ZeroClipboard.js',
    base_url().'assets/grocery_crud/themes/datatables/extras/TableTools/media/js/TableTools.min.js',
    base_url().'assets/grocery_crud/js/jquery_plugins/ui/jquery-ui-1.10.3.custom.min.js',
    
    base_url().'resources/bootstrap-3.2.0/js/bootstrap.min.js',
    base_url('resources/js/libs/sco.js/js/sco.valid.js'),
    base_url('resources/js/libs/sco.js/js/sco.modal.js'),
    base_url('resources/js/libs/sco.js/js/sco.message.js'),
    base_url('resources/js/libs/sco.js/js/sco.ajax.js'),
    base_url('resources/js/libs/jform/jquery.form.js'),
    base_url('resources/js/bootstrap-datepicker.js'),
    base_url('resources/js/bootstrap-datepicker.es.js'),
    base_url('resources/js/libs/autosuggest/bootstrap-typeahead.js'),
    base_url('resources/js/libs/autosuggest/hogan-2.0.0.js'),
    base_url('resources/js/libs/jsPanel/source/AC_RunActiveContent.js'),
    base_url('resources/js/libs/jsPanel-bootstrap/source/jquery.jspanel.bs-1.4.0.min.js'),
    base_url('resources/js/libs/combobox/js/bootstrap-combobox.js'),
    base_url('resources/js/modules/comunes.js'), 
);
echo jsload($js);

$this->load->view('admin/templates/header.php');

echo Open('div', array('class'=>'row'));

    $this->load->view('admin/templates/slidebar.php');
    
    echo Open('div', array('class'=>'col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main'));   
           
           ?>
            <div class="row placeholders">
                <a class="col-xs-6 col-sm-4 placeholder" href="<?php echo base_url().'admin/index'?>">
                    <span class="glyphicon glyphicon-plus text-success" style="font-size: 58px;"> </span>
                <h4>Nuevo Producto</h4>
                <span class="text-muted">Nuevo Producto</span>
                </a>
                
                <a class="col-xs-6 col-sm-4 placeholder" href="<?php echo base_url().'admin/product/searchview'?>">
                    <span class="glyphicon glyphicon-search text-success" style="font-size: 58px;"> </span>
                <h4>Buscar Producto</h4>
                <span class="text-muted">Buscar Producto</span>
                </a>

                <a class="col-xs-6 col-sm-4 placeholder" href="<?php echo base_url().'admin/product/productsloadview'?>">
                    <span class="glyphicon glyphicon-upload text-success" style="font-size: 58px;"> </span>
                <h4>Subir desde Archivo</h4>
                <span class="text-muted">Subir desde Archivo</span>
                </a>
            </div>
                        
    <div id="cxcpaneloutput">
         <?php
           echo $view;
//                $this->load->view('product');
         ?>
    </div>

<script>    
    $(function() {
        loadFormAjax();   
        $.loadAjaxPanel('#ajaxpanelbtnproductget',{ width: '98%', height: 450 }, {top: 150, left: 10});
    });

</script>
    <?php


    echo Close('div'); //cierra div .col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main    
echo Close('div'); //cierra div .row