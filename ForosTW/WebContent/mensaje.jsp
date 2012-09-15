<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%String error;
if(session.getAttribute("usuario")==null){ //si el usuario no estaba autentificado
	error=new String("Para poder enviar mensajes al foro debes Atentificarte o en su defecto Registrarte.");
	session.setAttribute("error",error);
	response.sendRedirect("index.jsp");
}
else{  //si el usuario si estaba autentificado continuamos la carga de la pagina%>
<!-- CABECERA -->
<head>
<title>Foros TW . Nuevo Mensaje</title>
<link href="estilo.css" rel="stylesheet" type="text/css" media="all"></link>
<style>
<!--[if IE]>
   body {overflow:hidden; background-image:url(imagenes/fondo.jpg); background-repeat:repeat;}
   #aviso {position:absolute; top:0px; left:-950px color:#2192FF; font-family:Times New Roman, Serif;
           font-size:18pt; font-style:italic; font-variant:small-caps;font-weight:bold;}
   #todo {height:100%; overflow:auto;}
<![endif]-->
</style>
<script src="javascript/mensaje.js"></script>
<script src="javascript/aviso.js"></script>
</head>

<!-- CUERPO -->          
<body>
<div id="todo">
<jsp:include page="menu.jsp"></jsp:include>
<!-- TITULO NUEVO MENSAJE -->
<p class="titulopagina2"> Nuevo Mensaje </p>

<!-- FORMULARIO DATOS DEL MENSAJE - GET PORQUE NO HAY VALORES IMPORTANTES QUE NO SE PUEDAN MOSTRAR -->
<form class="nuevomensaje" name="FormNuevoMensaje"  action="nuevoMensaje.jsp"  method="get">
Asunto del Mensaje -> <input type="text" name="asunto" id="asunto"></input><br>
Texto del Mensaje <br> <textarea name="texto" id="texto" cols="60" rows="10"></textarea> <br>
<button class="neg" type="button" onclick="formato('b')">Negrita</button>
<button class="curs" type="button" onclick="formato('i')">Cursiva</button>
<button class="sub" type="button" onclick="formato('ins')">Subrayado</button>
<button class="url" type="button" onclick="insrUrl()">Insertar URL</button>
<button class="prev" type="button" onclick="prevMensaje()">Previsualizar</button> <br>
Insertar Smileys
<img       src="smilies/feliz.gif" onclick="insrSmil('[:-)]')"></img>
<img      src="smilies/triste.gif" onclick="insrSmil('[:-(]')"></img>
<img     src="smilies/enojado.gif" onclick="insrSmil('[:-/]')"></img>
<img   src="smilies/durmiendo.gif" onclick="insrSmil('[:-$]')"></img>
<img    src="smilies/colorado.gif" onclick="insrSmil('[:-%]')"></img>
<img src="smilies/exclamacion.gif" onclick="insrSmil('[:-!]')"></img> <br>
Opciones del Mensaje: 
<input type="checkbox" name="firma" value="ok">aduntar firma</input>
<input type="checkbox" name="aviso" value="ok">avisar si recibe respuesta</input>
<input type="hidden" name="tipo" value="<%=request.getParameter("tipo")%>"></input><br>
<button class="envmens" type="submit">Enviar Mensaje</button> <br>
</form>

<!-- DIV PARA LA PREVISUALIZACION DEL MENSAJE APARECERA DEBAJO DEL BOTON ENVIAR -->
<div id="prevMensaje"></div>
</div>

<!-- DIV PARA EL AVISO DINAMICO DE LOS NUEVOS MENSAJES ENVIADOS AL SITIO WEB -->
<div id="aviso"><span id="mensajeAviso"></span> 
<img src="imagenes/cerraraviso.gif" onclick="cerrarAviso(reglas,timer);"></img>
</div>
<%if(session.getAttribute("error2")!=null){%>
<script>alert("<%=session.getAttribute("error2")%>");</script>
<%session.setAttribute("error2",null);
  }
}%>
</body>
</html>
