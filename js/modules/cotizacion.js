/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* Cuando se cambia el valor de porcentaje en recargos */
function recdescporcent(elemevent,elempush){
   $(document).on("keyup", elemevent, function(e) {
        $(this).prev('span').children('button').removeAttr('disabled').removeClass('btn-default').addClass('btn-success');        
        var subtotal_bruto = getNumericVal('#subtotal_bruto','float'),
            recporcent = getNumericVal(elemevent,'float'),
            recval = (subtotal_bruto * recporcent) /100;
        $(elempush).val(recval.toFixed(numdecimales));
   });
}
/* Cuando se cambia el valor de porcentaje en recargos */
function recdescval(elemevent,elempush){
   $(document).on("keyup", elemevent, function(e) {
        $(this).prev('span').children('button').removeAttr('disabled').removeClass('btn-default').addClass('btn-success');        
        var subtotal_bruto = getNumericVal('#subtotal_bruto','float'),
            recval = getNumericVal(elemevent,'float'),
            recporcent = parseFloat((recval * 100)/subtotal_bruto);
        $(elempush).val(recporcent.toFixed(numdecimales));       
   });
}

/* evita que se suban los formularios al dar enter en una caja de texto */
function preventSubmitForms(){
   $(document).on("keyup", elemevent, function(e) {
      
   });
}

function cotizacion(){
    recdescporcent("#recporcent",'#recval');
    recdescporcent("#desdporcent",'#descval');
    
    recdescval('#recval',"#recporcent");
    recdescval('#descval',"#desdporcent");
    
    $.loadAjaxPanel('#loadproductsviewbtn',{ width: '60%', height: 300 },{top: 35, left: 5});
}