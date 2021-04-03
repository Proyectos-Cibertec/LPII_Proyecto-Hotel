<jsp:include page="sistemaValida.jsp" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql" %>

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

        <title>MANTENIMIENTO DE HABITACIONES</title>
    </head>

    <body>
    <jsp:include page="cabecera.jsp" />
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

        <div class="container">
            <h1>Mantenimiento de Habitaciones</h1>
            <div class="col-md-23">


                <form id="idFormElimina" action="habitacion">
                    <input type="hidden" name="metodo" value="elimina">
                    <input type="hidden" id="id_elimina" name="idHabitacion">
                </form>

                <form accept-charset="UTF-8" action="habitacion" class="simple_form" id="defaultForm2" method="post">
                    <input type="hidden" name="metodo" value="consulta">
                    <div class="row primeraFila">
                        <div class="col-md-3">
                            <div class="form-group">
                            	<!-- Filtro de Habitaciones por el número de piso -->
                                <label class="control-label" for="id_piso_filtro">PISO</label>
                                <input class="form-control" id="id_piso_filtro" name="filtro" placeholder="Ingrese el Nº de Piso" type="number" min="1" />
                            </div>
                        </div>
                        
                        <div class="col-md-3">
							<div class="form-group">
                            	<button type="submit" class="btn btn-success btn-filtrar" id="btnFiltrar">
                            		<span class="glyphicon glyphicon-filter"></span> FILTRAR
                            	</button>
                            </div>                            
                        </div>
                        <div class="col-md-3">
                            <button type="button" data-toggle='modal' onclick="mostrarModalRegistrar();" class='btn btn-primary btn-nuevo' id="">
                            	<span class="glyphicon glyphicon-plus-sign"></span> NUEVA HABITACIÓN
                            </button>
                            <br>&nbsp;<br>
                        </div>
                    </div>                    
                    <div class="row">
                        <div class="col-md-12">
                            <div class="content">
                                <table id="tablaPrincipal" class="table table-striped table-bordered">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>NÚMERO</th>
                                            <th>PISO</th>
                                            <th>TIPO</th>
                                            <th>CATEGORÍA</th>
                                            <th>ESTADO</th>
                                            <th>COSTO POR NOCHE</th>
                                            <th>ACTUALIZAR</th>
                                            <th>ELIMINAR</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${habitaciones}" var="x">
                                            <!-- parametro de la parte final del metodo-->
                                            <tr>
                                                <td>${x.idHabitacion}</td>
                                                <td>${x.numero}</td>
                                                <td>${x.piso}</td>
                                                <td>${x.tipo.descripcion}</td>
                                                <td>${x.categoria.descripcion}</td>
                                                <td>${x.estado.descripcion}</td>
                                                <td>${x.costo}</td>
                                                <!-- Actualizar -->
                                                <td>
                                                    <button type='button' data-toggle='modal' class=' btn btn-success btn-actualizar' 
                                                    	onclick="mostrarModalEditar(
                                                    		'${x.idHabitacion}',
                                                    		'${x.numero}',
                                                    		'${x.piso}',
                                                    		'${x.tipo.idTipo}',
                                                    		'${x.categoria.idCategoria}',
                                                    		'${x.estado.idEstado}',
                                                    		'${x.costo}');"> <img class="btn-image-icon" src='images/edit.png' />
												</button>
                                                </td>
                                                <!-- Eliminar -->
                                                <td>
                                                    <button type='button' data-toggle='modal' class="btn btn-danger btn-eliminar" onclick="eliminar('${x.idHabitacion}');"> <img class="btn-image-icon" src='images/delete.png' />
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

            <!-- Modal Registra -->
            <div class="modal fade" id="modalRegistrar">
                <div class="modal-dialog">

                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4>
                                Registro de Habitaciones
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form id="formRegistrar" accept-charset="UTF-8" action="habitacion" class="form-horizontal" method="post">
                                <input type="hidden" name="metodo" value="registra">
                                <div class="panel-group" id="steps">
                                    <!-- Step 1 -->
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#steps" href="#panelRegistrar">Datos de la Habitación</a>
                                            </h4>
                                        </div>
                                        <div id="panelRegistrar" class="panel-collapse collapse in">
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_numero">Número de Habitación</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_numero" name="numero" placeholder="Ingrese el número de habitación" 
                                                        	type="number" min="1" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_piso">Número de Piso</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_piso" name="piso" placeholder="Ingrese el número de piso" 
                                                        	type="number" min="1" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
													<label class="col-lg-3 control-label" for="id_tipo" >Tipo de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_tipo" name="tipo" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Tipo]</option>
															<c:forEach var="x" items="${ListaTipoHabitacion.rows}" >
																<option value="${x.idTipo}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-lg-3 control-label" for="id_categoria" >Categoría de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_categoria" name="categoria" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Categoría]</option>
															<c:forEach var="x" items="${ListaCategoriaHabitacion.rows}" >
																<option value="${x.idCategoria}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-lg-3 control-label" for="id_estado">Estado de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_estado" name="estado" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Estado]</option>
															<c:forEach var="x" items="${ListaEstadoHabitacion.rows}" >
																<option value="${x.idEstado}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_costo">Costo por noche</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_costo" name="costo" type="text" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-lg-6 col-lg-offset-3">
                                                        <button type="submit" class="btn btn-primary btn-registrar"><span class="glyphicon glyphicon-floppy-disk"></span> REGISTRAR</button>
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <button id="btnLimpiar" type="button" class="btn btn-warning btn-limpiar"><span class="glyphicon glyphicon-refresh"></span> LIMPIAR</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!--  Fin del modal -->

            <!--  Modal actualiza -->
            <div class="modal fade" id="modalActualizar">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4>
                                Actualizar datos del cliente
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form id="formActualizar" accept-charset="UTF-8" action="habitacion" class="form-horizontal" method="post">
                                <input type="hidden" name="metodo" value="actualiza">
                                <div class="panel-group" id="steps">
                                    <!-- Step 1 -->
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#steps" href="#panelActualizarDatos">Actualizar datos del cliente</a>
                                            </h4>
                                        </div>
                                        <div id="panelActualizarDatos" class="panel-collapse collapse in">
                                            <div class="panel-body">

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_idHabitacion_actualiza">ID</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_idHabitacion_actualiza" readonly="readonly" name="idHabitacion" type="text" maxlength="8" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_numero_actualiza">Número de Habitación</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_numero_actualiza" name="numero" placeholder="Ingrese el número de habitación" 
                                                        	type="number" min="1" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_piso_actualiza">Número de Piso</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_piso_actualiza" name="piso" placeholder="Ingrese el número de piso" 
                                                        	type="number" min="1" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                
                                                <div class="form-group">
													<label class="col-lg-3 control-label" for="id_tipo_actualiza" >Tipo de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_tipo_actualiza" name="tipo" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Tipo]</option>
															<c:forEach var="x" items="${ListaTipoHabitacion.rows}" >
																<option value="${x.idTipo}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-lg-3 control-label" for="id_categoria_actualiza" >Categoría de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_categoria_actualiza" name="categoria" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Categoría]</option>
															<c:forEach var="x" items="${ListaCategoriaHabitacion.rows}" >
																<option value="${x.idCategoria}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
												
												<div class="form-group">
													<label class="col-lg-3 control-label" for="id_estado_actualiza">Estado de Habitación</label>
													<div class="col-lg-6">
														<select class="form-control changeValidate" id="id_estado_actualiza" name="estado" data-bv-trigger="change keyup">
															<option value=" ">[Seleccione Estado]</option>
															<c:forEach var="x" items="${ListaEstadoHabitacion.rows}" >
																<option value="${x.idEstado}">${x.descripcion}</option>
															</c:forEach>
														</select>
													</div>
												</div>
                                                
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_costo_actualiza">Costo por noche</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_costo_actualiza" name="costo" type="text" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <div class="col-lg-6 col-lg-offset-3">
                                                        <button type="submit" class="btn btn-primary">ACTUALIZA</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script type="text/javascript">
            Date.prototype.toDateInputValue = (function() {
                var local = new Date(this);
                local.setMinutes(this.getMinutes() - this.getTimezoneOffset());
                return local.toJSON().slice(0, 10);
            });

            function fechaHoy() {
                return new Date().toDateInputValue();
            }

            function limpiarTodasLasEntradas() {
                limpiarEntradas();
                $(".changeValidate").change(); // Para que se validen luego de ser limpiados y el validator siga funcionando correctamente
            }

            function limpiarEntradas() {
                $("#id_numero").val("");
                $("#id_piso").val("");
                $("#id_tipo option[value=' ']").prop('selected', 'selected');
                $("#id_categoria option[value=' ']").prop('selected', 'selected');
                $("#id_estado option[value=' ']").prop('selected', 'selected');
                $("#id_costo").val("");

                $(".changeValidate").change();
            }

            function mostrarModalRegistrar() {
                $('#modalRegistrar').modal("show");
            }

            function mostrarModalEditar(idHabitacion, numero, piso, tipo, categoria, estado, costo) {
                $('input[id=id_idHabitacion_actualiza]').val(idHabitacion);
                $('input[id=id_numero_actualiza]').val(numero);
                $('input[id=id_piso_actualiza]').val(piso);
                $('select[id=id_tipo_actualiza]').val(tipo);
                $('select[id=id_categoria_actualiza]').val(categoria);
                $('select[id=id_estado_actualiza]').val(estado);
                $('input[id=id_costo_actualiza]').val(costo);
                $(".changeValidate").change();

                $('#modalActualizar').modal("show");
            }

            function eliminar(idHabitacion) {
                //eliminar esta Arriba Hidden oculto
                
                swal({
                    title: 'Está seguro que desea eliminar la Habitación?',
                    text: "No podrás revertirlo después!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí'
                }).then((result) => {
                    if (result.value) {
                    	$('input[id=id_elimina]').val(idHabitacion);
                        $('#idFormElimina').submit();
                        
                        swal(
                            'Eliminado!',
                            'La habitación fue eliminada',
                            'success'
                        )
                    }
                })
            }

            $(document).ready(function() {

                $("#btnLimpiar").on("click", function() {
                    limpiarTodasLasEntradas();
                });

                $('#tablaPrincipal').DataTable();

                $('#formActualizar, #formRegistrar, #defaultForm2').bootstrapValidator({
                    message: 'This value is not valid',
                    excluded: ':disabled',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                    	numero: {
                            message: 'El campo número de habitación no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo número de habitación es requerido'
                                },
                                digits: {
            		                message: 'El número de habitación es entero'
            		            },
            		            lessThan: {
            		                value: 30,
            		                inclusive: true,
            		                message: 'Máximo 30'
            		            },
            		            greaterThan: {
            		                value: 1,
            		                inclusive: true,
            		                message: 'Mínimo 1'
            		            }
                            }
                        },
                        filtro: {
                        	message: 'El campo filtro no es válido',
                            validators: {
                                digits: {
            		                message: 'El piso de habitación es entero'
            		            },
            		            lessThan: {
            		                value: 30,
            		                inclusive: true,
            		                message: 'Máximo 30'
            		            },
            		            greaterThan: {
            		                value: 1,
            		                inclusive: true,
            		                message: 'Mínimo 1'
            		            }
                            }
                        },
                        piso: {
                            message: 'El campo piso no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo piso es requerido'
                                },
                                digits: {
            		                message: 'El piso de habitación es entero'
            		            },
            		            lessThan: {
            		                value: 30,
            		                inclusive: true,
            		                message: 'Máximo 30'
            		            },
            		            greaterThan: {
            		                value: 1,
            		                inclusive: true,
            		                message: 'Mínimo 1'
            		            }
                            }
                        },
                        tipo: {
                            validators: {
                                notEmpty: {
                                    message: 'El tipo de habitación es un campo obligatorio'
                                }
                            }
                        },
                        categoria: {
                            validators: {
                                notEmpty: {
                                    message: 'La categoría de habitación es un campo obligatorio'
                                }
                            }
                        },
                        estado: {
                            validators: {
                                notEmpty: {
                                    message: 'El estado de habitación es un campo obligatorio'
                                }
                            }
                        },
                        costo: {
                            message: 'El costo no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo costo es requerido'
                                },
                                regexp: {
                                    regexp: /^[0-9\.]+$/,
                                    message: 'El costo es real'
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