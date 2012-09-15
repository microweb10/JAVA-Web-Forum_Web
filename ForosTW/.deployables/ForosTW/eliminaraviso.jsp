<%@ page import="java.util.*,tw.*" %>
<%@ page errorPage="error.jsp"%>
<html>
<%Avisos.eliminarAviso(request.getParameter("id"));
response.sendRedirect("avisos.jsp");%>
</html>
