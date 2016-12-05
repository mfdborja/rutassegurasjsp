<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<h3>Email a sus usuarios</h3>
<form id="enviarEmail" method="post"  action="<%= pageContext.getServletContext().getContextPath()%>/enviarEmail">
    Asunto:
    <br />
    <input id="asunto" name="asunto" type="text" size="60" placeholder="Asunto del email" required/>
    <br />
    Texto o html que conformará el email:
    <br />
    <textarea id="contenido" name="contenido" rows="20" cols="60" placeholder="Escriba aquí el email" required></textarea>
    <br />
    <input type="submit" value="Enviar">    
    
</form>

<%@include file="WEB-INF/jspf/pie.jsp" %>

