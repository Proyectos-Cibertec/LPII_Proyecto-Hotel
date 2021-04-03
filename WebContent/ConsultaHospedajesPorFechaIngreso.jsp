<jsp:include page="sistemaValida.jsp" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
    <!DOCTYPE html>
    <html lang="es">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
        <link rel="stylesheet" href="css/bootstrap.css" />
        <link rel="stylesheet" href="css/bootstrapValidator.css" />
        <link rel="stylesheet" href="css/sweetalert.css" />
        <link rel="stylesheet" href="css/tabla.css" />
        <link rel="stylesheet" href="css/estilosBasicos.css" />
        
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrap.min.js"></script>
        <script type="text/javascript" src="js/bootstrapValidator.js"></script>
        <script type="text/javascript" src="js/sweetalert.js"></script>

        <title>CONSULTA DE HOSPEDAJES</title>
        <style>
        	.form-group {
			    overflow: auto;
			}

        	h3 {
        		margin-top: 20px;
       		    text-align: center;
			    font-weight: bold;
			    font-size: 20px;
        	}
        </style>
    </head>

    <body>
		<jsp:include page="cabecera.jsp" />
		 
		
		<!--  Modal actualiza -->
            <div class="modal fade" id="modalDetalleHospedaje">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4>
                                DETALLE DE HOSPEDAJE
                            </h4>
                        </div>
                        <div class="modal-body">
                            <div id="">
                                <div class="panel-group" id="steps">
                                    <!-- Step 1 -->
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#steps" href="#panelActualizarDatos">Detalle del Hospedaje</a>
                                            </h4>
                                        </div>
                                        <div id="panelActualizarDatos" class="panel-collapse collapse in">
                                            <div class="panel-body">

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_idHospedaje_detalle">ID</label>
                                                    <div class="col-lg-9">
                                                        <input class="form-control" id="id_idHospedaje_detalle" readonly name="" type="text"  />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaIngreso_detalle">Fecha de Ingreso</label>
                                                    <div class="col-lg-9">
                                                        <input class="form-control" id="id_fechaIngreso_detalle" readonly name="" type="text"  />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaSalida_detalle">Fecha de Salida</label>
                                                    <div class="col-lg-9">
                                                        <input class="form-control" id="id_fechaSalida_detalle" readonly name="" type="text"  />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_cliente_detalle">Cliente</label>
                                                    <div class="col-lg-9">
                                                        <input class="form-control" id="id_cliente_detalle" readonly name="" type="text" />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_trabajador_detalle">Trabajador</label>
                                                    <div class="col-lg-9">
                                                        <input class="form-control" id="id_trabajador_detalle" readonly name="" type="text" />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
                                                	<h3>HABITACIONES OCUPADAS POR HOSPEDAJE</h3>
                                                    <table style="margin-top: 20px;" class="table table-striped table-bordered">
                                                    	<thead>
                                                    		<tr>
                                                    			<th>ID HABITACIÓN</th>
	                                                    		<th>COSTO</th>
	                                                    		<th>TIPO</th>
	                                                    		<th>CATEGORÍA</th>
	                                                    		<th>NÚMERO</th>
	                                                    		<th>PISO</th>
                                                    		</tr>
                                                    	</thead>
                                                    	<tbody id="tableDetalleHospedaje">
                                                    		
                                                    	</tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
		
        <div class="container">
            <h1>Consulta de Hospedajes</h1>
            <div class="col-md-23">
                <form accept-charset="UTF-8" action="hospedaje" class="simple_form" id="frmFiltra" method="post">
                    <input type="hidden" name="metodo" value="consultaPorFecha">
                    <div class="row primeraFila">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="control-label" for="id_fechaInicial_filtro">Fecha Inicial</label>
                                <input class="form-control" id="id_fechaInicial_filtro" name="fechaInicial" type="date" />
                            </div>
                        </div>
                        
                        <div class="col-md-3">
							<div class="form-group">
                                <label class="control-label" for="id_fechaFinal_filtro">Fecha Final</label>
                                <input class="form-control" id="id_fechaFinal_filtro" name="fechaFinal" type="date" />
                            </div>                           
                        </div>
                        <div class="col-md-3">
							<div class="form-group">
                            	<button type="submit" class="btn btn-success btn-filtrar" id="btnFiltrar">
                            		<span class="glyphicon glyphicon-filter"></span> FILTRAR</button>
                            </div>                            
                        </div>
                    </div>                    
                    <div class="row">
                        <div class="col-md-12">
                            <div class="content">
                                <table id="tablaPrincipal" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>FECHA INGRESO</th>
                                            <th>FECHA SALIDA</th>
                                            <th>IGV</th>
                                            <th>CLIENTE</th>
                                            <th>TRABAJADOR</th>
                                            <th>VER DETALLE</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${hospedajes}" var="x">
                                            <!-- parametro de la parte final del metodo-->
                                            <tr>
                                                <td>${x.idHospedaje}</td>
                                                <td>${x.fechaIngreso}</td>
                                                <td>${x.fechaSalida}</td>
                                                <td>${x.igv}</td>
                                                <td>${x.cliente.nombreCompleto}</td>
                                                <td>${x.trabajador.nombreCompleto}</td>
                                                <td>
                                                	<button type='button' data-toggle='modal' class=' btn btn-success btn-actualizar' 
                                                    	onclick="mostrarDetalle('${x.idHospedaje}', '${x.fechaIngreso}', '${x.fechaSalida}', '${x.cliente.nombreCompleto}', '${x.trabajador.nombreCompleto}');"> <img class="btn-image-icon" src='images/edit.png' />
													</button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                            </div>
                        </div>
                    </div>
                </form>
            </div>
		</div>
        <script type="text/javascript">
        
	        function mostrarDetalle(idHospedaje, fechaIngreso, fechaSalida, cliente, trabajador) {
	            $('input[id=id_idHospedaje_detalle]').val(idHospedaje);
	            $('input[id=id_fechaIngreso_detalle]').val(fechaIngreso);
	            $('input[id=id_fechaSalida_detalle]').val(fechaSalida);
	            $('input[id=id_cliente_detalle]').val(cliente);
	            $('input[id=id_trabajador_detalle]').val(trabajador);
	
	            $('#modalDetalleHospedaje').modal("show");
	            
	            $.getJSON("hospedaje", 
	            // parámetros		
	            {
                    metodo: "obtenerDetalleHospedaje",
                    idHospedaje: idHospedaje
                },
	                function(data, textStatus, jqXHR) {
	                    console.log(data);
	                    
	                    $("#tableDetalleHospedaje").empty();
	                    for (var i = 0; i < data.length; ++i) {
	                    	$("#tableDetalleHospedaje").append(
                   				"<tr><td>" + data[i].idHabitacion + "</td>" +
                   				"<td>" + data[i].costo + "</td>" +
                   				"<td>" + data[i].tipo + "</td>" +
                   				"<td>" + data[i].categoria + "</td>" +
                   				"<td>" + data[i].numero + "</td>" +
                   				"<td>" + data[i].piso + "</td></tr>" 
                   			);
	                    }
	                    /*if (data.length > 0) {
	                        // La persona ya está registrada como cliente, no permitir que se registre nuevamente  
	                        swal("El cliente con número de DNI: " + dni + " ya se encuentra registrado en la tabla de Clientes. " +
	                            "Ingrese otro número de DNI");
	                        
	                        
	                        
	                        $("#id_dni").val("");
	                        $(".changeValidate").change();
	                        $("#id_dni").focus();
	                    } else {
	                        // La persona no está registrada como cliente, pero se podría tratar de un empleado
	                        // Ahora se procede a buscar si está registrado en la tabla Persona
	
	                        $.getJSON("persona", {
	                                metodo: "consultaXDNI_JSON",
	                                filtro: dni
	                            },
	                            function(data, textStatus, jqXHR) {
	                                console.log(data);
	                                if (data.length > 0) {
	                                    swal("La persona con número de DNI: " + dni + " ya se encuentra registrado en la base de datos pero aún no está en la tabla de Clientes." +
	                                        "Si desea registrarlo como Cliente, llene los campos faltantes y pulse en el botón Registrar.");
	
	                                    var persona = data[0];
	
	                                    $("#id_persona").val(persona.idPersona);
	                                    $("#id_dni").val(persona.dni);
	                                    $("#id_nombres").val(persona.nombres);
	                                    $("#id_apellidos").val(persona.apellidos);
	                                    $("#id_direccion").val(persona.direccion);
	                                    $("#id_telefono").val(persona.telefono);
	                                    $("#id_fechaNacimiento").val(persona.fechaNacimiento);
	                                    $(".changeValidate").change();
	
	                                    $("#tipoRegistro").val("nodefault");
	
	                                } else {
	                                    swal("No existen personas registradas con el dni: " + dni + ". Proceda a registrarlo llenando todos los campos.");
	                                    $("#tipoRegistro").val("default");
	                                    $("#id_nombres").focus();
	                                    limpiarEntradas();
	                                }
	                            }
	                        );
	                    }*/
	                }
	            );
	        }
        
            Date.prototype.toDateInputValue = (function() {
                var local = new Date(this);
                local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
                return local.toJSON().slice(0, 10);
            });

            function fechaHoy() {
                return new Date().toDateInputValue();
            }
            

            $(document).ready(function() {
            	
            	$("#id_fechaInicial_filtro").val(fechaHoy());
            	$("#id_fechaFinal_filtro").val(fechaHoy());

                $('#tablaPrincipal').DataTable();

                $('#frmFiltra').bootstrapValidator({
                    message: 'This value is not valid',
                    excluded: ':disabled',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        fechaInicial: {
                            message: 'El campo fecha de nacimiento no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo fecha de nacimiento es requerido'
                                },
                                date: {
                                    format: 'YYYY-MM-DD'
                                }
                            }
                        },
                        fechaFinal: {
                            message: 'El campo fecha de nacimiento no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo fecha de nacimiento es requerido'
                                },
                                date: {
                                    format: 'YYYY-MM-DD'
                                }
                            }
                        }
                    }
                }).on('error.form.bv', function(e) {
                    console.log('error');

                    // Active the panel element containing the first invalid element
                    var $form = $(e.target),
                        validator = $form.data('bootstrapValidator'),
                        $invalidField = validator.getInvalidFields().eq(0),
                        $collapse = $invalidField.parents('.collapse');
                    $collapse.collapse('show');
                })

            });
        </script>
    </body>

    </html>