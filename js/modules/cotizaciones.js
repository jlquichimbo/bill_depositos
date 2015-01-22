/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/*para ocultar el panel de clientes al momento de seleccionarlos*/
function buscarClienteParaFacturar(){
    var prefix = 'ventasnewventa_';    
    $(document).delegate("#"+prefix+"btn_buscaclient",'click',function(){
        $('#clienttofactmodal').collapse('hide');
    });
}

/*Para archivar la factura de venta*/
function agregarNewFactVenta(){
    var prefix = "ventasnewventa_", cont = 0;    
   $(document).on("keypress", 'form#'+prefix+'formnewfactventa', function(e) {if (e.keyCode == 13) {e.preventDefault(); /* prevent native submit*/}});
  
   $(document).delegate("#"+prefix+"btnaddfactventa",'click',function(e){
        cont = 0;
        $("div#comprasnewfactproductindetalle").each(function(e) {cont++;return false;});
   
        if(cont>0){
            var bValid = validarDatosNewFactVenta()
            if(!bValid){
                e.preventDefault()
            }
        }else{
            e.preventDefault()
            $('.top-right').notify({
                message: {text: 'Debe cargar productos a la factura!'}, type: 'warning', fadeOut: {delay: 3500}
            }).show();
        }        
    });
        return false;
}

function validarDatosNewFactVenta(){
    var bValid = true, prefix = "ventasnewventa_",
        diascredito = getNumericVal("#"+prefix+"diascredito", "int"),  
        pefectivoval = $("#"+prefix+"pefectivoval"),
        fvencepagocredito = $("#"+prefix+"fvencepagocredito"),
        pdiferidocadadias = $("#"+prefix+"pdiferidocadadias"),
        ptotalfact = getNumericVal("#ventasnewventa_ptotalfact", "float"),
//        cambio = obtenerCambioFactVenta(),
        totalcobrado = calcularTotalCobradoEnFactVenta('ok');
      
            var pvendedor = $.trim($("#"+prefix+"pvendedor option:selected").val()),
                pacreditoval = getNumericVal("#"+prefix+"pacreditoval", "float"),
                ptarjeta1val = getNumericVal("#"+prefix+"ptarjeta1val", "float"),
                pcheque1val = getNumericVal("#"+prefix+"pcheque1val", "float"),
                pdiferidoval = getNumericVal("#"+prefix+"pdiferidoval", "float");

                    bValid = bValid && checkLength( pefectivoval, pefectivoval.attr("tittle"), pefectivoval.attr("min"), pefectivoval.attr("max") );    

                if(pacreditoval>0 && diascredito==0){
                    $("#"+prefix+"pacreditoval").parent('div').addClass('has-error');
                    alertaImportant("El cliente no tiene activada la venta a credito", "Venta A Credito"); 
                    bValid = bValid && false;
                }else{
                    if(pvendedor == 0){bValid = bValid && false;$("#"+prefix+"pvendedor").parent('div').addClass('has-error');alertaImportant("Es necesario que selecciones el vendedor", "Seleccion de Vendedor");
                    }

                    if(pacreditoval > 0){
                        bValid = bValid && checkLength( fvencepagocredito, fvencepagocredito.attr("tittle"), fvencepagocredito.attr("min"), fvencepagocredito.attr("max") );
                    }

                    if(ptarjeta1val > 0){
                        var ptarjeta1nro = $("#"+prefix+"ptarjeta1nro"), ptarjeta1fcaducidad = $("#"+prefix+"ptarjeta1fcaducidad"),
                            ptarjeta1codseguridad = $("#"+prefix+"ptarjeta1codseguridad"), ptarjeta1nombre = $.trim($("#"+prefix+"ptarjeta1nombre option:selected").val());                

                            bValid = bValid && checkLength( ptarjeta1nro, ptarjeta1nro.attr("title"), ptarjeta1nro.attr("longmin"), ptarjeta1nro.attr("longmax") );
                            bValid = bValid && checkLength( ptarjeta1fcaducidad, ptarjeta1fcaducidad.attr("title"), ptarjeta1fcaducidad.attr("longmin"), ptarjeta1fcaducidad.attr("longmax") );
                            bValid = bValid && checkLength( ptarjeta1codseguridad, ptarjeta1codseguridad.attr("title"), ptarjeta1codseguridad.attr("longmin"), ptarjeta1codseguridad.attr("longmax") );            
                            if(ptarjeta1nombre == 0){bValid = bValid && false;
                                $("#"+prefix+"ptarjeta1nombre").parent('div').addClass('has-error');
                                alertaImportant("Es necesario que selecciones el nombre de su tarjeta de credito", "Nombre de Tarjeta de Credito");
                            }
                        }

                        if(pcheque1val > 0){
                            var pcheque1nro = $("#"+prefix+"pcheque1nro"), pcheque1nrocta = $("#"+prefix+"pcheque1nrocta"),
                                pcheque1fechacobro = $("#"+prefix+"pcheque1fechacobro"), pcheque1banco = $.trim($("#"+prefix+"pcheque1banco option:selected").val());

                            bValid = bValid && checkLength( pcheque1nro, pcheque1nro.attr("title"), pcheque1nro.attr("longmin"), pcheque1nro.attr("longmax") );
                            bValid = bValid && checkLength( pcheque1nrocta, pcheque1nrocta.attr("title"), pcheque1nrocta.attr("longmin"), pcheque1nrocta.attr("longmax") );
                            bValid = bValid && checkLength( pcheque1fechacobro, pcheque1fechacobro.attr("title"), pcheque1fechacobro.attr("longmin"), pcheque1fechacobro.attr("longmax") );

                            if(pcheque1banco == 0){bValid = bValid && false;
                                $("#"+prefix+"pcheque1banco").parent('div').addClass('has-error');
                                alertaImportant("Es necesario que selecciones el banco de donde proviene el cheque", "Seleccione el Banco");
                            }
                        }

                        if(pdiferidoval > 0){
                            var pdiferidonrocuotas = $("#"+prefix+"pdiferidonrocuotas");
                            bValid = bValid && checkLength( pdiferidonrocuotas, pdiferidonrocuotas.attr("title"), pdiferidonrocuotas.attr("longmin"), pdiferidonrocuotas.attr("longmax") );
                            bValid = bValid && checkLength( pdiferidocadadias, pdiferidocadadias.attr("title"), pdiferidocadadias.attr("longmin"), pdiferidocadadias.attr("longmax") );
                        }
                }
  
   return bValid;
}

