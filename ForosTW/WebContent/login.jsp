<%@ page import="java.util.*,tw.*" %>

<html>
<%Usuario usuario;
  String id;
  String pass;
  String error;
if(session.getAttribute("usuario")!=null){ //si el usuario ya estaba autentificado
	error=new String("Para poder iniciar una sesion primero debes cerrar la existente.");
	session.setAttribute("error",error);
	response.sendRedirect("index.jsp");
}
else{  //si el usuario no estaba autentificado y no ha introducido parametros continuamos la carga de la pagina
   if((request.getParameter("login")==null)&&(request.getParameter("login")==null)){%>
<!-- CABECERA -->
<head>
<title>Foros TW - login</title>
<link href="estilo.css" rel="stylesheet" type="text/css" media="all"></link>
<style>
<!--[if IE]>
   body {overflow:hidden; background-image:url(imagenes/fondo.jpg); background-repeat:repeat;}
   #aviso {position:absolute; top:0px; left:-950px color:#2192FF; font-family:Times New Roman, Serif;
           font-size:18pt; font-style:italic; font-variant:small-caps;font-weight:bold;}
   #todo {height:100%; overflow:auto;}
<![endif]-->
</style>
<script src="javascript/aviso.js"></script>
</head>

<!-- CUERPO -->         
<body>
<div id="todo">
<jsp:include page="menu.jsp"></jsp:include>   <!-- INCLUIMOS EL MENU PRINCIPAL --> 

<p class="titulopagina2"> Pagina de Acceso </p>

<!-- FORMULARIO DE LOGIN - POST PARA NO MOSTRAR LA CONTRASENYA -->
<form class="login" name="FormLogin"  action="login.jsp"  method="post" >               
<table border="1" width="30%" align="center">
<tr>
       <td align="center"> <font size=4 color="Gray"> <b> Login </b> </font> </td>
       <td align="center"> <input name="login" type="text"> </td>
</tr>
<tr>
       <td align="center"> <font size=4 color="Black"> <b> Password </b> </font> </td>
       <td align="center"> <input name="password" type="password"> </td>
</tr>
<tr>
	<td align="center" colspan="2">
		<button id="negrita" type="submit" value="ENTRAR">ENTRAR</button>
	</td>
</tr>
</table>
</form>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span>
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>
   <%}
   else{ //si no estaba autentificado y ha introducido parametros (los validamos)
	   id=request.getParameter("login"); // se comprueban los parametros
	   pass=request.getParameter("password");
	   if(Usuario.autentificar(id,pass)!=null){ // si id y password son correctos
		   usuario=Usuario.autentificar(id,pass); //se coloca el objeto Usuario en la sesion y se llama a index.jsp
		   session.setAttribute("usuario",usuario);
	   }
	   else{ //si el id o el password no son correctos
		   error=new String("El Login de usuario y la Contrasenya no son validos.");
		   session.setAttribute("error",error);
	   }
	   response.sendRedirect("index.jsp");
   }
}%>
</body>
</html>
