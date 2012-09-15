<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%session.invalidate(); //eliminamos el objeto Usuario de la sesion
response.sendRedirect("index.jsp");%>
<head></head>
<body></body>
</html>
