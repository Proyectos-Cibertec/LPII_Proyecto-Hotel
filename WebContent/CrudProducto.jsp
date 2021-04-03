<jsp:include page="sistemaValida.jsp" />
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
    <%@ taglib uri="http://java.sun.com/jstl/sql_rt" prefix="sql"%>
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

            <title>MANTENIMIENTO DE PRODUCTOS</title>
        </head>

        <body>
        	<jsp:include page="cabecera.jsp" />
            <!-- Conexión a la BD -->
            <sql:setDataSource driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/hotel" user="root" password="mysql" var="MiConexion" />

            <!-- SQL listado de Servicios -->
            <sql:query var="ListaServicio" dataSource="${MiConexion}">
                SELECT * FROM servicio
            </sql:query>
            <div class="container">
                <h1>Mantenimiento de PRODUCTOS</h1>
                <div class="col-md-23">


                    <form id="idFormElimina" action="producto">
                        <input type="hidden" name="metodo" value="elimina"> <input type="hidden" id="id_elimina" name="idProducto">
                    </form>

                    <form accept-charset="UTF-8" action="producto" class="simple_form" id="defaultForm2" method="post">
                        <input type="hidden" name="metodo" value="consulta">
                        <div class="row primeraFila">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <!-- Filtro de Productos por la descripcion-->
                                    <label class="control-label" for="id_descripcion_filtro">DESCRIPCIÓN</label>
                                    <input class="form-control" id="id_descripcion_filtro" name="filtro" placeholder="Ingrese la descripción del producto" type="text" />
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
							<span class="glyphicon glyphicon-plus-sign"></span> NUEVO
							PRODUCTO
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
                                                <th>DESCRIPCIÓN</th>
                                                <th>COSTO</th>
                                                <th>SERVICIO</th>
                                                <th>ACTUALIZAR</th>
                                                <th>ELIMINAR</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${productos}" var="x">
                                                <!-- parametro de la parte final del metodo-->
                                                <tr>
                                                    <td>${x.idProducto}</td>
                                                    <td>${x.descripcion}</td>
                                                    <td>${x.costo}</td>
                                                    <td>${x.servicio.nombre}</td>
                                                    <!-- Actualizar -->
                                                    <td>
                                                        <button type='button' data-toggle='modal' class=' btn btn-success btn-actualizar' onclick="mostrarModalEditar(
                                                    		'${x.idProducto}',
                                                    		'${x.descripcion}',
                                                    		'${x.costo}',
                                                    		'${x.servicio.idServicio}');">
													<img class="btn-image-icon" src='images/edit.png' />
												</button>
                                                    </td>
                                                    <!-- Eliminar -->
                                                    <td>
                                                        <button type='button' data-toggle='modal' class="btn btn-danger btn-eliminar" onclick="eliminar('${x.idProducto}');">
													<img class="btn-image-icon" src='images/delete.png' />
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
                                <h4>Registro de Productos</h4>
                            </div>
                            <div class="modal-body">
                                <form id="formRegistrar" accept-charset="UTF-8" action="producto" class="form-horizontal" method="post">
                                    <input type="hidden" name="metodo" value="registra">
                                    <div class="panel-group" id="steps">
                                        <!-- Step 1 -->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#steps" href="#panelRegistrar">Datos del Producto</a>
                                                </h4>
                                            </div>
                                            <div id="panelRegistrar" class="panel-collapse collapse in">
                                                <div class="panel-body">
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_descripcion">Descripción</label>
                                                        <div class="col-lg-6">
                                                            <input class="form-control changeValidate" id="id_descripcion" name="descripcion" placeholder="Ingrese descripción" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_costo">Costo</label>
                                                        <div class="col-lg-6">
                                                            <input class="form-control changeValidate" id="id_costo" name="costo" placeholder="Ingrese el costo" type="text" data-bv-trigger="change keyup" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_servicio">Tipo de Servicio</label>
                                                        <div class="col-lg-6">
                                                            <select class="form-control changeValidate" id="id_servicio" name="idServicio" data-bv-trigger="change keyup">
														<option value=" ">[Seleccione Servicio]</option>
														<c:forEach var="x" items="${ListaServicio.rows}">
															<option value="${x.idServicio}">${x.nombre}</option>
														</c:forEach>
													</select>
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <div class="col-lg-6 col-lg-offset-3">
                                                            <button type="submit" class="btn btn-primary btn-registrar"><span class="glyphicon glyphicon-floppy-disk"></span>
														REGISTRAR
													</button>
                                                        </div>
                                                        <div class="col-lg-3">
                                                            <button id="btnLimpiar" type="button" class="btn btn-warning btn-limpiar">
														<span class="glyphicon glyphicon-refresh"></span> LIMPIAR
													</button>
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
                                <h4>Actualizar datos de producto</h4>
                            </div>
                            <div class="modal-body">
                                <form id="formActualizar" accept-charset="UTF-8" action="producto" class="form-horizontal" method="post">
                                    <input type="hidden" name="metodo" value="actualiza">
                                    <div class="panel-group" id="steps">
                                        <!-- Step 1 -->
                                        <div class="panel panel-default">
                                            <div class="panel-heading">
                                                <h4 class="panel-title">
                                                    <a data-toggle="collapse" data-parent="#steps" href="#panelActualizarDatos">Actualizar datos de
												producto</a>
                                                </h4>
                                            </div>
                                            <div id="panelActualizarDatos" class="panel-collapse collapse in">
                                                <div class="panel-body">

                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_idProducto_actualiza">ID</label>
                                                        <div class="col-lg-6">
                                                            <input class="form-control changeValidate" id="id_idProducto_actualiza" readonly="readonly" name="idProducto" type="text" maxlength="8" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_descripcion_actualiza">Descripción</label>
                                                        <div class="col-lg-6">
                                                            <input class="form-control changeValidate" id="id_descripcion_actualiza" name="descripcion" placeholder="Ingrese descripción" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                        </div>
                                                    </div>

                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_costo_actualiza">Costo</label>
                                                        <div class="col-lg-6">
                                                            <input class="form-control changeValidate" id="id_costo_actualiza" name="costo" placeholder="Ingrese el costo" type="text" data-bv-trigger="change keyup" />
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label class="col-lg-3 control-label" for="id_servicio_actualiza">Tipo de Servicio</label>
                                                        <div class="col-lg-6">
                                                            <select class="form-control changeValidate" id="id_servicio_actualiza" name="idServicio" data-bv-trigger="change keyup">
																<option value=" ">[Seleccione Servicio]</option>
																<c:forEach var="x" items="${ListaServicio.rows}">
																	<option value="${x.idServicio}">${x.nombre}</option>
																</c:forEach>
															</select>
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
                    $("#id_descripcion").val("");
                    $("#id_costo").val("");
                    $("#id_servicio option[value=' ']").prop('selected', 'selected');

                    $(".changeValidate").change();
                }

                function mostrarModalRegistrar() {
                    $('#modalRegistrar').modal("show");
                }

                function mostrarModalEditar(idProducto, descripcion, costo, idServicio) {
                    $('input[id=id_idProducto_actualiza]').val(idProducto);
                    $('input[id=id_descripcion_actualiza]').val(descripcion);
                    $('input[id=id_costo_actualiza]').val(costo);
                    $('select[id=id_servicio_actualiza]').val(idServicio);
                    $(".changeValidate").change();

                    $('#modalActualizar').modal("show");
                }

                function eliminar(idProducto) {
                    //eliminar esta Arriba Hidden oculto

                    swal({
                        title: 'Está seguro que desea eliminar el Producto?',
                        text: "No podrás revertirlo después!",
                        type: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#3085d6',
                        cancelButtonColor: '#d33',
                        confirmButtonText: 'Sí'
                    }).then((result) => {
                        if (result.value) {
                            $('input[id=id_elimina]').val(idProducto);
                            $('#idFormElimina').submit();

                            swal(
                                'Eliminado!',
                                'El producto fue eliminado',
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
                            filtro: {
                                message: 'El campo no es válido',
                                validators: {
                                    stringLength: {
                                        min: 0,
                                        max: 45,
                                        message: 'El campo no puede aceptar más de 45 caracteres'
                                    }
                                }
                            },
                            descripcion: {
                                message: 'El campo descripción no es válido',
                                validators: {
                                    notEmpty: {
                                        message: 'El campo descripcion es requerido'
                                    },
                                    stringLength: {
                                        min: 3,
                                        max: 45,
                                        message: 'El campo descripcion requiere de 3 a 45 caracteres'
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
                            },
                            idServicio: {
                                validators: {
                                    notEmpty: {
                                        message: 'El Servicio es un campo obligatorio'
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