<%@ page import="java.util.*,tw.*" %>

<html>
<%
String id;
String password;
String ubicacion;
String firma;
String email;
String error;
String movil;
Usuario usuario=(Usuario)session.getAttribute("usuario");
id=request.getParameter("id");
password=request.getParameter("password");
ubicacion=request.getParameter("ubicacion");
firma=request.getParameter("firma");
email=request.getParameter("email");
movil=request.getParameter("movil");
// si se puede insertar en la base de datos un nuevo usuario con esos datos
if(Usuario.insertar(id,password,ubicacion,firma,email,movil)){
	error="El Registro de Nuevo Usuario se ha Realizado con Exito.";
	session.setAttribute("error",error);
	response.sendRedirect("logout.jsp");
}
else{// si no se puede sera porque ya existe el login en la base de datos
	error="El Login de Usuario que has introducido ya existe, intentalo con otro.";
	session.setAttribute("error",error);
	response.sendRedirect("registro.jsp");
}%>
<head></head>
<body></body>
</html>
