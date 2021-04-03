<jsp:include page="sistemaValida.jsp" />
<!DOCTYPE html>
<html lang="es" >
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/bootstrapValidator.js"></script>

<link rel="stylesheet" href="css/bootstrap.css"/>
<link rel="stylesheet" href="css/dataTables.bootstrap.min.css"/>
<link rel="stylesheet" href="css/bootstrapValidator.css"/>
<link rel="stylesheet" href="css/estilosBasicos.css" />
<link href="https://fonts.googleapis.com/css?family=Ubuntu" rel="stylesheet">


<title>Sistemas de Hotel</title>
<style>
	.container {
	    text-align: center;
	}
</style>
</head>
<body> 
<jsp:include page="cabecera.jsp" />
<div class="container">&nbsp;<br>&nbsp;<br>&nbsp;<br>
<h1>Home</h1>
<h3>Bienvenido Sr(a):${sessionScope.objTrabajador.nombreCompleto}</h3>                
</div>
<div class="container" >
<div class="col-md-12" align="center"> 
</div>
</div>    		
</body>
</html>