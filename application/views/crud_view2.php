<?php
//print_r($js_files);
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
        <?php
            $css = array(
                base_url('assets/grocery_crud/themes/datatables/css/demo_table_jui.css'),
                base_url('assets/grocery_crud/themes/datatables/css/datatables.css'),
                base_url('assets/grocery_crud/themes/datatables/css/jquery.dataTables.css'),
                base_url('assets/grocery_crud/themes/datatables/extras/TableTools/media/css/TableTools.css'),
            );
            echo csslink($css);
        ?>
</head>
<body>
	<div style='height:20px;'></div>  
    <div>
		<?php echo $output; ?>
    </div>
<?php
    $js = array(
        base_url('assets/grocery_crud/themes/datatables/js/datatables2.js'),    
    );
    echo jsload($js);  
?>        
</body>
</html>
