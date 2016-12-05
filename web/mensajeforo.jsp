<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>
<%!
String idPadre=null;
%>
<%
idPadre=request.getParameter("id");
%>
<p>Mensaje:</p>
<form id="enviarEmail" method="post"  action="<%= pageContext.getServletContext().getContextPath()%>/publicarmensaje?id=<%=idPadre%>">
    Título:
    <br />
    <input id="tituloforo" name="titulo" type="text" size="60" placeholder="Título para el mensaje" required/>
    <br />
    Texto que conformará el mensaje:
    <br />
    <textarea id="contenido" name="contenido" rows="20" cols="60" placeholder="Escriba aquí el mensaje" required></textarea>
    <br />
    <input type="submit" value="Publicar">    
    
</form>

<%@include file="WEB-INF/jspf/pie.jsp" %>

