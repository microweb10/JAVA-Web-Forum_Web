<%@ page import="java.util.*,tw.*" %>

<html>
<%
String idforo;
String modo;
String texto;
ArrayList resultados;
idforo=request.getParameter("foro");
if(request.getParameter("modo")==null)//si no se ha introducido modo de busqueda ponemos por defecto todas las palabras
	modo=new String("and");
else
	modo=request.getParameter("modo");
texto=request.getParameter("texto");
// si existia algun resultado de otra busqueda en la session lo eliminamos
if(session.getAttribute("resultados")!=null) session.setAttribute("resultados",null);
if(modo.equals("and")){ //si queremos buscar todas las palabras
	resultados=Resultados.buscarResultados(idforo,texto,true);
	session.setAttribute("resultados",resultados);
	response.sendRedirect("resultados.jsp");
}
else{                   //si queremos buscar algunas palabras
	resultados=Resultados.buscarResultados(idforo,texto,false);
	session.setAttribute("resultados",resultados);
	response.sendRedirect("resultados.jsp");
}
%>
<head></head>
<body></body>
</html>