function calcularPagos(elem){
    var prefix = 'ventasnewventa_', valprevio = 1;
    $(document).delegate("#"+prefix+elem,'focus',function(){
        valprevio = $(this).val();
        if(valprevio==""){
            valprevio = 0.00;
        }
    }).delegate("#"+prefix+elem,'keyup',function(){
    var totalfact = getNumericVal("#"+prefix+"totalfact", "float"),
            objThis = $(this),
            valactual = objThis.val();           
            //setValorMoneyFormatted(objThis, valactual, valprevio, true);
            objThis.val(valactual);
        if(totalfact>0){
              calcularCambio();              
              calcularCreditoPagoFact();                                
        }else{
            alertaImportant("La factura esta vacia, debe agregar productos", "Pago de Factura");
            objThis.val("0.00");
        }
    });
    return false;
}

function calcularTotalCobradoEnFactVenta(sumarpagoacredito){
    var pefectivoval = getNumericVal("#ventasnewventa_pefectivoval", "float"),
        panticipousado = getNumericVal("#ventasnewventa_panticipousado", "float"),
        ptarjeta1val = getNumericVal("#ventasnewventa_ptarjeta1val", "float"),
        pcheque1val = getNumericVal("#ventasnewventa_pcheque1val", "float"),
        pdiferidoval = getNumericVal("#ventasnewventa_pdiferidoval", "float"),
        pacreditoval = getNumericVal("#ventasnewventa_pacreditoval", "float"),
        arrValuesTotCobrado;
        
        if(sumarpagoacredito == 'ok'){
            arrValuesTotCobrado = [pefectivoval, panticipousado,ptarjeta1val,pcheque1val,pdiferidoval, pacreditoval];
        }else{
            arrValuesTotCobrado = [pefectivoval, panticipousado,ptarjeta1val,pcheque1val,pdiferidoval];
        }
        
        var totalcobrado = sumarValues(arrValuesTotCobrado, "float");
    return totalcobrado.toFixed(numdecimales);
}

function obtenerCambioFactVenta(){
    var ptotalfact  = getNumericVal("#ventasnewventa_ptotalfact", "float"),
        totalcobrado = calcularTotalCobradoEnFactVenta('no');  
    var arrValCambio = [totalcobrado, -ptotalfact],
        cambio = sumarValues(arrValCambio, 'float');
        
        return cambio;
}

function calcularCambio(){
    var prefix = 'ventasnewventa_', 
        ptotalfact  = getNumericVal("#ventasnewventa_ptotalfact", "float"),
        totalcobrado = calcularTotalCobradoEnFactVenta('no');
//alert(totalcobrado);
        if(ptotalfact>0){
            if(totalcobrado>ptotalfact){
                var cambio = obtenerCambioFactVenta();
//              setValorMoneyFormatted($("#"+prefix+"cambio"), cambio, 0.00, true);
                    $("#"+prefix+"cambio").val(cambio.toFixed(2));
                    calcularCreditoPagoFact();                                
            }else{
                /*el cambio vuelve a cero*/
                $("#ventasnewventa_cambio").val("0.00");                
            }
        }else{
            alertaImportant("La factura esta vacia, debe agregar productos", "Pago de Factura");
            $("#ventasnewventa_cambio").val("0.00");
        }
}

function calcularCreditoPagoFact(){
    var ptotalfact  = getNumericVal("#ventasnewventa_ptotalfact", "float"),
        pefectivoval = getNumericVal("#ventasnewventa_pefectivoval", "float"),
        panticipousado = getNumericVal("#ventasnewventa_panticipousado", "float"),
        ptarjeta1val = getNumericVal("#ventasnewventa_ptarjeta1val", "float"),
        pcheque1val = getNumericVal("#ventasnewventa_pcheque1val", "float"),
        pdiferidoval = getNumericVal("#ventasnewventa_pdiferidoval", "float");

        var arrValuesTotPagado = [pefectivoval,panticipousado,ptarjeta1val,pcheque1val,pdiferidoval],
        totalpagado = sumarValues(arrValuesTotPagado, "float"),        
        arrValuespACreditoval = [ptotalfact, -totalpagado],
        pacreditoval = sumarValues(arrValuespACreditoval , "float");                            

        if(ptotalfact>totalpagado){
            $("#ventasnewventa_pacreditoval").val(pacreditoval.toFixed(numdecimales));
        }else{
            $("#ventasnewventa_pacreditoval").val(valorcero);            
        }
}

