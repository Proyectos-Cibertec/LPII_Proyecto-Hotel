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

<!-- Modal Buscar Cliente -->
<div class="modal fade" id="modalBuscarCliente">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header" style="padding: 35px 50px">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4>Búsqueda de Clientes</h4>
            </div>
            <div class="modal-body" style="padding: 20px 10px;">
                <div class="panel-group" id="steps">
                    <div class="panel panel-default">
                    	<!-- Filtro: descripcion -->
                       	<div class="col-lg-12 bloque-filtro">
                        	<div class="form-group">
	                            <label class="col-lg-3 control-label" for="id_apellidos_buscar">Apellidos</label>
	                            <div class="col-lg-6">
	                                <input id="id_apellidos_buscar" class="form-control" name="apellidos" type="text" />
	                            </div>
	                            <div class="col-lg-3">
	                            	<button id="btnBuscarCliente" class="btn btn-info">BUSCAR</button>
	                            </div>
	                        </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-12">
                                <table id="id_table_cliente" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                        	<th></th>
                                            <th>ID</th>
                                            <th>NOMBRES</th>
                                            <th>APELLIDOS</th>
                                            <th>DNI</th>
                                            <th>DIRECCIÓN</th>
                                            <th>TELÉFONO</th>
                                            <th>FECHA DE NACIMIENTO</th>
                                            <th>FECHA DE REGISTRO</th>
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
		$("#btnBuscarCliente").on("click", function() {
			$('#id_table_cliente tbody').remove();
			
			var apellidos = $("#id_apellidos_buscar").val();
			var parametros = {"metodo": "buscarXApellido", "apellidos": apellidos};
			  
			$.getJSON("cliente", parametros, function (data, status, xh) {
				console.log(data);
				$.each(data, function(index, cliente) {
					$('#id_table_cliente').append(
						"<tr>"+
							"<td><a id='" + cliente.idCliente + "agrega' class='btn btn-success' style='background-color: hsla(233, 100%, 100%, 0)'><img src='images/edit.png' /></a></td>"+
							"<td>" + cliente.idCliente + "</td>" +
							"<td>" + cliente.nombres + "</td>" +
							"<td>" + cliente.apellidos + "</td>" +
							"<td>" + cliente.dni + "</td>" +
							"<td>" + cliente.direccion + "</td>" +
							"<td>" + cliente.telefono + "</td>" +
							"<td>" + cliente.fechaNacimiento + "</td>" +
							"<td>" + cliente.fechaRegistro + "</td>" +							
						+ "</tr>");
					
					$("#" + cliente.idCliente + "agrega").on("click", function() {
						console.log(cliente);
						f_seleccionaCliente(cliente);
					});
				});
			});
			  
		});
	});
</script>