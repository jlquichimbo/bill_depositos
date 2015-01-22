<?php
//print_r($js_files);
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8" />
        <?php
            $css = array(
                '//localhost/billingsofv1/coresystem/assets/grocery_crud/themes/flexigrid/css/flexigrid.css?id=87e68'
            );
            echo csslink($css);
        ?>
</head>
<body>
	<div style='height:20px;'></div>  
    <div>
		<?php echo $output; ?>
    </div>
</body>
</html>