function loadDialogProductosParaVenta(){
  //$( "#ventasnewventa_btnaddproducts" ).live("click",function() {
    $(document).delegate('#ventasnewventa_btnaddproducts','click',function(){
        //loadDialog("#ventas_dialogproductosparaventa", 400, 'max',true, false,"#ventas_dialogproductosparaventa");
        $( "#ventas_dialogproductosparaventa" ).dialog( "open" );              
    });
}

function verDialogCierreCaja() {
    var prefix = "ventas_";
//      loadDialogNewClient("#"+prefix+"dialogcierrecaja", 'max', 600,false, true,'#'+prefix+'outputcierrecaja');
//      loadDialog("#"+prefix+"dialogcierrecaja", 'max', 800,false, true,'#'+prefix+'outputcierrecaja');
      
   // $( "#btn_cierrecaja" ).live("click",function() {
      $(document).delegate('#btn_cierrecaja', 'click', function(){

//         $( "#"+prefix+"dialogcierrecaja" ).dialog( "open" );  
         
      var bValid = true,
          arrdatosDatos = {"ok":1},
          msgtitulo = "Reporte de Caja",
          msgsuccess = "Asientos Contables Obtenidos Con Exito ",
          msgerror = "Problema!! No se encontraron registros, contacte con admin@masterpc.com.ec",
          areacarga = "#"+prefix+"outputcierrecaja";
          var url = main_path+"/modules/ventas/controlador/facturacion/contaasientocontableget.php";
        loadUrlJson2(url, bValid, arrdatosDatos, null, msgtitulo, msgsuccess, msgerror, areacarga);         
         
      });
}

function listarFactVentaArchivadas(){
    $(document).delegate('#btnfindfactarchivadas','click',function(){
        $("#formbuscafactarchivadas").ajaxForm({
                target: '#outputfacturasarchivadas'
        });
    });  
}

function cambiarAnticipoUsado(){
    var prefix = 'ventasnewventa_', valprevio = 1;
    //alert(panticipodisp);
    $(document).delegate("#"+prefix+'panticipousado','focus',function(){
        valprevio = $(this).val();
        if(valprevio==""){valprevio = 0.00;}
    }).delegate("#"+prefix+'panticipousado','keypress change',function(){
        var objThis = $(this),
            panticipodisp = getNumericVal("#panticipodisp", "float"),
            valactual = objThis.val();
           // alert(panticipodisp)
            if(valactual>panticipodisp){
//                alert(valactual+'  ,  '+panticipodisp);
                $(objThis).val(valorcero);
                alertaImportant('No puede aplicar un uso de anticipo mayor al disponible', 'Aplica Anticipo');
            }else{
                calcularPagos("panticipousado");
            }            
    });
    return false;        
}

function verDialogCierreCajaOk(){
    var prefix = "ventas_";
     
    $(document).delegate('#btncierrecajaok','click',function(){         
      var bValid = true,
          arrdatosDatos = {"ok":1},
          msgtitulo = "Reporte de Caja",
          msgsuccess = "Asientos Contables Obtenidos Con Exito ",
          msgerror = "Problema!! No se encontraron registros, contacte con admin@masterpc.com.ec",
          areacarga = "#"+prefix+"outputcierrecaja";
          var url = main_path+"/modules/ventas/controlador/facturacion/contadatoscierrecaja.php";
        loadUrlJson2(url, bValid, arrdatosDatos, null, msgtitulo, msgsuccess, msgerror, areacarga);         
         
      });
}

function calcularTotalXServicio(){
    $(document).delegate('.facturacionlistaitems_precioserv','keyup',function(){
        var itemcod = $(this).attr("itemcod"),
            cantidadserv = getNumericVal("#facturacionlistaitems_cantidadserv"+itemcod, 'int'),
            precioserv = getNumericVal("#facturacionlistaitems_precioserv"+itemcod, 'float'),
            totalserv = cantidadserv * precioserv;                
//            alert(cantidadserv+'   '+precioserv);
            $("#facturacionlistaitems_totalserv"+itemcod).val(totalserv.toFixed(2));
    });
    $(document).delegate('.facturacionlistaitems_cantidadserv','keyup',function(){
        var itemcod = $(this).attr("itemcod"),
            cantidadserv = getNumericVal("#facturacionlistaitems_cantidadserv"+itemcod, 'int'),
            precioserv = getNumericVal("#facturacionlistaitems_precioserv"+itemcod, 'float'),
            totalserv = cantidadserv * precioserv;                
//            alert(cantidadserv+'   '+precioserv);
            $("#facturacionlistaitems_totalserv"+itemcod).val(totalserv.toFixed(2));
    });
}

