<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>
<style>
	.bloque-filtro {
	    margin: 20px 0px;
	}
	
	.bloque-filtro label {
		text-align: right;
	}
	
	.bloque-filtro input[type='text'],
	.bloque-filtro button {
		margin-bottom: 5px;
	}
	
	.panel {
	    overflow-x: auto !important;
	}
</style>

<!-- Conexión a la BD -->
<sql:setDataSource driver="com.mysql.jdbc.Driver" 
	url="jdbc:mysql://localhost:3306/hotel" user="root"
	password="mysql"
	var="MiConexion"/>
	
<!-- SQL listado de Tipos de Habitacion -->
<sql:query var="ListaTipoHabitacion" dataSource="${MiConexion}">
	SELECT * FROM tipo_habitacion
</sql:query>

<!-- SQL listado de Categorías de Habitacion -->
<sql:query var="ListaCategoriaHabitacion" dataSource="${MiConexion}">
	SELECT * FROM categoria_habitacion
</sql:query>

<!-- SQL listado de Estado de Habitacion -->
<sql:query var="ListaEstadoHabitacion" dataSource="${MiConexion}">
	SELECT * FROM estado_habitacion
</sql:query>
<!-- Modal Buscar Cliente -->
<div class="modal fade" id="modalBuscarHabitacion">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 35px 50px">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>Búsqueda de Habitaciones</h4>
            </div>
            <div class="modal-body" style="padding: 20px 10px;">
                <div class="panel-group" id="steps">
                    <div class="panel panel-default">
                    	<!-- Filtro: descripcion -->
                        <div class="col-lg-12 bloque-filtro">
                        	<div class="form-group">
	                            <label class="col-lg-6 control-label" for="id_tipo_buscar">Tipo</label>
	                            <div class="col-lg-6">
	                                <select class="form-control" id="id_tipo_buscar" name="tipo">
										<option value="">[Seleccione Tipo]</option>
										<c:forEach var="x" items="${ListaTipoHabitacion.rows}" >
											<option value="${x.descripcion}">${x.descripcion}</option>
										</c:forEach>
									</select>
	                            </div>
	                            
	                            <label class="col-lg-6 control-label" for="id_categoria_buscar">Categoría</label>
	                            <div class="col-lg-6">
	                                <select class="form-control" id="id_categoria_buscar" name="categoria">
										<option value="">[Seleccione Categoría]</option>
										<c:forEach var="x" items="${ListaCategoriaHabitacion.rows}" >
											<option value="${x.descripcion}">${x.descripcion}</option>
										</c:forEach>
									</select>
	                            </div>
	                            
	                            <label class="col-lg-6 control-label" for="id_estado_buscar">Estado</label>
	                            <div class="col-lg-6">
	                                <select class="form-control" id="id_estado_buscar" name="estado">
										<option value="">[Seleccione Estado]</option>
										<c:forEach var="x" items="${ListaEstadoHabitacion.rows}" >
											<option value="${x.descripcion}">${x.descripcion}</option>
										</c:forEach>
									</select>
	                            </div>
	                            <div class="col-lg-offset-6 col-lg-6">
	                            	<button id="btnBuscarHabitacion" class="btn btn-info">BUSCAR</button>
	                            </div>
	                        </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <table id="id_table_habitacion" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                        	<th></th>
                                            <th>ID</th>
                                            <th>NÚMERO</th>
                                            <th>PISO</th>
                                            <th>TIPO</th>
                                            <th>CATEGORÍA</th>
                                            <th>ESTADO</th>
                                            <th>COSTO</th>
                                        </tr>
                                    </thead>
                                    <tbody>
										
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
<script>
	$(document).ready(function() {
		$("#btnBuscarHabitacion").on("click", function() {
			$('#id_table_habitacion tbody').remove();
			
			var tipo = $("#id_tipo_buscar").val();
			var categoria = $("#id_categoria_buscar").val();
			var estado = $("#id_estado_buscar").val();
			
			var parametros = {
					"metodo": "buscarHabitacionXTipoCategoriaEstado", 
					"tipo": tipo,
					"categoria": categoria,
					"estado": estado};
			  
			$.getJSON("habitacion", parametros, function (data, status, xh) {
				console.log(data);
				// $('#id_table_habitacion').empty()
				$.each(data, function(index, habitacion) {
					
					$('#id_table_habitacion').append(
						"<tr>"+
							"<td><a id='habitacion" + habitacion.idHabitacion + "agrega' class='btn btn-success' style='background-color: hsla(233, 100%, 100%, 0)'><img src='images/edit.png' /></a></td>"+
							"<td>" + habitacion.idHabitacion + "</td>" +
							"<td>" + habitacion.numero + "</td>" +
							"<td>" + habitacion.piso + "</td>" +
							"<td>" + habitacion.tipo + "</td>" +
							"<td>" + habitacion.categoria + "</td>" +
							"<td>" + habitacion.estado + "</td>" +
							"<td>" + habitacion.costo + "</td>" +
						+ "</tr>");
					
					$("#habitacion" + habitacion.idHabitacion + "agrega").on("click", function() {
						console.log(habitacion);
						f_seleccionaHabitacion(habitacion);
					});
				});
			});
			  
		});
	});
</script>