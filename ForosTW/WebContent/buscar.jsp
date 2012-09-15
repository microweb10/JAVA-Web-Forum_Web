<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>

<!-- CABECERA -->
<head>
<title> Foros TW - Buscar mensajes </title>
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

<p class="titulopagina2"> Busqueda de Mensajes</p>
<!-- FORMULARIO BUSQUEDA DE MENSAJES - GET PORQUE NO HAY VALORES IMPORTANTES QUE NO SE PUEDAN MOSTRAR -->
<form class="busquedamensaje" name="FormBusqMensaje"  action="busqueda.jsp"  method="get" >
Foro en el que desea realizar la Busqueda:
<select name="foro" size="1">
<option value="0">Todos</option>
<%Foro datos;
ArrayList listaforos;
listaforos=Foros.getListaForos();
for (int i=0;i<listaforos.size();i++){
	datos=(Foro)listaforos.get(i);%>
   <option value="<%=datos.getId()%>"><%=datos.getTitulo()%></option>
<%}%>
</select> <br>
Introduzca las palabras clave: <input type="text" name="texto" size="35"></input> <br>
Modo de Busqueda: 
<input type="radio" name="modo" value="and">todas las palabras</input>
<input type="radio" name="modo" value="or">algunas palabras</input> <br>
<button class="buscar" type="submit">Buscar</button> <br>
</form>
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
