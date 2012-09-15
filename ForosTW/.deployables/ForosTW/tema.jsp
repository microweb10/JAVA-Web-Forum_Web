<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%Tema tema=Tema.buscarTema(request.getParameter("id"));
if(session.getAttribute("tema")!=null) session.setAttribute("tema",null);
session.setAttribute("tema",tema); //si habia algun tema en la sesion lo quitamos y ponemos el actual
int numforo=tema.getIdForo();
String idforo=""+numforo;
Foro foroactual=Foro.buscarForo(idforo);
if(session.getAttribute("foro")!=null) session.setAttribute("foro",null);
session.setAttribute("foro",foroactual); //si habia algun foro en la sesion lo quitamos y ponemos el actual
String nombreforo=foroactual.getTitulo();
%>
<!-- CABECERA -->
<head>
<title>Foros TW <%=tema.getAsunto()%></title>
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

<!-- UBICACION ACTUAL -->
<p class="ubic"> Ubicacion Actual: <a class="ubiclink" href="index.jsp"> Foros TW </a> ->
<a class="ubiclink" href="foro.jsp?id=<%=tema.getIdForo()%>"><%=nombreforo%></a> -> <%=tema.getAsunto()%></p>

<!-- TITULO DEL TEMA -->
<p class="titulopagina"><%=tema.getAsunto()%></p>

<!-- TABLA CON EL CONTENIDO DE LOS MENSAJES DEL TEMAS DEL FORO  -->
<p class="tablas">
<table align="center" border="3" width="100%" cellspacing="2" cellpadding="1">      
<tr>
    <td align="center" colspan="5"><img src="imagenes/mensajes.jpg"></img></td>
</tr>
<tr>                                                                          <!-- ENCABEZADO DE LA TABLA  -->
   <td align="center"> <b> Fecha y Hora de envio </b>  </td>
   <td align="center"> <b> Login del Usuario que lo envio </b> </td>
   <td align="center"> <b> Asunto del Mensaje </b> </td>
   <td align="center"> <b> Texto del Mensaje </b> </td>
   <td align="center"> <b> Imagen </b> </td>
</tr>
<%Mensaje datos;
ArrayList listamensajes;
listamensajes = tema.getMensajes();
for (int i=0;i<listamensajes.size();i++){%>
  <tr><%datos=(Mensaje)listamensajes.get(i);%>     
    <td><%=datos.getFecha()%></td>
    <td><%=datos.getAutor()%></td>
    <td><%=datos.getAsunto()%></td>
    <td><%=datos.getTexto()%></td>
    <td align="center"><img src="fotos/<%=datos.getAutor()%>.jpg"></img></td>
  </tr>
<%}%>
</table>

<!-- ENLACE A NUEVO TEMA  -->  <!-- ENLACE A RESPONDER  -->
<p class="enlacemensaje"><a class="nuevo" href="mensaje.jsp?tipo=tema">Nuevo Tema </a>
<a class="resp" href="mensaje.jsp?tipo=mensaje">Responder </a></p>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span>
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>

</body>
</html>
