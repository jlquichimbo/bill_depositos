<?php

/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

?>
<style>
    .login_body{
        font-family: "lucida grande",tahoma,verdana,arial,sans-serif;
    }
</style>
    
                <!-- Navigation -->
            <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0; height: 82px">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <!--<a class="navbar-brand" href="<?= base_url() ?>">BILLINGSOF</a>-->
                </div>
                <!-- /.navbar-header -->
                <!--<div class="loggedout_menubar">-->
                <div class="container" style="padding-top:13px">
                    <a class="navbar-brand" href="<?= base_url() ?>" style="font-weight: bold; font-size: 38px">Billingsof</a>
                    
                      <ul class="nav navbar-top-links navbar-right">
                        <!-- /.dropdown -->
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: #026890">
                                Men&uacute;&nbsp;<i class="glyphicon glyphicon-th-list"></i>  <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-alerts">
                                <?php
                            $allcapabilities = $this->user->getAllCapabilities();

                            $cont = 0; $tabclass = ''; 
                            $label = '';
                            foreach ( $allcapabilities as $tab) {                        
                                if($tab->icon != ''){ $label = '<span class="'.$tab->icon.'"></span>&nbsp;<span class="">'.$tab->label.'</span>'; }else{ $label = $tab->label; }

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
                                            echo '<a href="'.$base_path.$uritab.'" data-toggle="tooltipx" title="'.$tab->descripcion.'"> '.$label.'</a>';
                                        echo '</li>';
                                    continue;
                                    }else{
                                        if(!empty($this->user->id)){
                                            echo '<li class="'.$tabclass.'">';
                                                    foreach ($this->user->get_assigned_role() as $ut) {
                                                        if($ut->capacidad == $tab->capacidad){
                                                            echo '<a href="'.$base_path.$uritab.'" data-toggle="tooltipx" title="'.$tab->descripcion.'" > '.$label.' </a>';
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
                            <!-- /.dropdown-alerts -->
                        </li>
                        <!-- /.dropdown -->
                        <li class="dropdown">
                            <a class="dropdown-toggle" data-toggle="dropdown" href="#" style="color: #026890">
                                <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                            </a>
                            <ul class="dropdown-menu dropdown-user">
                                <li><a href="#"><i class="fa fa-user fa-fw"></i> <?=  $this->user->username ?></a>
                                </li>
                                <li><a href="#"><i class="fa fa-gear fa-fw"></i> Configuraci&oacute;n</a>
                                </li>
                                <li class="divider"></li>
                                <li><a href="<?=  base_url('login/welcome/logout') ?>"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
                                </li>
                            </ul>
                            <!-- /.dropdown-user -->
                        </li>
                        <!-- /.dropdown -->
                    </ul>
                    <!-- /.navbar-top-links -->                    
                    
                </div>
                <!-- /.navbar-top-links -->
            </nav>