function seleccionarBodegaDeVenta(){
    
    $(document).on("change", "#pselectedbodegaidtofact", function(e) {  
        var cont = 0;
        $("div#comprasnewfactproductindetalle").each(function(e) {cont++;return false;});
        
        if(cont==0){
        var tipoprecio = $('#pselectedtipopreciotofact option:selected').val(), bodegaid = $('#pselectedbodegaidtofact option:selected').val(), bodeganombre = $('#pselectedbodegaidtofact option:selected').text();            
            /*en el envio para cargar cada nuevo producto*/
            $('#ventasnewventa_pselectedtipopreciotofact').val(tipoprecio);       
            $('#ventasnewventa_pselectedbodegaidtofact').val(bodegaid);                    
            /*en el area de buscar producto x nombres*/
            $('#ventasnewventa_pselectedtipopreciotofact2').val(tipoprecio);       
            $('#bodegatosearchprod').val(bodegaid);                    
            /*en el envio de la factura completa*/
            $('#ventasnewventa_ptipopreciotofact').val(tipoprecio);       
            $('#ventasnewventa_pbodegaidtofact').val(bodegaid);        
            $('#ventasnewfactselectedbodegaarea').html('<h4><span class="text-danger">Precio:&nbsp;'+tipoprecio+' | Bodega:&nbsp;'+bodeganombre+'</span></h4>');
        }else{
            alertaError('No puede cambiar de bodega porque ya ha agregado productos a la factura!', 'Cambiar Bodega');
            e.preventDefault()
        }
    }).on("change", "#pselectedtipopreciotofact", function(e) {
        var cont = 0;
        $("div#comprasnewfactproductindetalle").each(function(e) {cont++;return false;});
        
        if(cont==0){
        var tipoprecio = $('#pselectedtipopreciotofact option:selected').val(), bodegaid = $('#pselectedbodegaidtofact option:selected').val(), bodeganombre = $('#pselectedbodegaidtofact option:selected').text();            
            /*en el envio para cargar cada nuevo producto*/
            $('#ventasnewventa_pselectedtipopreciotofact').val(tipoprecio);       
            $('#ventasnewventa_pselectedbodegaidtofact').val(bodegaid);                    
            /*en el area de buscar producto x nombres*/
            $('#ventasnewventa_pselectedtipopreciotofact2').val(tipoprecio);       
            $('#bodegatosearchprod').val(bodegaid);                    
            /*en el envio de la factura completa*/
            $('#ventasnewventa_ptipopreciotofact').val(tipoprecio);       
            $('#ventasnewventa_pbodegaidtofact').val(bodegaid);        
            $('#ventasnewfactselectedbodegaarea').html('<h4><span class="text-danger">Precio:&nbsp;'+tipoprecio+' | Bodega:&nbsp;'+bodeganombre+'</span></h4>');
        }else{
            alertaError('No puede cambiar de precio porque ya ha agregado productos a la factura!', 'Cambiar Precios');
            e.preventDefault()
        }
    });
}

function calcularSubtotalBrutoNewFactVenta(){
    var subtbrutonewcompra = 0;
        $("input#ventasnewfactpcostototalprod").each(function(e) {
            var total = parseFloat($(this).val());
            subtbrutonewcompra+=total;
        });        
    $('#ventasnewventa_subtotalbruto').val(subtbrutonewcompra.toFixed(numdecimales));
    $('#ventasnewventa_psubtotalbruto').val(subtbrutonewcompra.toFixed(numdecimales));    
}

function quitarProdEnNewFactVenta(){
   $(document).delegate('#quitarprodnewfactventabtn','click',function(){
       var codprod = $(this).attr('codprod')
           $(this).parent("div").parent("div").remove();
           calcularSubtotalBrutoNewFactVenta()
           calcTotIceImpuestosFactVenta()           
           calcularTotalTarifCeroFactVenta()   
           resetPagos()
   });
}

function calcularTotalxProdVenta(codprod){
   var bodegaid = getNumericVal('#pselectedbodegaidtofact','int'),
       cantidadmax = getStockXBodega(codprod, bodegaid),          
       cantidad = getNumericVal('.ventasnewfactcantidad'+codprod,'float'),
       costounitfinal = getNumericVal('.ventasnewfactcostounit'+codprod,'float');
    
       if(cantidadmax < cantidad){
           cantidad = cantidadmax;
           $('.ventasnewfactcantidad'+codprod).val(cantidadmax)
       }       
       var totalxprod = cantidad * costounitfinal;       
       $('.ventasnewfactpcostototalprod'+codprod).val(totalxprod.toFixed(numdecimales));
       $('.ventasnewfactcostototalprod'+codprod).val(totalxprod.toFixed(numdecimales));
            /*aplicar por tarifa (cero o 12 por ciento) tambien el cambio*/
       $('.ventasnewfactivatarifaceroprodbruto'+codprod).val(totalxprod.toFixed(numdecimales));
       $('.ventasnewfactivatarifadoceprodbruto'+codprod).val(totalxprod.toFixed(numdecimales));
       
}
function cambiarValProdFactVenta(elem){
    $(document).delegate(elem,'keyup',function(){
        var codprod = $.trim($(this).attr('codprod'));        
        //resetDescuentosProd(codprod)        
        calcularTotalxProdVenta(codprod)
        calcularSubtotalBrutoNewFactVenta()        
        calcTotIceImpuestosFactVenta()   
        calcularTotalTarifCeroFactVenta()
        resetPagos()

    });
    return false;
}

