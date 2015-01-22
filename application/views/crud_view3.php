<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
        <?php
            $css = array(
                '//localhost/billingsofv1/coresystem/assets/grocery_crud/themes/flexigrid/css/flexigrid.css?id=87e68'
            );
            echo csslink($css);
            
$js = array(
    base_url('assets/grocery_crud/themes/flexigrid/js/flexigrid.js'),
    base_url('assets/grocery_crud/themes/flexigrid/js/jquery.form.js'),  
    base_url('resources/js/libs/jsPanel/source/AC_RunActiveContent.js'),  
    base_url('resources/js/libs/jsPanel-bootstrap/source/jquery.jspanel.bs-1.4.0.min.js'),  
);
echo jsload($js);            
        ?>  
        
   
</head>
<body>
	<div style='height:20px;'></div>  
    <div>
		<?php echo $output; ?>
    </div>
</body>
</html>
