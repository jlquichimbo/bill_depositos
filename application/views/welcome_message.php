<?php
//print_r($this->session->all_userdata());
echo  Doctype('html5');
echo  Open('html');
        $head =  tagcontent('title', 'Facturacion');
        $cssarray = array( 
            base_url('resources/bootstrap-3.2.0/css/bootstrap.min.css'),
            base_url('resources/bootstrap-3.2.0/css/bootstrap-theme.css'),
            base_url('resources/css/style.css'),
            base_url('resources/sb_admin/css/plugins/metisMenu/metisMenu.min.css'),
            base_url('resources/sb_admin/css/sb-admin-2.css'),
            base_url('resources/sb_admin/font-awesome-4.1.0/css/font-awesome.min.css')            
        );
        $head .=  csslink($cssarray);    
        echo  tagcontent('head', $head);
    echo  Open('body',array('class'=>'')); 

    $this->load->view('login/templates/navigation');
    
    echo  Open('div', array('class'=>'container','style'=>'margin-top:15px'));
        $base_path = base_url();
        $activemodule = 0;
        $allcapabilities = $this->user->getAllCapabilities(); 
        foreach ( $allcapabilities as $tab) {
            /* Solo cuando son modulos, ya que tambien pueden ser cargos(permisos)*/
            if($tab->tipo == 'module'){
                $uritab = '';
                    if($tab->ubicacion != ''){ $uritab = $tab->ubicacion; }
                    if($tab->interno == 1){ $base_path = base_url();
                    }else{ $base_path = ''; }
                    
                if($tab->acceso == 'noregistered'  && empty($this->user->userid) || !empty($this->user->userid) && $this->user->essuperusuario == 1){                                                            
                    $activemodule = 1;
                    echo get_item_view('', base_url().$tab->ubicacion, '<span style="font-size:20px">'.$tab->capacidadview.'<span>', $tab->descripcion, $tab->icon.' fa-5x', 'panel panel-primary');
                continue;
                }elseif( $tab->acceso == 'all' || ($tab->acceso == 'registered' && !empty($this->user->userid)) ){
                    $activemodule = 1;
                    echo get_item_view('', base_url().$tab->ubicacion, '<span style="font-size:20px">'.$tab->capacidadview.'<span>', $tab->descripcion, $tab->icon.' fa-5x', 'panel panel-green');
                continue;
                }elseif(!empty($this->user->userid)){ // enrolled
//                    echo 'Paso x aqui';
                    $cap = $tab->capacidad;
                        if($this->session->userdata($cap)){
                            echo get_item_view('', base_url().$tab->ubicacion, '<span style="font-size:20px">'.$tab->capacidadview.'<span>', $tab->descripcion, $tab->icon.' fa-5x', 'panel panel-green');
                        continue;
                        }
                }
               if($activemodule == 0){
//                   echo portafolio($tab, '#','<h4>No tiene permisos para acceder a esta modulo</h4>','btn-off');
                   echo get_item_view('', '#', '<span style="font-size:20px">'.$tab->capacidadview.'<span>', $tab->descripcion, $tab->icon.' fa-5x', 'panel panel-default');
               }
            }
//print_r($this->session->all_userdata());
        }    
    echo  closeTag('div');
    
        $jsarray = array(
            base_url('resources/jquery.js'),            
            base_url('resources/bootstrap-3.2.0/js/bootstrap.min.js')
        );
        echo  jsload($jsarray);
        
    echo  closeTag('body');
echo  closeTag('html');


function portafolio($tab, $link, $title='',$class='btn-on'){
    $output = ''; $icon = '';

    if($tab->icon != ''){ 
        $icon = '<span class="'.$tab->icon.' font48 color-red"></span>'; 
    }else{ 
        $icon = '<img style="width:70%" class="img-responsive" src="'.base_url().'/img/icons96px/'.$tab->imagen.'">';
    }
    $output .= '<div style="height:220px; overflow:hidden" class=" '.$class.' col-md-3 text-center">';
        $output .= '<a href="'.$link.'">'.$icon.'</a>';
        $output .= '<h3><a data-toggle="tooltip" title="'.$title.'" href="'.$link.'" style="color:#000">'.$tab->capacidadview.'</a>';
        $output .= '</h3>';
        $output .= '<p>'.$tab->descripcion.'</p>';
    $output .= '</div>';
    return $output;
}