function calcularTotalTarifCeroFactVenta(){
    var tottarifacerobruto = 0, tottarifadocebruto = 0, tottarifaceroneto = 0, 
        tottarifadoceneto = 0, subtotalnetofact = 0, ivafactval = 0, totalfact = 0,
        descporcentfact = getNumericVal('#ventasnewventa_descporcentfact', 'float'),        
        recporcentfact = getNumericVal('#ventasnewventa_recargoporcentfact', 'float'),        
        subtotalbrutofact = getNumericVal('#ventasnewventa_psubtotalbruto', 'float'),        
        icefact = getNumericVal('#ventasnewventa_picefactneto', 'float'),        
        impverdefact = getNumericVal('#ventasnewventa_pimpverdefactneto', 'float');        
               
        $("input#ventasnewfactivatarifaceroprodbruto").each(function(e) {
            var total = parseFloat($(this).val());tottarifacerobruto+=total;
        });
        $("input#ventasnewfactivatarifadoceprodbruto").each(function(e) {
            var total = parseFloat($(this).val());tottarifadocebruto+=total;
        });
        
    $('#ventasnewventa_tarcerobruto').val(tottarifacerobruto.toFixed(numdecimales));
    $('#ventasnewventa_tardocebruto').val(tottarifadocebruto.toFixed(numdecimales));

    var descvalfacttarcero = parseFloat((tottarifacerobruto * descporcentfact)/100),
        descvalfacttardoce = parseFloat((tottarifadocebruto * descporcentfact)/100),
        recvalfacttarcero = parseFloat((tottarifacerobruto * recporcentfact)/100),
        recvalfacttardoce = parseFloat((tottarifadocebruto * recporcentfact)/100),
        descvalfactttotal = parseFloat((subtotalbrutofact * descporcentfact)/100),
        recvalfactttotal = parseFloat((subtotalbrutofact * recporcentfact)/100);

        tottarifaceroneto = tottarifacerobruto - descvalfacttarcero + recvalfacttarcero;
        tottarifadoceneto = tottarifadocebruto - descvalfacttardoce + recvalfacttardoce;
        subtotalnetofact = tottarifaceroneto + tottarifadoceneto;
        ivafactval = (tottarifadoceneto * ivaporcent) / 100,
        totalfact = subtotalnetofact + ivafactval + icefact + impverdefact;
    
        $('#ventasnewventa_tarceroneto').val(tottarifaceroneto.toFixed(numdecimales));
        $('#ventasnewventa_tarceronetotxt').val(tottarifaceroneto.toFixed(numdecimales));
        
        $('#ventasnewventa_tardoceneto').val(tottarifadoceneto.toFixed(numdecimales));
        $('#ventasnewventa_tardocenetotxt').val(tottarifadoceneto.toFixed(numdecimales));    
        
        $('#ventasnewventa_descvalfact').val(descvalfactttotal.toFixed(numdecimales));
        $('#ventasnewventa_recargovalfact').val(recvalfactttotal.toFixed(numdecimales));
        
        $('#ventasnewventa_psubtotalneto').val(subtotalnetofact.toFixed(numdecimales));
        $('#ventasnewventa_subtotalneto').val(subtotalnetofact.toFixed(numdecimales));
        
        $('#ventasnewventa_pivaval').val(ivafactval.toFixed(numdecimales));
        $('#ventasnewventa_ivaval').val(ivafactval.toFixed(numdecimales));
        
        $('#ventasnewventa_ptotalfact').val(totalfact.toFixed(numdecimales));
        $('#ventasnewventa_totalfact').val(totalfact.toFixed(numdecimales));
        
}

function calcTotIceImpuestosFactVenta(){
    var toticefact = 0, totimpverdefact = 0;
        $("input#ventasnewfacticevalprod").each(function(e) {
            var total = parseFloat($(this).val());toticefact+=total;
        });
        $("input#ventasnewfactimpverdevalprod").each(function(e) {
            var total = parseFloat($(this).val());totimpverdefact+=total;
        });
        
        
        $('#ventasnewventa_picefactbruto').val(toticefact.toFixed(numdecimales));        
        $('#ventasnewventa_pimpverdefactbruto').val(totimpverdefact.toFixed(numdecimales));
        
        /*Ahora se aplica el correspondiente descuento x el total de la factura*/
//        var descporcentfact = $('#ventasnewventa_descporcentfact').val(),
        var descporcentfact = getNumericVal('#ventasnewventa_descporcentfact', 'float'),
            toticefactneto = toticefact - ((toticefact * descporcentfact)/100),
            totimpverdefactneto = totimpverdefact - ((totimpverdefact * descporcentfact)/100);
        
        $('#ventasnewventa_picefactneto').val(toticefactneto.toFixed(numdecimales));
        $('#ventasnewventa_pimpverdefactneto').val(totimpverdefactneto.toFixed(numdecimales));
        
        /*el total neto de ice e impuesto verde son visibles al usuario*/
        $('#ventasnewventa_icefacttxt').val(toticefact.toFixed(numdecimales));
        $('#ventasnewventa_pimpverdefacttxt').val(totimpverdefact.toFixed(numdecimales));
//    return false;
}

