<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
<?php 
//print_r($css_files);
//print_r($js_files);

//$css = array(
//    base_url().'assets/grocery_crud/themes/datatables/css/demo_table_jui.css',
//    base_url().'assets/grocery_crud/themes/datatables/css/datatables.css',
//    base_url().'assets/grocery_crud/themes/datatables/css/jquery.dataTables.css',
//    base_url().'assets/grocery_crud/themes/datatables/extras/TableTools/media/css/TableTools.css'
//);
//echo csslink($css);

            
           
?>
</head>
<body>
	<div style='height:20px;'></div>  
    <div>
		<?php echo $output; ?>
    </div>
</body>

<?php
    $js = array(
         base_url('assets/grocery_crud/themes/datatables/js/datatables.js'),
         base_url('assets/grocery_crud/js/jquery_plugins/jquery.easing-1.3.pack.js'),   
         base_url('resources/js/libs/jsPanel/source/AC_RunActiveContent.js'),
         base_url('resources/js/libs/jsPanel-bootstrap/source/jquery.jspanel.bs-1.4.0.min.js'),
    );
    echo jsload($js);  
?>
</html>
<script>
//    $.load_datepicker();
</script>
