/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


$.loadfactview = function() {
    $(document).on('click', '#viewfactbtn', function(e){
        var url = $.trim($(this).attr('data-url')), alto = '99%';        
           $( '#bodycxc' ).jsPanel({
            toolbarHeader: [
                {
                item: '<span class="glyphicon glyphicon-pencil"></span>',
                event: 'click',
                callback: function(){ alert('No implementada ...') }
                },
                {
                item: '<span class="glyphicon glyphicon-print" id="printbtn" data-target="factventaprint"></span>',
                event: 'click'
//                callback: function(){ alert('Nothing to print here ...') }
                }
           ],               
            size: { width: 800, height: 600 },
            theme: 'danger',
            title:    'FACTURA DE VENTA',
            modal: true,
            overflow: 'auto',
            position:  { top: 10, left: 15},
            "theme":         'success',
            controls: { iconfont: 'bootstrap' },
//            controls: { buttons: 'closeonly', iconfont: 'font-awesome' },
            ajax: {
                url: url
            }
            });
//        return false;            
    });
}

$.calcCambioCuotaIndiv = function(){    
    $(document).on('keyup', '#form-cancelarcuotaindiv input[name="totrecibido"]', function(e){
        var totrecibido =  getNumericVal('#form-cancelarcuotaindiv input[name="totrecibido"]','float'),
            totcuota =  getNumericVal('#form-cancelarcuotaindiv input[name="totcuota"]','float'),
            cambio = 0.00;
            
            if(totrecibido < totcuota){ 
                $('#form-cancelarcuotaindiv #valorcambiotxt').removeClass('text-success');
                $('#form-cancelarcuotaindiv #valorcambiotxt').addClass('text-danger');
            }else{
                $('#form-cancelarcuotaindiv #valorcambiotxt').removeClass('text-danger');
                $('#form-cancelarcuotaindiv #valorcambiotxt').addClass('text-success');
            }
            
            cambio = totrecibido - totcuota;
            $('#form-cancelarcuotaindiv #valorcambiotxt').html(cambio.toFixed(numdecimales));
//            $('#form-cancelarcuotaindiv #valorcambio').val(cambio.toFixed(numdecimales));
    });
}

function cxc(){
    $.calcCambioCuotaIndiv();
    $.loadfactview();
    $.loadAjaxPanel();
    $.loadAjaxPanel('#ajaxpanelbtncxcvig');
}