/*cuando se cambia el campo de valor de dscuento en la factura de compra*/
function changeDescRecValInFactVenta(elemva, elemporcent){
    $(document).delegate(elemva, 'keyup', function(){
        var objThis = $(this), totalfact = getNumericVal("#ventasnewventa_ptotalfact", "float");
        if(totalfact > 0){
            var valdesc = $(this).val(),
//                subtotalfact = $('#ventasnewventa_subtotalbruto').val(),
                subtotalfact = getNumericVal('#ventasnewventa_subtotalbruto', 'float'),
                descuentoporcent = parseFloat((valdesc * 100)/subtotalfact);
                $(elemporcent).val(descuentoporcent.toFixed(numdecimales))
                calcTotIceImpuestosFactVenta()
                calcularTotalTarifCeroFactVenta()            
        }else{
            alertaImportant('Debe cargar productos en la factura', 'Aplicar Descuento');
            objThis.val(valorcero);
        }

        return false;        
    });
}

function getStockXBodega(productocod, bodegaid){
        var stock=0,
                data = {"pproductocod":productocod, "pbodegaid":bodegaid};
                data = JSON.stringify(data);
                    $.ajax({
                        url: main_path+"/modules/ventas/controlador/facturacion/stockbodegaget.php",
                        type: "post",cache: false,dataType: "json",data: data,
                            success: function(html){stock = html.stock;},
                            error: function(html){stock = -1;},
                        contentType: "application/json", async:   false
                    });
          return stock;
}

function cambiarDescRecPorcentFactVenta(elem){
    $(document).delegate(elem, 'keyup', function(){
        var objThis = $(this), totalfact = getNumericVal("#ventasnewventa_ptotalfact", "float");
        
        if(totalfact > 0){
            calcTotIceImpuestosFactVenta()
            calcularTotalTarifCeroFactVenta()            
        }else{
            alertaImportant('Debe agregar productos en la factura', 'Aplicar Descuentos');
            objThis.val(valorcero);
        }
    });
}

function cambiarValorVentaCredito(){
   $(document).on("keyup", "#ventasnewventa_pacreditoval", function(e) {
       var diascredito = getNumericVal("#ventasnewventa_diascredito", "float");       
       if(diascredito <= 0){
           $('#ventasnewventa_pacreditoval').val(valorcero);
           $('#ventasnewventa_pacreditoval').parent('div').addClass('has-error');
           alertaInfo('El cliente no tiene activa la venta a credito', 'Valor Venta a Credito');
       }
   })
   
}
/*cuando se agrega o se quita productos, se deben volver
**a cero los pagos realizados, y ponerlos de nuevo para los valores totales*/
function resetPagos(){
    $('#ventasnewventa_pefectivoval').val(valorcero);
    $('#ventasnewventa_cambio').val(valorcero);
    $('#ventasnewventa_pcambio').val(valorcero);
    $('#ventasnewventa_pacreditoval').val(valorcero);
    $('#ventasnewventa_panticipousado').val(valorcero);
    $('#ventasnewventa_ptarjeta1val').val(valorcero);
    $('#ventasnewventa_pcheque1val').val(valorcero);
    $('#ventasnewventa_pdiferidoval').val(valorcero);
}

function aplicarRecargoProducto(){
   $(document).on("click", "#ventasnewfactdetaplirec", function(e) {
       var codprod = $(this).attr('codprod'),
           costounit = getNumericVal('.ventasnewfactpcostounit'+codprod, 'float'), 
//           cantidad = getNumericVal('.ventasnewfactcantidad'+codprod, 'int'),
           recargoprodval = getNumericVal('#ventasnewfactrecvalprod'+codprod, 'float'),
           costounitnew = costounit + recargoprodval;
           
           $('.ventasnewfactpcostounit'+codprod).val(costounitnew.toFixed(numdecimales));
           $('.ventasnewfactcostounit'+codprod).val(costounitnew.toFixed(numdecimales));
           
           calcularTotalxProdVenta(codprod); /*se calcula los totales por producto*/
           calcularSubtotalBrutoNewFactVenta()
           calcTotIceImpuestosFactVenta()
           calcularTotalTarifCeroFactVenta()
           resetPagos()
   });
}

function limpiarParaNuevaFacturaVenta(){
    $(document).on("click", '#ventasnewventa_newfactbtn', function(e) {
        e.preventDefault();
        var data = {'action': 'refresh'}, url = main_path+'/modules/ventas/vista/newventa.php';
        $.ajax({
            type: "POST", url: url, data: data,
            success: function(html){$('#ventasfactventa').html(html);},
            error: function(html){alertaImportant('Ocurrio un problema!!', 'Cargar Nueva Factura');},
            dataType: 'html'
        });
    });
}

function changeVentasSection(){
    $(document).on("click", '#btn_vistanewventa', function(e) {
        $('#ventastittlesection').html($(this).attr('title'));
        $('.ventasmodule').slideUp(700);
        $('#ventasfactventa').slideDown(700)
    }).on('click', '#btnfacturasarchivadas', function(e) {
        $('#ventastittlesection').html($(this).attr('title'));
        $('.ventasmodule').slideUp(700);
        $('#ventasfactventaarchivadas').slideDown(700)
    }).on('click', '#clientssectionbtn', function(e) {
        $('#ventastittlesection').html($(this).attr('title'));
        $('.ventasmodule').slideUp(700);
        $('#clientessection').slideDown(700)
    })
}

