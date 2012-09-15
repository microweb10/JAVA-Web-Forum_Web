<%@ page import="java.util.*,tw.*" %>
<html>

<!-- CABECERA -->                                                                                                      <!--  a   target="top"    ventana nueva  -->
<head></head>  <!-- CUERPO -->           
<body>
<!-- UNA IMAGEN PARA EL TITULO DE LA PAGINA -->
<p class="centro"><img src="imagenes/titulo.jpg"></p> <!-- MENU DE LA PAGINA -->
<%Usuario usuario;
String login;
if(session.getAttribute("usuario")!=null){  //si el usuario se ha autentificado se pone su nombre
	usuario=(Usuario)session.getAttribute("usuario");
	login=usuario.getId();%>
	<p class="usuario">Usuario: <b><%=login%></b> <a class="cerrarsesion" href="logout.jsp">Cerrar Sesion</a>&nbsp&nbsp&nbsp&nbsp</p>
<%}%>
<hr>                 <!-- LINEA HORIZONTAL --> <!-- MENU DE LA PAGINA -->
 <p class="centro">
  <a class="negro" href="index.jsp">Inicio</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <a class="verde" href="buscar.jsp">Buscar</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <a class="violeta" href="login.jsp">Login</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <a class="rojo" href="registro.jsp">Registro</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
  <%if(session.getAttribute("usuario")!=null){%>
     <a class="azul" href="avisos.jsp">Mis Avisos</a>
  <%}%>
 </p>
<hr>                 <!-- LINEA HORIZONTAL -->
</body>  
</html>