<?php 

	$column_width = (int)(80/count($columns));
//	print_r($list);
	if(!empty($list)){
?><div class="bDiv" >
		<table cellspacing="0" cellpadding="0" border="0" id="flex1">
		<thead>
			<tr class='hDiv'>
				<?php foreach($columns as $column){?>
				<th width='<?php echo $column_width?>%'>
					<div class="text-left field-sorting <?php if(isset($order_by[0]) &&  $column->field_name == $order_by[0]){?><?php echo $order_by[1]?><?php }?>" 
						rel='<?php echo $column->field_name?>'>
						<?php echo $column->display_as?>
					</div>
				</th>
				<?php }?>
				<?php if(!$unset_delete || !$unset_edit || !$unset_read || !empty($actions)){?>
				<th align="left" abbr="tools" axis="col1" class="" width='20%'>
					<div class="text-right">
						<?php echo $this->l('list_actions'); ?>
					</div>
				</th>
				<?php }?>
			</tr>
		</thead>		
		<tbody>
<?php 
//$sum_stock = 0;
//$sum_costo_prom = 0;
//$sum_costo_ult = 0;
$sumatoria = array();
foreach($list as $num_row => $row){
//    $sum_stock += $row->stockactual;
//    $sum_costo_prom += $row->costopromediokardex;
//    $sum_costo_ult += $row->costoultimokardex;
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
		<tr  <?php if($num_row % 2 == 1){?>class="erow"<?php }?>>
			<?php foreach($columns as $column){                            
                                    $texttype = 'text-left'; //para texto, by esteban chamba
                                    if( is_numeric($row->{$column->field_name}) ){
//                                        $valcolumn += $row->{$column->field_name};
//                                        echo $column->field_name .' = '.$valcolumn;
                                        $texttype = 'text-right';
                                    }
                            ?>
			<td width='<?php echo $column_width?>%' class='<?php if(isset($order_by[0]) &&  $column->field_name == $order_by[0]){?>sorted<?php }?>'>
				<div class='<?php echo $texttype?>'><?php echo $row->{$column->field_name} != '' ? $row->{$column->field_name} : '&nbsp;' ; ?></div>
			</td>
			<?php }?>
			<?php if(!$unset_delete || !$unset_edit || !$unset_read || !empty($actions)){?>
			<td align="left" width='20%'>
				<div class='tools'>				
					<?php if(!$unset_delete){?>
                    	<a href='<?php echo $row->delete_url?>' title='<?php echo $this->l('list_delete')?> <?php echo $subject?>' class="delete-row" >
                    			<span class='delete-icon'></span>
                    	</a>
                    <?php }?>
                    <?php if(!$unset_edit){?>
						<a href='<?php echo $row->edit_url?>' title='<?php echo $this->l('list_edit')?> <?php echo $subject?>' class="edit_button"><span class='edit-icon'></span></a>
					<?php }?>
					<?php if(!$unset_read){?>
						<a href='<?php echo $row->read_url?>' title='<?php echo $this->l('list_view')?> <?php echo $subject?>' class="edit_button"><span class='read-icon'></span></a>
					<?php }?>
					<?php 
					if(!empty($row->action_urls)){
						foreach($row->action_urls as $action_unique_id => $action_url){ 
							$action = $actions[$action_unique_id];
					?>
							<a href="<?php echo $action_url; ?>" class="<?php echo $action->css_class; ?> crud-action" title="<?php echo $action->label?>"><?php 
								if(!empty($action->image_url))
								{
									?><img src="<?php echo $action->image_url; ?>" alt="<?php echo $action->label?>" /><?php 	
								}
							?></a>		
					<?php }
					}
					?>					
                    <div class='clear'></div>
				</div>
			</td>
			<?php }?>
                        <!--<td><?php // echo $valcolumn ?></td>-->
		</tr>
<?php 
}
//print_r($columns);
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
                echo '</tr>';

                ?>
		</tbody>
		</table>
	</div>
<?php }else{?>
	<br/>
	&nbsp;&nbsp;&nbsp;&nbsp; <?php echo $this->l('list_no_items'); ?>
	<br/>
	<br/>
<?php }?>	
