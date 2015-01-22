<?php
//if(!$list){
//    echo '<strong class="text-info" style="font-size:30px"><span class="glyphicon glyphicon-info-sign"></span> No se encontraron resultados para su b&uacute;squeda..</strong>';
//    exit(0);
//}
?>
<div class="table-responsive" style="overflow-x: scroll">
    <table cellpadding="0" cellspacing="0" border="0" class="display groceryCrudTable" id="<?php echo uniqid(); ?>">
            <thead>
                    <tr>
                            <?php foreach($columns as $column){?>
                                    <th><?php echo $column->display_as; ?></th>
                            <?php }?>
                            <?php if(!$unset_delete || !$unset_edit || !$unset_read || !empty($actions)){?>
                            <th class='actions'><?php echo $this->l('list_actions'); ?></th>
                            <?php }?>
                    </tr>
            </thead>
            <tbody>
                    <?php 
                    $sumatoria = array();
                    foreach($list as $num_row => $row){ 
                        $valcolumn = 0;    
                        foreach($columns as $column){
                            if( is_numeric($row->{$column->field_name}) ){
                                $valcolumn = $row->{$column->field_name};
                    //          echo $column->field_name .' = '.$valcolumn;
                                if( empty($sumatoria[$column->field_name]) ){
                                    $sumatoria[$column->field_name] = 0;
                                }

                                $sumatoria[$column->field_name] = $sumatoria[$column->field_name] + $valcolumn;
                            }
                        }                    
                    ?>
                    <tr id='row-<?php echo $num_row?>'>
                            <?php foreach($columns as $column){
                                $texttype = 'text-left'; //para texto, by esteban chamba
                                if( is_numeric($row->{$column->field_name}) ){                                        
                                    $texttype = 'text-right';
                                }
                                ?>
                                <td class="<?php echo $texttype?>"><?php echo $row->{$column->field_name}?></td>
                            <?php }?>
                            <?php if(!$unset_delete || !$unset_edit || !$unset_read || !empty($actions)){?>
                            <td class='actions'>
                                    <?php
                                    if(!empty($row->action_urls)){
                                            foreach($row->action_urls as $action_unique_id => $action_url){
                                                    $action = $actions[$action_unique_id];
                                    ?>
                                                    <a href="<?php echo $action_url; ?>" class="edit_button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">
                                                            <span class="ui-button-icon-primary ui-icon <?php echo $action->css_class; ?> <?php echo $action_unique_id;?>"></span><span class="ui-button-text">&nbsp;<?php echo $action->label?></span>
                                                    </a>
                                    <?php }
                                    }
                                    ?>
                                    <?php if(!$unset_read){?>
    <!--					<a href="<?php // echo $row->read_url?>" class="edit_button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">
                                                    <span class="ui-button-icon-primary ui-icon ui-icon-document"></span>
                                                    <span class="ui-button-text">&nbsp;<?php // echo $this->l('list_view'); ?></span>
                                            </a>-->
                                            <a href="<?php echo $row->read_url?>" class="edit_button" role="button">
                                                    <span class="glyphicon glyphicon-file"></span>
                                            </a>
                                    <?php }?>

                                    <?php if(!$unset_edit){?>
    <!--					<a href="<?php // echo $row->edit_url?>" class="edit_button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">
                                                    <span class="ui-button-icon-primary ui-icon ui-icon-pencil"></span>
                                                    <span class="ui-button-text">&nbsp;<?php // echo $this->l('list_edit'); ?></span>
                                            </a>-->
                                            <a href="<?php echo $row->edit_url?>" class="edit_button" role="button">
                                                <span class="glyphicon glyphicon-pencil"></span>
                                            </a>
                                    <?php }?>
                                    <?php if(!$unset_delete){?>
    <!--					<a onclick = "javascript: return delete_row('<?php // echo $row->delete_url?>', '<?php // echo $num_row?>')"
                                                    href="javascript:void(0)" class="delete_button ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary" role="button">
                                                    <span class="ui-button-icon-primary ui-icon ui-icon-circle-minus"></span>
                                                    <span class="ui-button-text">&nbsp;<?php // echo $this->l('list_delete'); ?></span>
                                            </a>-->
                                            <a onclick = "javascript: return delete_row('<?php echo $row->delete_url?>', '<?php echo $num_row?>')"
                                                    href="javascript:void(0)" class="delete_button" role="button">
                                                    <span class="glyphicon glyphicon-trash"></span>
                                            </a>
                                    <?php }?>
                            </td>
                            <?php }?>
                    </tr>
                    <?php }

                    if($list){
                        echo '<tr style="background: #F65D20; font-size: 20px; font-weight: bold">';
                           foreach($columns as $column){
                               $keys   =   array_keys($sumatoria);
                               $val_row = '&nbsp;';
                               $cont = 0;
                               foreach ($keys as $k) {
                                   if($column->field_name == $k){
                                       $val_row = $sumatoria[$column->field_name];
                                       ?>
                                       <td width='' class=''>
                                               <div class='text-right'><?php echo $val_row ?></div>
                                       </td>
                                       <?php
                                       break;  
                                   }else{ $cont ++;
                                       if(count($keys) == $cont){
                                           echo '<td>&nbsp;--</td>';
                                           break;
                                       }                            
                                   }                            

                               }                                              
                           }
                           if(!$unset_delete OR !$unset_edit OR !$unset_read){
                               echo '<td>&nbsp;</td>';  
                           }
                       echo '</tr>';                        
                    }
                    ?>
            </tbody>
            <tfoot>
                    <tr>
                            <?php foreach($columns as $column){?>
                                    <th><input type="text" name="<?php echo $column->field_name; ?>" placeholder="<?php echo $this->l('list_search').' '.$column->display_as; ?>" class="search_<?php echo $column->field_name; ?>" /></th>
                            <?php }?>
                            <?php if(!$unset_delete || !$unset_edit || !$unset_read || !empty($actions)){?>
                                    <th>
                                            <button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-icon-only floatR refresh-data" role="button" data-url="<?php echo $ajax_list_url; ?>">
                                                    <span class="ui-button-icon-primary ui-icon ui-icon-refresh"></span><span class="ui-button-text">&nbsp;</span>
                                            </button>
                                            <a href="javascript:void(0)" role="button" class="clear-filtering ui-button ui-widget ui-state-default ui-corner-all ui-button-text-icon-primary floatR">
                                                    <span class="ui-button-icon-primary ui-icon ui-icon-arrowrefresh-1-e"></span>
                                                    <span class="ui-button-text"><?php echo $this->l('list_clear_filtering');?></span>
                                            </a>
                                    </th>
                            <?php }?>
                    </tr>
            </tfoot>
    </table>
</div>    
