<?php
echo  Doctype('html5');
echo  Open('html');
        $head =  tagcontent('title', 'Facturacion');
        
        $css = array(
            base_url('resources/bootstrap-3.2.0/css/bootstrap.min.css'),
            base_url('resources/sb_admin/css/plugins/metisMenu/metisMenu.min.css'),
            base_url('resources/sb_admin/css/sb-admin-2.css'),
            base_url('resources/sb_admin/font-awesome-4.1.0/css/font-awesome.min.css'),    
            base_url('resources/bootstrap-3.2.0/css/bootstrap-theme.css'),
            base_url('resources/bootstrap-3.2.0/css/signin.css'),
        );
        $head .= csslink($css);        
        
        echo  tagcontent('head', $head);
    echo  Open('body',array('class'=>'login_body'));   
    
//        $disc_serie = shell_exec('wmic diskdrive get serialnumber');
//        $out = explode("\n",$disc_serie);
//        $out2 = explode(" ",$out[1]);
//        $disc_serie = $out2[0];
//        $disc_serie_str = '140719JA100A1F2E85VM';
//        if (strcmp($disc_serie, $disc_serie_str) !== 0) {
//            echo '<h2>Debe adquirir una licencia para instalacion del sistema</h2>';
//            die();
//        }
    
$this->load->view('templates/navigation.php');
        echo  Open('div',array('class'=>'container','style'=>'margin-top:20px'));  
            echo  Open('div',array('class'=>'col-md-7'));
                echo tagcontent('span', 'Billingsof te ayuda a la administraci&oacute;n de tu empresa, y a mejorar el rendimiento en cada una de las funciones que desempe&ntilde;as.', array('style'=>'font-size:20px;font-weight:bold'));
                echo LineBreak(2, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-cog','style'=>'font-size:20px;')).  tagcontent('span', '&emsp;Administraci&oacute;n', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-shopping-cart','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Compras', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-usd','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Ventas', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-tasks','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Cotizaciones', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-log-in','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Cuentas x Cobrar', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-log-out','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Cuentas x Pagar', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-book','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Contabilidad', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-stats','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Reportes', array('style'=>'font-size:20px'));
                echo LineBreak(1, array('style'=>'clear:both'));
                echo tagcontent('span', '', array('class'=>'glyphicon glyphicon-plus','style'=>'font-size:20px')).  tagcontent('span', '&emsp;Mucho M&aacute;s..', array('style'=>'font-size:20px'));
            echo  Close('div');

            echo  Open('div',array('class'=>'col-md-5'));  
                $message = $this->session->userdata('message');
                if(!empty($message)){
                    echo tagcontent('strong', $message, array('class'=>'text-danger'));
                    $this->session->unset_userdata('message');            
                }
                echo tagcontent('strong', validation_errors(), array('class'=>'text-danger')); 
                
                echo tagcontent('span', 'Ingreso al Sistema', array('class'=>'login_title1'));
                echo tagcontent('div', 'Ingresa con tu usuario y contrase&ntilde;a', array('class'=>'')).'</br>';
                echo Open('form', array('method'=>'post','action'=> base_url('login/verifylogin') ,'class'=>'form-horizontal col-md-12','role'=>'form','style'=>''));
                    
                        echo Open('div',array('class'=>'form-group'));
                            echo input(array('id'=>"username", 'name'=>"username", 'type'=>"text", 'class'=>"form-control", 'placeholder'=>"Username", 'required'=>'', 'autofocus'=>''));
                        echo Close('div');
                        echo Open('div',array('class'=>'form-group'));
                            echo input(array('id'=>"passowrd", 'name'=>"password", 'type'=>"password", 'class'=>"form-control", 'placeholder'=>"Password", 'required'=>''));
                        echo Close('div');
                    
//                    echo tagcontent('label', 'Ingrese con su usuario y contrase&ntilde;a', array('class'=>'checkbox'));
                        echo Open('div',array('class'=>'form-group'));
                            echo tagcontent('button', 'Ingresar a Billingsof <span class="fa fa-sign-in fa-f5"></span>', array('class'=>'btn btn-lg btn-success'));
                        echo Close('div');                            
                echo  Close('form'); /* container */            
            echo  Close('div');
        echo  Close('div'); /* container */
    echo  Close('body');
echo  Close('html');
