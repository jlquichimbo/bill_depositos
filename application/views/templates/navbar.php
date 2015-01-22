<?php
if(empty($module_title)){
    $module_title = 'Billingsof';
}
    $allcapabilities = $this->user->getAllCapabilities();        

    echo   Open('nav',array('class'=>'navbar navbar-default','role'=>'navigation'));
        echo   Open('div',array('class'=>'navbar-header'));
            echo '<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"> <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span></button> <a class="navbar-brand" href="'.base_url().'"><span style="font-size:34px;font-weight: bold">Billingsof</span></a>';
        echo   closeTag('div');
        
        echo   Open('div',array('class'=>'collapse navbar-collapse','id'=>'bs-example-navbar-collapse-1'));
?>
            <ul class="nav navbar-nav">
                <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-chevron-down font20"></i></a>
                <ul class="dropdown-menu">
                    <?php
                    $cont = 0; $tabclass = ''; 
                    $label = '';
                    foreach ( $allcapabilities as $tab) {                        
                        if($tab->icon != ''){ $label = '<span class="'.$tab->icon.' font30"></span>&nbsp;<span class="font20">'.$tab->label.'</span>'; }else{ $label = $tab->label; }
                        
                        if($tab->tipo == 'module'){
                            $uritab = '';
                            //if ($tab->main){ $tabclass = 'active'; }
                                if($tab->ubicacion != ''){ $uritab = $tab->ubicacion; }
                                if($tab->interno == 1){ $base_path = base_url();
                                }else{ $base_path = ''; }

                            if($tab->acceso == 'noregistered'  && empty($this->user->userid) || !empty($this->user->userid) && $this->user->essuperusuario == 1){
                                echo '<li class="'.$tabclass.'">';
                                    echo '<a href="'.$base_path.$uritab.'" data-toggle="tooltipx" title="<h4>'.$tab->descripcion.'</h4>"/>'.$label.'</a>';
                                echo '</li>';
                            continue;
                            }

                            if( $tab->acceso == 'all' || ($tab->acceso == 'registered' && !empty($this->user->userid)) ){
                                echo '<li class="'.$tabclass.'">';
                                    echo '<a href="'.$base_path.$uritab.'" data-toggle="tooltipx" title="<h4>'.$tab->descripcion.'</h4>"> '.$label.'</a>';
                                echo '</li>';
                            continue;
                            }else{
                                if(!empty($this->user->userid)){
                                    echo '<li class="'.$tabclass.'">';
                                    $assignedrole = $this->user->getAssignedRole($this->user->id);
                                            foreach ($assignedrole as $ut) {
                                                if($ut->capacidad == $tab->capacidad){
                                                    echo '<a href="'.$base_path.$uritab.'" data-toggle="tooltipx" title="<h4>'.$tab->descripcion.'</h4>" > '.$label.' </a>';
                                                    continue;
                                                }
                                            }
                                    echo '</li>';
                                }
                            }
                        }                        
                      $cont++;
                    }                    
                    ?>
                </ul>
                </li>
                <?php
                    echo '<li>';
                        echo '<a id="fullwindowbtn" href="#" data-toggle="tooltip" title="Pantalla Completa"/><i class="glyphicon glyphicon-fullscreen font20"></i></a>';
                    echo '</li>';                
                ?>
                
            </ul>

                <?php
                    if(empty($this->user->userid)){
                        $fields = array( 'a' => array('type'=>'text', 'name' => 'username', 'placeholder'=>'Usuario','class'=>'form-control'), 'b' => array('type'=>'password', 'name' => 'password', 'placeholder' => 'Clave', 'class'=>'form-control'), '1' => array('type'=>'submit', 'value' => 'Ingresar','class'=>'btn btn-success') );
                        echo   Form(base_url('login/verifylogin'), $fields, '', '', '', array('class'=>'navbar-form navbar-right','method'=>'post','enctype'=>'multipart/form-data' ));                            
                    }else{
                        ?>
                        <ul class="nav navbar-nav navbar-right" >
                            <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="glyphicon glyphicon-cog font20"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="#"><?php echo $this->user->username?></a></li>
                                <li><a href="#"><?php echo $this->user->email?></a></li>
                                <li><a href="#"><?php echo $this->user->nombres.' '.$this->user->apellidos?></a></li>
                                <li class="divider"></li>
                                <li><a class="text-danger" href="<?php echo base_url()?>index.php/welcome/logout">Cerrar Sesion&nbsp;<i class="glyphicon glyphicon-off"></i></a></li>
                            </ul>
                            </li>                
                        </ul>               
                        <?php
                    }
                ?>           
        <?php
        echo   closeTag('div'); /*close .collapse navbar-collapse*/
    echo   closeTag('nav');
    
    echo input(array('type'=>'hidden','name'=>'main_path','value'=>  base_url(),'id'=>'main_path'));
    echo input(array('type'=>'hidden','name'=>'numdecimales','value'=>  get_settings('NUMDECIMALES'),'id'=>'numdecimales'));

if(!empty($this->user->ivaporcent)){
    echo input(array('type'=>'hidden','name'=>'ivaporcent','value'=>$this->user->ivaporcent,'id'=>'ivaporcent','labelx'=>'0'));    
}
if(!empty($this->user->userid)){
    echo input(array('type'=>'hidden','name'=>'userid','value'=>$this->user->userid,'id'=>'userid','labelx'=>'0'));
}


/* Mensaje al iniciar el sistema */

echo   Open('div', array('id'=>'msgprocesando','tabindex'=>'-1','role'=>'dialog','aria-labelledby'=>'myModalLabel','aria-hidden'=>'true','style'=>'display: none'));
    echo   Open('div', array('class'=>'modal-content'));
        echo   tagcontent('div', '<h2>Procesando...</h2>', array('class'=>'modal-header'));
        echo   Open('div', array('class'=>'modal-body'));
            echo   Open('div', array('class'=>'progress progress-striped active'));
                echo   tagcontent('div', '<span class="sr-only">100% Complete</span>', array('class'=>'progress-bar','role'=>'progressbar','aria-valuenow'=>'100','aria-valuemin'=>'0','aria-valuemax'=>'100','style'=>'width: 50%'));
            echo   closeTag('div');
        echo   closeTag('div');
    echo   closeTag('div');
echo   closeTag('div');
?>