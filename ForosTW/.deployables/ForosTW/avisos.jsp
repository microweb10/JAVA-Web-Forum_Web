<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%String error;
if(session.getAttribute("usuario")==null){ //si el usuario no estaba autentificado
	error=new String("Para poder ver tus avisos debes Atentificarte o en su defecto Registrarte.");
	session.setAttribute("error",error);
	response.sendRedirect("index.jsp");
}
else{  //si el usuario si estaba autentificado continuamos la carga de la pagina
	Usuario usuario=(Usuario)session.getAttribute("usuario");
	ArrayList listaavisos=Avisos.buscarAvisos(usuario);
	Aviso datos;%> 
<!-- CABECERA -->
<head>
<title>Foros TW - Mis Avisos</title>
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
<jsp:include page="menu.jsp"></jsp:include>
<!-- TITULO MIS AVISOS -->
<p class="titulopagina2"> Mis Avisos
<%if(listaavisos.size()==0) out.println("(No hay Avisos para mostrar)");
  else{%>
<p class="tablaavisos">
<!-- TABLA CON LOS AVISOS DEL USUARIO  -->
<table align="center" border="3" width="90%" cellspacing="2" cellpadding="1">
<tbody id="tablaavisos">
<tr>          <!-- ENCABEZADO DE LA TABLA  -->
   <td align="center"> <b> Nombre del Tema </b>  </td>
   <td align="center"> <b> Login del usuario que lo creo </b> </td>
   <td align="center"> <b> N de Mensajes </b> </td>
   <td align="center"> <b> Eliminar Aviso </b> </td>
</tr>
  <%for (int i=0;i<listaavisos.size();i++){%>
   <tr><%datos=(Aviso)listaavisos.get(i);%>     
    <td><%=datos.getTema()%></td>
    <td><%=datos.getAutorTema()%> </td>
    <td><%=datos.getNumMensajesTema()%> </td>
    <td><a href="eliminaraviso.jsp?id=<%=datos.getId()%>">QUITAR</a></td>
   </tr>
  <%}
  }%>
</tbody>
</table>
</div>
<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span> 
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>
</body>
<%}%>
</html>
