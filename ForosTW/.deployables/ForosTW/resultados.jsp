<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%String error;
ArrayList resultados;
Resultado datos;
if(session.getAttribute("resultados")==null){
	error=new String("Para poder visualizar los resultados debes realizar una busqueda.");
	session.setAttribute("error",error);
	response.sendRedirect("buscar.jsp");
}
else{%>
<!-- CABECERA -->
<head>
<title>Foros TW - Resultados de la bsqueda</title>
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

<p class="titulopagina2">Resultados de la Busqueda<br>
<%  resultados=(ArrayList)session.getAttribute("resultados");
	if(resultados.size()==0) out.println("No se han encontrado coincidencias");
	else{%>
<!-- TABLA CON EL CONTENIDO DE LOS MENSAJES ENCONTRADOS  -->
<p class="tablaresultados">
<table class="resultados" align="center" border="3" width="90%" cellspacing="2" cellpadding="1">      
<tr>
    <td align="center" colspan="3"> <img src="imagenes/resultados.jpg"> </img> </td>
</tr>
<tr>                                                                          <!-- ENCABEZADO DE LA TABLA  -->
   <td align="center"> <b> Asunto del Mensaje </b> </td>
   <td align="center"> <b> Foro en el que se encuentra el Mensaje </b> </td>
   <td align="center"> <b> Fecha , Hora y Usuario de envio </b>  </td>
</tr>
<%		for (int i=0;i<resultados.size();i++){%>
   		  <tr><%datos=(Resultado)resultados.get(i);%>     
    		<td><a href="tema.jsp?id=<%=datos.getIdTema()%>"><%=datos.getAsunto()%></a></td>
    		<td><a href="foro.jsp?id=<%=datos.getIdForo()%>"><%=datos.getForo()%></a></td>
    		<td><%=datos.getFecha()%> por <%=datos.getAutor()%></td>
   		  </tr>
		<%}
	}
}%>
</table>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span>
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>

</body>
</html>
