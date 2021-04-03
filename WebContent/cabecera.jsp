<style>
	.collapse.navbar-collapse {
	    padding: 5px 50px;
	}
	
	.navbar-inverse .navbar-nav > li > a {
	    color: white !important;
	}
	
	.navbar-inverse {
	    background-color: #4cae4c;
	    border-color: #4cae4c;
	}
	
	.navbar-inverse .navbar-nav > .open > a, .navbar-inverse .navbar-nav > .open > a:hover, .navbar-inverse .navbar-nav > .open > a:focus {
	    color: #fff;
	    background-color: #08080838;
	    border-radius: 10px;
	}
	
	ul.dropdown-menu {
	    text-align: left;
	}
</style>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<div class="container">
 <div class="navbar navbar-inverse">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
    </div>
    
    <div class="collapse navbar-collapse">
    <ul class="nav navbar-nav navbar-left">
       	<li><a href="home.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
    </ul>
      
    <ul class="nav navbar-nav">
    	<li class="dropdown">
	        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
	          Menú<b class="caret"></b>
	        </a>
	        <ul class="dropdown-menu">
	        	<c:forEach items="${sessionScope.objMenus}" var="x">
	        		<li>  
	        			<a href="${x.ruta}">
	        				<span class="glyphicon glyphicon-link"></span> ${x.descripcion}
	        			</a>	
	        		</li>
	        	</c:forEach>		
	        </ul>
     	</li>
     </ul>
      
     <ul class="nav navbar-nav navbar-right">
       	<li><a href="usuario?metodo=logout"><span class="glyphicon glyphicon-off"></span>  Salir</a></li>
     </ul>
      
    </div>
  </div>
</div>  
</div>