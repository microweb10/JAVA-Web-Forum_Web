<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>

<!-- CABECERA -->                                                                                                      <!--  a   target="top"    ventana nueva  -->
<head>
<title>Foros TW</title>
<link href="estilo.css" rel="stylesheet" type="text/css"> </link>
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
<!-- FORMULARIO DE LOGIN - POST PARA NO MOSTRAR LA CONTRASENYA -->
<p class="tituloprincipal">Pagina de Inicio
<table align="center" border="0"><tr><td>
<form name="FormLogin"  action="login.jsp"  method="post">
<font size=4 color="Gray"><b>Login</b></font>
<input name="login" type="text"><font size=4 color="Black"><b>Password</b></font></input>
<input name="password" type="password"></input>
<button id="negrita" type="submit">ENTRAR</button>
</form>
</td></tr></table>

<!-- TABLA CON EL CONTENIDO DE LOS FOROS EXISTENTES  -->
<table align="center" border="3" width="90%" cellspacing="2" cellpadding="1">      
<tr>
    <td align="center" colspan="4"> <img src="imagenes/foros.jpg"> </img> </td>
</tr>
<tr>                                                                          <!-- ENCABEZADO DE LA TABLA  -->
   <td align="center"> <b> Nombre y Descripcion del Foro </b>  </td>
   <td align="center"> <b> Numero de Temas </b> </td>
   <td align="center"> <b> Numero de Mensajes </b> </td>
   <td align="center"> <b> Ultimo Mensaje Enviado al Foro </b> </td>
</tr>
<%Foro datos;
ArrayList listaforos;
listaforos=Foros.getListaForos();
for (int i=0;i<listaforos.size();i++){%>
 <tr>   <%datos=(Foro)listaforos.get(i);%>     
   <td><a href="foro.jsp?id=<%=datos.getId()%>"><%=datos.getTitulo()%></a> - <%=datos.getDescripcion()%>  </td>
   <td><%=datos.getNumTemas()%> </td>
   <td><%=datos.getNumMensajes()%> </td>
   <%if(datos.getNumMensajes()>0){%>
   		<td><%=datos.getFechaUltMensaje()%> por <%=datos.getUserUltMensaje()%></td>
   <%}else{%>
   		<td>El Foro No Contiene Mensajes</td>
   <%}%>
 </tr>
<% } %>
</table>
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
