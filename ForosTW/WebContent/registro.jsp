<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>

<!-- CABECERA -->
<head>
<title>Foros TW - Pagina de Registro</title>
<link href="estilo.css" rel="stylesheet" type="text/css" media="all"></link>
<style>
<!-- [if IE]>
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

<jsp:include page="menu.jsp"></jsp:include>
<%Usuario usuario;
if(session.getAttribute("usuario")!=null){ //si el usuario ya esta registrado
	usuario=(Usuario)session.getAttribute("usuario");%>
<p class="titulopagina2">Perfiles de Usuario</p>
<p class="registro">Aqui puedes visualizar y modificar tu perfil de Usuario</p>
<!-- FORMULARIO DATOS DE USUARIO - POST YA QUE HAY VALORES IMPORTANTES QUE NO SE PUEDAN MOSTRAR (La contrasenya del usuario)-->
<form class="usuario" name="FormDatosUsuario"  action="modificar.jsp"  method="post">
<center>Mensajes enviados por el usuario al sitio web <%=usuario.getNumMensajes()%> -- Fecha de Registro <%=usuario.getFechaRegistro()%></center>
LOGIN -> <input type="text" value="<%=usuario.getId()%>" name="id" id="id"></input>
PASSWORD -> <input type="text" value="<%=usuario.getPassword()%>" name="password" id="password"></input><br>
UBICACION -> <input type="text" value="<%=usuario.getUbicacion()%>" name="ubicacion" id="ubicacion"></input>
FIRMA -> <input type="text" value="<%=usuario.getFirma()%>" name="firma" id="firma"></input><br>
E-MAIL -> <input type="text" value="<%=usuario.getEmail()%>" name="email" id="email"></input>
TFNO MOVIL -> <input type="text" value="<%=usuario.getMovil()%>" name="movil" id="movil"></input><br>
<center><blink>Si todo funciona bien al Modificar Datos se CERRARA la sesion Automaticamente.</blink></center>
<button class="modificar" type="submit">Modificar Datos</button><br>
</form>
<%}
else{%>
<p class="titulopagina2">Nuevo Usuario</p>
<p class="registro">Para registrarte introduce tus datos de usuario</p>
<!-- FORMULARIO DATOS DE USUARIO - POST YA QUE HAY VALORES IMPORTANTES QUE NO SE PUEDAN MOSTRAR (La contrasenya del usuario)-->
<form class="usuario" name="FormDatosUsuario"  action="nuevo.jsp"  method="post">
LOGIN -> <input type="text" name="id" id="id"></input>
PASSWORD -> <input type="text" name="password" id="password"></input><br>
UBICACION -> <input type="text" name="ubicacion" id="ubicacion"></input>
FIRMA -> <input type="text" name="firma" id="firma"></input><br>
E-MAIL -> <input type="text" name="email" id="email"></input>
TFNO MOVIL -> <input type="text" name="movil" id="movil"></input><br>
<button class="nuevo" type="submit">Nuevo Usuario</button><br>
</form>
<%}%>
<%if(session.getAttribute("error")!=null){%>
<script>alert("<%=session.getAttribute("error")%>");</script>
<%session.setAttribute("error",null);}%>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span>
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>

</body>
</html>
