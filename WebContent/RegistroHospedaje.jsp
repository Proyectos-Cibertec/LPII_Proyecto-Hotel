<jsp:include page="sistemaValida.jsp" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
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
<script type="text/javascript" src="js/moment.js"></script>

<style>
	.modal-header, .close, .panel-title {
		background-color: #286090;
		color: white !important;
		text-align: center;
	}
	
	.btn {
		width: 100%;
	}
	
	.modal-header h4 {
		font-size: 30px;
	}
	
	.modal-dialog {
		width: 60%;
	}
	
	.modal-header {
		padding: 35px 50px
	}
	
	.modal-body {
		padding: 20px 10px;
	}
	
	td {
		text-align: center;
	}
	
	.btn-actualizar, .btn-eliminar {
		background-color: hsla(233, 100%, 100%, 0);
	}
	
	/*.container {
	    width: 70%;
	}*/

	.contenedorCliente {
	    float: right;
	    width: 60%;
	}
	
	.contenedorHospedaje {
	    width: 40%;
	    float: left;
	}
	
	.contenedorHabitaciones {
    	clear: both;
	}
	
	.contenedorCliente,
	.contenedorHospedaje,
	.contenedorHabitaciones {
	    border: 2px solid #357ebd;
	    border-radius: 5px;
	    padding: 10px 20px;
	}
	
	h3 {
	    background: #286090;
	    color: white;
	    text-align: center;
	    padding: 5px;
	    border-radius: 5px;
	    font-size: 19px;
	    text-transform: uppercase;
        margin-top: 0px;
	}
	
	.row {
	    margin-bottom: 20px;
	}
	
	.contenedorHabitaciones .row {
		margin-bottom: 5px;
	}
	
	#btnModalBuscarCliente {
		float: left;
		width: 49%;
	}
	
	#btnRegistrarCliente {
		float: right;
		width: 49%;
	}
	
	.nohalf {
		clear: both;
	}
	
	.half {
		float: left;
	    width: 49%;
	    margin-right: 1%;
	}
</style>