/*cuando el el descuento maximo permitido es relativo al precio de venta,
 * si es 50%, su puede bajar 50% del precio A, B, C,...
 * En el caso que tipo=recargo no existe limite*/
function changeDescRecPorcentInProdVenta(elemporcent, elemval, tipo){
    $(document).delegate(elemporcent, "keyup",function(){
        var codprod = $.trim($(this).attr("codprod")),
            costounit = parseFloat($(".ventasnewfactpcostounit"+codprod).val()),
            porcentval = parseFloat($(this).val()),
            newrecargoval = parseFloat((costounit * porcentval)/100),
            pmaximodescuentoporcent = getNumericVal('#ventasnewfactpmaximodescuentoporcent'+codprod, 'float');
            if(tipo == 'descuento'){
                if(porcentval > pmaximodescuentoporcent){
                    alertaInfo('Ha sobrepasado el limite de descuento', 'Aplicar Descuento');
                    $(elemporcent).val(valorcero);
                    $(elemval+codprod).val(valorcero);
                }else{
                    $(elemval+codprod).val(newrecargoval.toFixed(numdecimales));
                }                
            }else{
                    $(elemval+codprod).val(newrecargoval.toFixed(numdecimales));                
            }            
        return false;
    });    
}

/*cuando el el descuento maximo permitido es relativo al precio de venta,
 * si es 50%, su puede bajar 50% del precio A, B, C,...
 * En el caso de recargo no existe limite*/
function changeDescRecValInProdVenta(elemval, elemporcent, tipo){
    $(document).delegate(elemval, 'keyup', function(){
        var codprod = $.trim($(this).attr("codprod")),
            costounit = parseFloat($(".ventasnewfactpcostounit"+codprod).val()),            
            recargoval = parseFloat($(this).val()),
            recargoporcent = parseFloat((recargoval * 100)/costounit),
            pmaximodescuentoporcent = getNumericVal('#ventasnewfactpmaximodescuentoporcent'+codprod, 'float');            
            
            if(tipo == 'descuento'){
                if(recargoporcent > pmaximodescuentoporcent){
                    alertaInfo('Ha sobrepasado el limite de descuento', 'Aplicar Descuento');
                    $(elemval).val(valorcero);
                    $(elemporcent+codprod).val(valorcero);
                }else{
                    $(elemporcent+codprod).val(recargoporcent.toFixed(numdecimales));
                }                
            }else{
                    $(elemporcent+codprod).val(recargoporcent.toFixed(numdecimales));               
            }
        return false;            
    });    
}

function aplicarDescuentoProductoVentas(){
   $(document).on("click", "#ventasnewfactdetaplidesc", function(e) {
       var codprod = $(this).attr('codprod'),
           costounit = getNumericVal('.ventasnewfactpcostounit'+codprod, 'float'), 
//           cantidad = getNumericVal('.ventasnewfactcantidad'+codprod, 'int'),
           descuentoprodval = getNumericVal('#ventasnewfactdescvalprod'+codprod, 'float'),
           costounitnew = costounit - descuentoprodval;
           
           $('.ventasnewfactpcostounit'+codprod).val(costounitnew.toFixed(numdecimales));
           $('.ventasnewfactcostounit'+codprod).val(costounitnew.toFixed(numdecimales));
           
           calcularTotalxProdVenta(codprod); /*se calcula los totales por producto*/
           calcularSubtotalBrutoNewFactVenta()
           calcTotIceImpuestosFactVenta()
           calcularTotalTarifCeroFactVenta()
           resetPagos()
   });
}

function cambiarPrecioUnitPorDescuento(){
   $(document).on("click", "#ventasnewfactcambiarpreciobtn", function(e) {
       var codprod = $(this).attr('codprod'),
           preciominimo = getNumericVal('#ventasnewfactppreciominimoventa'+codprod, 'float'), 
           costounitnew = getNumericVal('#ventasnewfactnuevoprecioval'+codprod, 'float');
           alert(costounitnew + '  ,  '+ preciominimo)
           if(costounitnew >= preciominimo){
                $('.ventasnewfactpcostounit'+codprod).val(costounitnew.toFixed(numdecimales));
                $('.ventasnewfactcostounit'+codprod).val(costounitnew.toFixed(numdecimales));

                calcularTotalxProdVenta(codprod); /*se calcula los totales por producto*/
                calcularSubtotalBrutoNewFactVenta()
                calcTotIceImpuestosFactVenta()
                calcularTotalTarifCeroFactVenta()
                resetPagos()               
           }else{
               alertaImportant('Esta intentando aplicar precio por debajo del minimo permitido, se ha enviado una notificacion de esta accion al administrador, ¡Mucho Cuidado!', 'Aplicar Descuento Unico');
           }
   });
}

