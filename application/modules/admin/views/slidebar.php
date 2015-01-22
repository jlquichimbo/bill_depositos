<div class="navbar-defaults sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                            <div class="input-group custom-search-form">
                                <input type="text" class="form-control" placeholder="Search...">
                                <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                    <i class="fa fa-search"></i>
                                </button>
                            </span>
                            </div>
                            <!-- /input-group -->
                        </li>
                        
                        <li>
                            <a class="active" href="<?= base_url('admin/monitoreo/index')?>"><i class="fa fa-dashboard fa-fw"></i> Monitoreo</a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i> Producto<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="<?= base_url('admin/index')?>"><i class="glyphicon glyphicon-plus"></i> Nuevo Productos</a>
                                </li>
                                <li>
                                    <a href="<?= base_url('admin/product/searchview')?>"><i class="glyphicon glyphicon-pencil"></i> Buscar Productos</a>
                                </li>
                                <li>
                                    <a href="<?= base_url('admin/product/productsloadview')?>"><i class="glyphicon glyphicon-asterisk"></i> Subir desde Archivo</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/grupos'?>"><i class="glyphicon glyphicon-asterisk"></i> Grupos y Precios</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>                        
                        
                        <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i> Retenciones<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="<?= base_url('admin/retencion')?>"><i class="fa fa-dashboard fa-fw"></i> Reporte Retenciones</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/retencionconf'?>">Conf. Retencion SRI</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>                        
                        
                        <li>
                            <a href="#"><i class="fa fa-wrench fa-fw"></i> Empresa<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="<?= base_url().'admin/empresa/index'?>">Datos Empresa</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/bodegas'?>">Bodegas</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/empleados'?>">Usuarios y Cargos</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/centroscosto'?>">Centros Costo.</a>
                                </li>
                                <li>
                                    <a href="<?= base_url().'admin/puntoventaempl'?>">Puntos Venta</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>                        
                        
                        <li>
                            <a href="<?= base_url('inventario/index')?>">Inventario</a>
                            <a href="<?= base_url().'admin/clientetipo'?>">Tipos Cliente</a>              
                            <a href="<?= base_url().'admin/proveedor/view'?>">Proveedores</a>

                        </li>                        
                        
                        <li>
                            <a href="#"><i class="fa fa-bar-chart-o fa-fw"></i> Cuentas Contables<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
                                <li>
                                    <a href="<?= base_url().'admin/contaconfigcuentas'?>">Config. Cuentas</a>
                                    <a href="<?= base_url().'admin/tipopago'?>">Config. Tipos Pago</a>
                                    <a href="<?= base_url().'admin/contacuentasplan'?>">Plan de Cuentas</a>
                                </li>
                            </ul>
                            <!-- /.nav-second-level -->
                        </li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->