<title>REGISTRO DE HOSPEDAJE</title>
</head>
<body>
	<jsp:include page="cabecera.jsp" />
	<div class="container">
		<h1>Registro de Hospedaje</h1>
		<div class="col-md-23">
			<form accept-charset="UTF-8" action="hospedaje" class="simple_form"
				id="frmRegistroHospedaje" method="post">
				<input type="hidden" name="metodo" id="id_metodo" class="form-control" value=""/>
				<input type="hidden" name="idEliminaHabitacion" id="id_elimina" class="form-control"/>
				
				<div class="row contenedorHospedaje">
					<h3>Datos del Hospedaje</h3>
					<div class="">
						<div class="form-group">
							<label class="control-label" for="fechaIngreso">Fecha de ingreso</label>
							<input class="form-control" id="fechaIngreso" name="fechaIngreso"
								placeholder="Fecha de ingreso" type="date" />
						</div>
					</div>
					<div class="">
						<div class="form-group">
							<label class="control-label" for="fechaSalida">Fecha de salida</label>
							<input class="form-control" id="fechaSalida" name="fechaSalida"
								placeholder="Fecha de salida" type="date" />
						</div>
					</div>
					<div class="">
						<div class="form-group">
							<label class="control-label" for="cantidadDias">Cantidad de días</label>
							<input class="form-control" id="cantidadDias" name="cantidadDias"
								placeholder="# días" type="text" readonly/>
						</div>
					</div>
					
					<div class="">
						<div class="form-group">
							<label class="control-label" for="igv">IGV</label>
							<input class="form-control" id="igv" name="igv"
								placeholder="IGV" type="text" value="18" />
						</div>
					</div>
				</div>
				<!-- Cliente -->
				<div class="row contenedorCliente">
					<h3>Datos del cliente</h3>
					<div class="">
						<div class="form-group id-cliente half">
							<label class="control-label" for="id_codigoCliente">Código</label>
							<input class="form-control" id="id_codigoCliente" name="idCliente" type="text" readonly/>
						</div>
						<div class="form-group half">
							<label class="control-label" for="id_nombresCliente">Nombres</label>
							<input class="form-control" id="id_nombresCliente" name="nombresCliente" type="text" readonly />
						</div>
						<div class="form-group">
							<label class="control-label" for="id_apellidosCliente">Apellidos</label>
							<input class="form-control" id="id_apellidosCliente" name="apellidosCliente" type="text" readonly />
						</div>
						<div class="form-group">
							<label class="control-label" for="id_direccionCliente">Dirección</label>
							<input class="form-control" id="id_direccionCliente" name="direccionCliente" type="text" readonly />
						</div>
						<div class="form-group half">
							<label class="control-label" for="id_dniCliente">DNI</label>
							<input class="form-control" id="id_dniCliente" name="dniCliente" type="text" readonly />
						</div>
						<div class="form-group half">
							<label class="control-label" for="id_telefonoCliente">Teléfono</label>
							<input class="form-control" id="id_telefonoCliente" name="telefonoCliente" type="text" readonly />
						</div>
						<div class="form-group">
							<button id="btnModalBuscarCliente" class="btn btn-info">Buscar <span class="glyphicon glyphicon-search"></span></button>
							<button id="btnRegistrarCliente" class="btn btn-warning">Registrar <span class="glyphicon glyphicon-ok"></span></button>
						</div>
					</div>
				</div>
				<br /><br />
				<div class="row contenedorHabitaciones">
					<h3>Habitaciones</h3>					
					<div class="row">
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_codigoHabitacion">Código</label>
							<input class="form-control" id="id_codigoHabitacion" name="codigoHabitacion"
								placeholder="Código de Habitación" type="text" readonly/>
						</div>
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_numeroHabitacion">Número</label>
							<input class="form-control" id="id_numeroHabitacion" name="numeroHabitacion"
								placeholder="Número de habitación" type="text" readonly/>
						</div>
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_pisoHabitacion">Piso</label>
							<input class="form-control" id="id_pisoHabitacion" name="pisoHabitacion"
								placeholder="Número de piso" type="text" readonly/>
						</div>
						<div class="form-group col-sm-3">
							<button id="btnModalBuscarHabitacion" class="btn btn-success">Buscar Habitación <span class="glyphicon glyphicon-search"></span></button>
						</div>
					</div>
					<div class="row">
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_tipoHabitacion">Tipo</label>
							<input class="form-control" id="id_tipoHabitacion" name="tipoHabitacion"
								placeholder="Tipo" type="text" readonly/>
							<input id="id_idTipoHabitacion" name="idTipoHabitacion" type="hidden"/>
						</div>
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_categoriaHabitacion">Categoría</label>
							<input class="form-control" id="id_categoriaHabitacion" name="categoriaHabitacion" placeholder="Categoriía" type="text" readonly/>
							<input id="id_idCategoriaHabitacion" name="idCategoriaHabitacion" type="hidden"/>
						</div>
						<div class="form-group col-sm-3">
							<label class="control-label" for="id_costoHabitacion">Costo por día</label>
							<input class="form-control" id="id_costoHabitacion" name="costoHabitacion" placeholder="Costo" type="text" readonly/>
						</div>
						<div class="form-group col-sm-3">
							<button id="btnAgregarHabitacionADetalle" class="btn btn-primary">Agregar <span class="glyphicon glyphicon-plus"></span></button>
						</div>
					</div>
					
					<div class="row">
						<div class="form-group">
							<div class="col-lg-12">
								<table id="id_table_boleta" class="table table-striped table-bordered">
									<thead>
										<tr>
											<th>ID Habitación</th>
											<th>Número</th>
											<th>Piso</th>
											<th>Tipo</th>
											<th>Categoría</th>
											<th>Costo</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${sessionScope.dataDeGrillaHabitaciones}" var="x">
											<tr>
												<td>${x.idHabitacion}</td>
												<td>${x.numero}</td>
												<td>${x.piso}</td>
												<td>${x.tipo.descripcion}</td>
												<td>${x.categoria.descripcion}</td>
												<td>${x.costo}</td>
												<td>
													<button class="btn btn-danger btn-quitar-habitacion" type='button' data-toggle='modal' onclick="f_quitarHabitacion('${x.idHabitacion}');">
															<img class="btn-icon" src='images/delete.png' />
													</button>
												</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				
				</div>
				
			</form>
		</div>
	
		<div class="row">
			<div class="form-group col-sm-6">
				<button id="btnRegistrarHospedaje" class="btn btn-primary">REGISTRAR <span class="glyphicon glyphicon-upload"></span></button>
			</div>
			<div class="form-group col-sm-6">
				<button class="btn btn-danger">SALIR <span class="glyphicon glyphicon-off"></span></button>
			</div>
		</div>
	</div>

		
	
	<script type="text/javascript">
	
		function f_seleccionaCliente(cliente) {
			$("input[id=id_codigoCliente]").val(cliente.idCliente);
			$("input[id=id_nombresCliente]").val(cliente.nombres);
			$("input[id=id_apellidosCliente]").val(cliente.apellidos);
			$("input[id=id_dniCliente]").val(cliente.dni);
			$("input[id=id_direccionCliente]").val(cliente.direccion);
			$("input[id=id_telefonoCliente]").val(cliente.telefono);
			
			$("#modalBuscarCliente").modal("hide");
		}
		
		function f_seleccionaHabitacion(habitacion) {
			console.log(habitacion);
			$("input[id=id_codigoHabitacion]").val(habitacion.idHabitacion);
			$("input[id=id_numeroHabitacion]").val(habitacion.numero);
			$("input[id=id_pisoHabitacion]").val(habitacion.piso);
			$("input[id=id_tipoHabitacion]").val(habitacion.tipo);
			$("input[id=id_idTipoHabitacion]").val(habitacion.idTipo);
			$("input[id=id_categoriaHabitacion]").val(habitacion.categoria);
			$("input[id=id_idCategoriaHabitacion]").val(habitacion.idCategoria);
			$("input[id=id_costoHabitacion]").val(habitacion.costo);
			
			$("#modalBuscarHabitacion").modal("hide");
		}
		
		function f_agregarHabitacion() {
			console.log("f_agregarHabitacion");
			$('input[id=id_metodo]').val("agregarSeleccion");
			$("#frmRegistroHospedaje").submit();
		}
		
		function f_agregarRegistrarHospedaje() {
			console.log("f_agregarRegistrarHospedaje");
			$('input[id=id_metodo]').val("registrarHospedaje");
			$("#frmRegistroHospedaje").submit();
		}
		
		function f_quitarHabitacion(id){	
			$('input[id=id_metodo]').val("eliminarSeleccion");
			$('input[id=id_elimina]').val(id);
			$("#frmRegistroHospedaje").submit();
		}
		
		function cantidadDiasEntreFechas(fechaInicial, fechaFinal) {
			var fecha2 = moment(fechaInicial);
			var fecha1 = moment(fechaFinal);
			return fecha1.diff(fecha2, 'days');
		}
	
		$(document).ready(function() {
			
			$("#fechaIngreso, #fechaSalida").on("change", function() {
				var dias = cantidadDiasEntreFechas($("#fechaIngreso").val(), $("#fechaSalida").val());
				console.log(dias);
				if (!isNaN(dias)) {
					$("#cantidadDias").val(dias);					
				} else {
					$("#cantidadDias").val(0);
				}
			});
			
			$("#btnRegistrarCliente").on("click", function(e) {
				e.preventDefault();
				window.open("./CrudCliente.jsp");
			});
			
			$("#btnModalBuscarCliente").on("click", function(e) {
				e.preventDefault();
				$("#modalBuscarCliente").modal();
			});
			
			$("#btnModalBuscarHabitacion").on("click", function(e) {
				e.preventDefault();
				$("#modalBuscarHabitacion").modal();
			});
			
			$("#btnAgregarHabitacionADetalle").on("click", function(e) {
				e.preventDefault();
				f_agregarHabitacion();
			});
			
			$("#btnRegistrarHospedaje").on("click", function(e) {
				e.preventDefault();
				f_agregarRegistrarHospedaje();
			});
			
			// $('#tableCliente').DataTable();
			
			$('#frmCliente').bootstrapValidator({
		        message: 'This value is not valid',
		        excluded: ':disabled',
		        feedbackIcons: {
		            valid: 'glyphicon glyphicon-ok',
		            invalid: 'glyphicon glyphicon-remove',
		            validating: 'glyphicon glyphicon-refresh'
		        },
		        fields: {

		        }
		    }).on('error.form.bv', function(e) {
	            console.log('error');

	            // Active the panel element containing the first invalid element
	            var $form = $(e.target),
	                validator = $form.data('bootstrapValidator'),
	                $invalidField = validator.getInvalidFields().eq(0),
	                $collapse = $invalidField.parents('.collapse');
	            $collapse.collapse('show');
	        });
			
		});
	</script>
	<jsp:include page="BuscarCliente.jsp" />
	<jsp:include page="BuscarHabitacion.jsp" />
</body>
</html>