function getProductoVentasxID(){
    $(document).on("keypress", "#serarchprodbycod", function(e) {
         if ( e.which == 13 ) {
            var bodegaselected = $("#bodegatosearchprod").val(); //comprobar si la factura tiene el campo de bodega a pasar                        
            if(bodegaselected != '' && bodegaselected != 'undefined' && bodegaselected != '0'){
                var form = $(this).parents('form');
                $(form).ajaxForm({
                    success: getRespNewProdFactVentaDet, clearForm: true
                });            
            } else {
            e.preventDefault();
            alertaError('Debe Seleccionar Una Bodega Antes de Agregar Productos A La Factura', 'Agregar Productos');
            }
         }
    });   
    
    $(document).on("click", "#ventasnewfactitemxidgetbtn", function(e) {    
        var bodegaselected = $("#bodegatosearchprod").val(); //comprobar si la factura tiene el campo de bodega a pasar                
        if(bodegaselected != '' && bodegaselected != 'undefined' && bodegaselected != '0'){
//            alert(bodegaselected);
            var form = $(this).parents('form');
            $(form).ajaxForm({
                success: getRespNewProdFactVentaDet, clearForm: true
            });            
        }else{
            e.preventDefault();
            alertaError('Debe Seleccionar Una Bodega Antes de Agregar Productos A La Factura', 'Agregar Productos');
        }

    }); 

    return false;    
}

function getRespNewProdFactVentaDet(data){
    if($.trim(data)!=''){
        $('#ventasnewfactareadetalle').append(data);
            calcularSubtotalBrutoNewFactVenta()
            calcTotIceImpuestosFactVenta()
            calcularTotalTarifCeroFactVenta()
            resetPagos()
    }else{
        alertaInfo('No se ha encontrado el producto que busca o se ha dado de baja', 'Agregar Producto');
    }
}

function anularFactura(){
    $(document).on("click", "#anularfactbtn", function(e) {
        var objThis = $(this);
        bootbox.confirm("<h2><span class='glyphicon glyphicon-question-sign'></span>&nbsp;Seguro que desea anula la factura?</h2> <h4 class='text-info'>No se podra deshacer los cambios</h4>", function(result) {
            if(result){
//                alert();
                var form = $(objThis).parents('form');
                $(form).ajaxSubmit({dataType:  'json', success: getResponseAnularFactura});
            }
        });
    });
}

function getResponseAnularFactura(data){
    if(data.ok > 0){
        alertaExito('La factura ha sido anulada correctamente', 'Anular Factura');
        $("#anularfactbtn").hide();
//        $("#anularfactbtn").css('disabled', '');
        $("#anularfactbtn").parents('tr').addClass('text-muted');
    }else if(data.ok == -2){
        alertaError('Solamente puede anular facturas archivadas en el mismo dia de la anulacion, y que no hayan sido anuladas previamente','Anular Factura');
    }else{
        alertaError('No se ha podido completar la anulacion de la factura!','Anular Factura');    
    }
}

function cotizaciones(){
   anularFactura();
   buscarClienteParaFacturar();
   ejectSubmitFormsHtmlOutput("#ventasnewventa_searchproductbtn",  "#ventasnewventa_searchproductoutput");
   ejectSubmitFormsHtmlOutput("#searchclientbtn",  "#searchclientoutput");
   ejectSubmitFormsHtmlOutput("#searchclientbtntoventa",  "#searchclientoutputtoventa");
   
   ejectSubmitFormsHtmlOutput("#ventasnewventa_btn_buscaclient",  "#ventasnewfactclientdata");
   
    cambiarPrecioUnitPorDescuento()
    aplicarDescuentoProductoVentas()
    changeDescRecValInProdVenta(".ventasnewfactrecvalprod", "#ventasnewfactrecporcentprod", 'recargo')
    changeDescRecValInProdVenta(".ventasnewfactdescvalprod", '#ventasnewfactdescporcentprod', 'descuento')
    changeDescRecPorcentInProdVenta('.ventasnewfactrecporcentprod', "#ventasnewfactrecvalprod", 'recargo')
    changeDescRecPorcentInProdVenta('.ventasnewfactdescporcentprod', "#ventasnewfactdescvalprod", 'descuento')
    
    limpiarParaNuevaFacturaVenta()
    changeVentasSection()
    seleccionarBodegaDeVenta()
    quitarProdEnNewFactVenta()
    cambiarValProdFactVenta('#ventasnewfactcantidad')
    cambiarValProdFactVenta('#ventasnewfactcostounit')
    changeDescRecValInFactVenta('#ventasnewventa_descvalfact', '#ventasnewventa_descporcentfact')
    changeDescRecValInFactVenta('#ventasnewventa_recargovalfact', '#ventasnewventa_recargoporcentfact')
    cambiarDescRecPorcentFactVenta('#ventasnewventa_recargoporcentfact')
    cambiarDescRecPorcentFactVenta('#ventasnewventa_descporcentfact')
    cambiarValorVentaCredito()
    aplicarRecargoProducto()
/**************************************************/
    getProductoVentasxID()  
//    buscarClienteParaFacturar()
/***********************************************/
    agregarNewFactVenta()
    
    calcularPagos("pefectivoval")
    calcularPagos("descporcent"); /*cuando se cambia el total por descuento, recargo, etc*/
    calcularPagos("recargoporcent")
    calcularPagos("descval")
    calcularPagos("recargoval")
    calcularPagos("ptarjeta1val")
    calcularPagos("pcheque1val")
    calcularPagos("pdiferidoval")
//    imprimirFactVentaActual()
    loadDialogProductosParaVenta()
    verDialogCierreCaja()
    listarFactVentaArchivadas()
    cambiarAnticipoUsado()
    verDialogCierreCajaOk()
    calcularTotalXServicio()
}