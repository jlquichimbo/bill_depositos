/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

    var load_supplier = function (datum) {
        var url = main_path+'ajustesalida/index/findByCI';
            $.ajax({
                type: "POST",
                url: url,
                data: { ci: datum.ci,id: datum.id },       
                success: function(html){
                    $('#cotizacionescart').html(html);                    
                },
                error: function(){
                    alertaError("Error!! No se pudo alcanzar el archivo de proceso", "Error!!");
                }              
            });        
    };
    
    $(function() {
//        $.load_autosugest('#supplier_name', load_supplier, 4, 10);        
        printelem();
        $.loadAjaxPanel();
        loadFormAjax();   
        $.load_datepicker();
        $.loadAjaxPanel('#loadproductsviewbtn',{ width: '99%', height: 300 },{top: 35, left: 5});
        $.loadAjaxPanel('#loadsearchprovbtn', { width: '99%', height: 300 }, {bottom: 0, left: 5});            
        
        $(document).on("mousedown", "input.number", function(e) {
            $(".number").numeric();
        });
        $(document).on("mousedown", "input.integer", function(e) {
            $(".integer").numeric(false, function() {this.value = "1";this.focus();});
        });
        $(document).on("mousedown", "input.positive", function(e) {
            $(".positive").numeric({negative: false}, function() {this.value = "";this.focus();});
        });
        $(document).on("mousedown", "input.positive-integer", function(e) {
            $(".positive-integer").numeric({decimal: false, negative: false}, function() {this.value = "";this.focus();});
        });              
    });