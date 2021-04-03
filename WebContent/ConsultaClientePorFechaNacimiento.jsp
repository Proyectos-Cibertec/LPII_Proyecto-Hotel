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

        <title>CONSULTA DE CLIENTES</title>
    </head>

    <body>
		<jsp:include page="cabecera.jsp" />
        <div class="container">
            <h1>Consulta de Clientes por Fecha de Nacimiento</h1>
            <div class="col-md-23">
                <form accept-charset="UTF-8" action="cliente" class="simple_form" id="frmFiltra" method="post">
                    <input type="hidden" name="metodo" value="consultaXFechaNacimiento">
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