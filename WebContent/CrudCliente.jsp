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

        <title>MANTENIMIENTO DE CLIENTES</title>
    </head>

    <body>
		<jsp:include page="cabecera.jsp" />
        <div class="container">
            <h1>Mantenimiento de Clientes</h1>
            <div class="col-md-23">


                <form id="idFormElimina" action="cliente">
                    <input type="hidden" name="metodo" value="elimina">
                    <input type="hidden" id="id_elimina" name="idCliente">
                </form>

                <form accept-charset="UTF-8" action="cliente" class="simple_form" id="defaultForm2" method="post">
                    <input type="hidden" name="metodo" value="consulta">
                    <div class="row primeraFila">
                        <div class="col-md-3">
                            <div class="form-group">
                                <label class="control-label" for="id_nombre_filtro">DNI</label>
                                <input class="form-control" id="id_nombre_filtro" name="filtro" placeholder="Ingrese el DNI" type="text" maxlength="8" />
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
                            	<span class="glyphicon glyphicon-plus-sign"></span> NUEVO CLIENTE
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
                                            <th>NOMBRES</th>
                                            <th>APELLIDOS</th>
                                            <th>DNI</th>
                                            <th>DIRECCIÓN</th>
                                            <th>TELÉFONO</th>
                                            <th>FECHA DE NACIMIENTO</th>
                                            <th>FECHA DE REGISTRO</th>
                                            <th>ACTUALIZAR</th>
                                            <th>ELIMINAR</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${clientes}" var="x">
                                            <!-- parametro de la parte final del metodo-->
                                            <tr>
                                                <td>${x.id}</td>
                                                <td>${x.nombres}</td>
                                                <td>${x.apellidos}</td>
                                                <td>${x.dni}</td>
                                                <td>${x.direccion}</td>
                                                <td>${x.telefono}</td>
                                                <td>${x.fechaNacimiento}</td>
                                                <td>${x.fechaRegistro}</td>
                                                <!-- Actualizar -->
                                                <td>
                                                    <button type='button' data-toggle='modal' class=' btn btn-success btn-actualizar' 
                                                    	onclick="mostrarModalEditar('${x.id}','${x.nombres}','${x.apellidos}','${x.dni}','${x.direccion}','${x.telefono}','${x.fechaNacimiento}','${x.fechaRegistro}');"> <img class="btn-image-icon" src='images/edit.png' />
												</button>
                                                </td>
                                                <!-- Eliminar -->
                                                <td>
                                                    <button type='button' data-toggle='modal' class="btn btn-danger btn-eliminar" onclick="eliminar('${x.id}');"> <img class="btn-image-icon" src='images/delete.png' />
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
                                Registro de Clientes
                            </h4>
                        </div>
                        <div class="modal-body">
                            <form id="formRegistrar" accept-charset="UTF-8" action="cliente" class="form-horizontal" method="post">
                                <input type="hidden" name="metodo" value="registra">
                                <input type="hidden" id="tipoRegistro" name="tipoRegistro" value="default">
                                <input type="hidden" id="id_persona" name="idPersona">
                                <div class="panel-group" id="steps">
                                    <!-- Step 1 -->
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title">
                                                <a data-toggle="collapse" data-parent="#steps" href="#panelRegistrar">Datos del Cliente</a>
                                            </h4>
                                        </div>
                                        <div id="panelRegistrar" class="panel-collapse collapse in">
                                            <div class="panel-body">
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_dni">DNI</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_dni" name="dni" placeholder="Ingrese el DNI" type="text" maxlength="8" data-bv-trigger="change keyup" />
                                                    </div>
                                                    <div class="col-lg-3">
                                                        <button id="btnBuscarPersona" type="button" class="btn btn-info btn-buscar"><span class="glyphicon glyphicon-search"></span> BUSCAR</button>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_nombres">Nombres</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_nombres" name="nombres" placeholder="Ingrese nombres" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_apellidos">Apellidos</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_apellidos" name="apellidos" placeholder="Ingrese los apellidos" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_direccion">Direccion</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_direccion" name="direccion" placeholder="Ingrese la Direccion" type="text" maxlength="100" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_telefono">Teléfono</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_telefono" name="telefono" placeholder="Ingrese el número de telefono" type="text" maxlength="12" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaNacimiento">Fecha de Nacimiento</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_fechaNacimiento" name="fechaNacimiento" type="date" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaRegistro">Fecha de Registro</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_fechaRegistro" name="fechaRegistro" type="date" data-bv-trigger="change keyup" />
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
                            <form id="formActualizar" accept-charset="UTF-8" action="cliente" class="form-horizontal" method="post">
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
                                                    <label class="col-lg-3 control-label" for="id_idCliente_actualiza">ID</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_idCliente_actualiza" readonly="readonly" name="idCliente" type="text" maxlength="8" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_nombres_actualiza">Nombres</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_nombres_actualiza" name="nombres" placeholder="Ingrese nombres" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_apellidos_actualiza">Apellidos</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_apellidos_actualiza" name="apellidos" placeholder="Ingrese los apellidos" type="text" maxlength="45" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_dni_actualiza">DNI</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_dni_actualiza" name="dni" placeholder="Ingrese el DNI" type="text" maxlength="8" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_direccion_actualiza">Direccion</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_direccion_actualiza" name="direccion" placeholder="Ingrese la Direccion" type="text" maxlength="100" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_telefono_actualiza">Teléfono</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_telefono_actualiza" name="telefono" placeholder="Ingrese el número del Telefono" type="text" maxlength="12" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaNacimiento_actualiza">Fecha de Nacimiento</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_fechaNacimiento_actualiza" name="fechaNacimiento" type="date" data-bv-trigger="change keyup" />
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label class="col-lg-3 control-label" for="id_fechaRegistro_actualiza">Fecha de Registro</label>
                                                    <div class="col-lg-6">
                                                        <input class="form-control changeValidate" id="id_fechaRegistro_actualiza" name="fechaRegistro" type="date" data-bv-trigger="change keyup" />
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
                $("#id_dni").val("");
                limpiarEntradas();
                $(".changeValidate").change(); // Para que se validen luego de ser limpiados y el validator siga funcionando correctamente
            }

            function limpiarEntradas() {
                $("#id_nombres").val("");
                $("#id_apellidos").val("");
                $("#id_direccion").val("");
                $("#id_telefono").val("");
                $("#id_fechaNacimiento").val("");
                $("#id_fechaRegistro").val(fechaHoy);

                $(".changeValidate").change();
            }

            function mostrarModalRegistrar() {
                $('#modalRegistrar').modal("show");
                $("#id_fechaRegistro").val(fechaHoy);
                $("#id_fechaRegistro").change();
            }

            function mostrarModalEditar(idCliente, nombres, apellidos, dni, direccion, telefono, fechaNacimiento, fechaRegistro) {
                $('input[id=id_idCliente_actualiza]').val(idCliente); // val = nombre de la variable del Servelet
                $('input[id=id_nombres_actualiza]').val(nombres);
                $('input[id=id_apellidos_actualiza]').val(apellidos);
                $('input[id=id_dni_actualiza]').val(dni);
                $('input[id=id_direccion_actualiza]').val(direccion);
                $('input[id=id_telefono_actualiza]').val(telefono);
                $('input[id=id_fechaNacimiento_actualiza]').val(fechaNacimiento);
                $('input[id=id_fechaRegistro_actualiza]').val(fechaRegistro);
                $(".changeValidate").change();

                $('#modalActualizar').modal("show");
            }

            function eliminar(idCliente) {
                //eliminar esta Arriba Hidden oculto
                
                swal({
                    title: 'Está seguro que desea eliminar al cliente?',
                    text: "No podrás revertirlo después!",
                    type: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#3085d6',
                    cancelButtonColor: '#d33',
                    confirmButtonText: 'Sí'
                }).then((result) => {
                    if (result.value) {
                    	$('input[id=id_elimina]').val(idCliente);
                        $('#idFormElimina').submit();
                        
                        swal(
                            'Eliminado!',
                            'El cliente fue eliminado.',
                            'success'
                        )
                    }
                })
            }

            $(document).ready(function() {

                $("#btnLimpiar").on("click", function() {
                    limpiarTodasLasEntradas();
                    $("#id_dni").focus();
                    $("#tipoRegistro").val("default");
                });

                // Llamada ajax para buscar una Persona con el DNI
                $("#btnBuscarPersona").on("click", function() {
                    var dni = $("#id_dni").val();
                    console.log("Buscando la persona con el dni");

                    $.getJSON("cliente", {
                            metodo: "consultaXDNI_JSON",
                            filtro: dni
                        },
                        function(data, textStatus, jqXHR) {
                            console.log(data);
                            if (data.length > 0) {
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
                            }
                        }
                    );
                });

                $('#tablaPrincipal').DataTable();

                $('#formActualizar, #formRegistrar').bootstrapValidator({
                    message: 'This value is not valid',
                    excluded: ':disabled',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        dni: {
                            message: 'El campo dni no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo dni es requerido'
                                },
                                stringLength: {
                                    min: 8,
                                    max: 8,
                                    message: 'El campo dni requiere de 8 caracteres'
                                },
                                regexp: {
                                    regexp: /^[0-9]+$/,
                                    message: 'El dni solo debe contener dígitos'
                                }
                            }
                        },
                        nombres: {
                            message: 'El campo nombres no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo nombres es requerido'
                                },
                                stringLength: {
                                    min: 3,
                                    max: 48,
                                    message: 'El campo nombres requiere de 3 a 48 caracteres'
                                }
                            }
                        },
                        apellidos: {
                            message: 'El campo apellidos no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo apellidos es requerido'
                                },
                                stringLength: {
                                    min: 3,
                                    max: 48,
                                    message: 'El campo apellido requiere de 3 a 48 caracteres'
                                }
                            }
                        },
                        direccion: {
                            message: 'El campo dirección no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo direccion es requerido'
                                },
                                stringLength: {
                                    min: 3,
                                    max: 100,
                                    message: 'El campo dirección requiere de 3 a 100 caracteres'
                                }
                            }
                        },
                        telefono: {
                            message: 'El campo teléfono no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo teléfono es requerido'
                                },
                                stringLength: {
                                    min: 3,
                                    max: 12,
                                    message: 'El campo teléfono requiere de 3 a 12 caracteres'
                                },
                            }
                        },
                        fechaNacimiento: {
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
                        fechaRegistro: {
                            message: 'El campo fecha de registro no es válido',
                            validators: {
                                notEmpty: {
                                    message: 'El campo fecha de registro es requerido'
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