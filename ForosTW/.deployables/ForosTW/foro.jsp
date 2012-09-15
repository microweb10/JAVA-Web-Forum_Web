<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%Foro foro=Foro.buscarForo(request.getParameter("id"));
if(session.getAttribute("foro")!=null) session.setAttribute("foro",null);
session.setAttribute("foro",foro); //si habia algun foro en la sesion lo quitamos y ponemos el actual
%> 
<!-- CABECERA -->
<head>
<title>Foros TW <%=foro.getTitulo()%></title>
<link href="estilo.css" rel="stylesheet" type="text/css" media="all"></link>
<style>
<!--[if IE]>
   body {overflow:hidden; background-image:url(imagenes/fondo.jpg); background-repeat:repeat;}
   #aviso {position:absolute; top:0px; left:-950px color:#2192FF; font-family:Times New Roman, Serif;
           font-size:18pt; font-style:italic; font-variant:small-caps;font-weight:bold;}
   #todo {height:100%; overflow:auto;}
<![endif]-->
</style>
<script src="javascript/ordtabla.js"></script>
<script src="javascript/aviso.js"></script>
</head>

<!-- CUERPO -->           
<body>
<div id="todo">

<jsp:include page="menu.jsp"></jsp:include>

<!-- UBICACION ACTUAL -->
<p class="ubic"> Ubicacion Actual: <a class="ubiclink" href="index.jsp">Foros TW</a> -> <%=foro.getTitulo()%></p>

<!-- TITULO DEL FORO -->
<p class="titulopagina"><%=foro.getTitulo()%><br>
<%Tema datos;
ArrayList listatemas;
if(foro.getNumTemas()==0)// si no existen temas en el foro
	out.println("El foro está vacío");
else{ //si existen temas en el foro los mostramos %>
<!-- ENLACES PARA ORDENAR LA TABLA -->
<p class="ordentabla"> Ordenar los Temas del Foro segun el Numero de Mensajes enviados:
   <span onclick="ordenarTabla('tablaforo','asc')">Orden Ascendente <img src="imagenes/asc.jpg" onclick="ordenarTabla('tablaforo','asc')"></img></span>
   <span onclick="ordenarTabla('tablaforo','des')">Orden Descendente <img src="imagenes/desc.jpg" onclick="ordenarTabla('tablaforo','des')"></img></span>
</p>
<p class="tablas">
<!-- TABLA CON EL CONTENIDO DE LOS TEMAS DEL FORO  -->
<table align="center" border="3" width="90%" cellspacing="2" cellpadding="1">
<tbody id="tablaforo">
<tr>
    <td align="center" colspan="4"> <img src="imagenes/temas.jpg"> </img> </td>
</tr>
<tr>          <!-- ENCABEZADO DE LA TABLA  -->
   <td align="center"> <b> Nombre del Tema </b>  </td>
   <td align="center"> <b> Login del usuario que lo creo </b> </td>
   <td align="center"> <b> N de Mensajes </b> </td>
   <td align="center"> <b> Ultimo Mensaje Enviado al Tema </b> </td>
</tr>
<%listatemas=foro.getTemas();
for (int i=0;i<listatemas.size();i++){%>
   <tr><%datos=(Tema)listatemas.get(i);%>     
    <td><a href="tema.jsp?id=<%=datos.getId()%>"><%=datos.getAsunto()%></a></td>
    <td><%=datos.getAutor()%> </td>
    <td><%=datos.getNumMensajes()%> </td>
    <td><%=datos.getFechaUltMensaje()%> por <%=datos.getAutorUltMensaje()%></td>
   </tr>
  <%}
}%>
</tbody>
</table>

<!-- ENLACE A NUEVO TEMA  -->
<p class=enlacemensaje><a class="nuevo" href="mensaje.jsp?tipo=tema">Nuevo Tema</a></p>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span>
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>

</body>
</html>
