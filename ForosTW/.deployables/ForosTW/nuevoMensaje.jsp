<%@ page import="java.util.*,tw.*" %>

<html>
<%Usuario usuario;
Foro foro;
Tema tema;
String error;
String titulo;
String asunto;
String autor;
String texto;
boolean firma;
boolean aviso;

if(session.getAttribute("usuario")==null){ //si el usuario no estaba autentificado
	error=new String("Para poder enviar mensajes al foro debes Atentificarte o en su defecto Registrarte.");
	session.setAttribute("error",error);
	response.sendRedirect("index.jsp");
}else{ //si ya estaba autentificado
	if(request.getParameter("tipo").equals("tema")){ //si se quiere crear un nuevo tema
       // comprobamos que no se quiera crear un nuevo tema sin haber especificado el asunto (Titulo del tema)
	   if((request.getParameter("asunto")==null)||(request.getParameter("asunto")=="")){
	      error=new String("Para crear un nuevo tema debes intoducir el asunto.");
	      session.setAttribute("error2",error);
		  response.sendRedirect("mensaje.jsp?tipo=tema");
	   }
	   else{ //ponemos valor a los datos del nuevo tema
	      if(request.getParameter("texto")==null) texto=new String(""); //nos aseguramos que la variable texto no es null
	      else                                    texto=request.getParameter("texto");
	      titulo=request.getParameter("asunto");
	      session.setAttribute("titulo",titulo); //pongo el titulo del nuevo tema en la sesion
	      usuario=(Usuario)session.getAttribute("usuario");
	      autor=usuario.getId();
	      if(request.getParameter("firma")==null) //si no se ha puesto la opcion de firma
	         firma=false;
	      else firma=true;
	      if(request.getParameter("aviso")==null) //si no se ha puesto la opcion de aviso
		     aviso=false;
	      else aviso=true;
	      foro=(Foro)session.getAttribute("foro");
	      foro.nuevoTema(titulo,autor,texto,aviso,firma,usuario); //AQUI SE CREA EL NUEVO TEMA EN LA BASE DE DATOS
	      response.sendRedirect("foro.jsp?id="+foro.getId());
	   }
   }
   else{ //si se quiere introducir un mensaje en un tema
	   if(request.getParameter("texto")==null) texto=new String(""); //nos aseguramos que la variable texto no es null
	   else                                    texto=request.getParameter("texto");
	   if(request.getParameter("asunto")==null) asunto=new String(""); //nos aseguramos que la variable asunto no es null
	   else                                     asunto=request.getParameter("asunto");	   
	   usuario=(Usuario)session.getAttribute("usuario");
	   if(request.getParameter("firma")==null) //si no se ha puesto la opcion de firma
	      firma=false;
	   else firma=true;
	   if(request.getParameter("aviso")==null) //si no se ha puesto la opcion de aviso
	      aviso=false;
	   else aviso=true;
	   tema=(Tema)session.getAttribute("tema");
	   tema.nuevoMensaje(asunto,texto,usuario,aviso,firma); //AQUI SE CREA EL NUEVO MENSAJE EN LA BASE DE DATOS
	   response.sendRedirect("tema.jsp?id="+tema.getId());  
   }
}%>
<head></head>
<body></body>
</html>
