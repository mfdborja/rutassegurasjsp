<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<p>Nueva noticia</p>
<form id="enviarEmail" method="post"  action="<%= pageContext.getServletContext().getContextPath()%>/nuevaNoticia">
    Titular:
    <br />
    <input id="asunto" maxlength="100" name="asunto" type="text" size="60" placeholder="Introduzca aquí el titular" required/>
    <br />
    Texto o html que conformará la noticia:
    <br />
    <textarea id="contenido" maxlength="270" name="contenido" rows="5" cols="62" placeholder="Escriba aquí la breve noticia" required></textarea>
    <br />
    <input type="submit" value="Crear">    
    
</form>

<%@include file="WEB-INF/jspf/pie.jsp" %>

