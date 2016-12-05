<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="saferoute.struct.Persona"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    Persona persona;
    boolean existe;
    List<String> usuarios;

%>
<%
    existe = false;
    persona = (Persona) request.getSession().getAttribute("info");
    if (persona != null) {
        existe = true;
    }
%>
<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<div id="nuevo_usuario">
<h2>Nuevo usuario</h2>
        <form id='formnuevousuario' action='<%= pageContext.getServletContext().getContextPath()%>/crearUsuario' >
            <p>Email</p>
            <br/>
            <input id='email' name='email' type='email' size='30' required >
            <br/>
            <input type='submit' value='Crear' >
        </form>   
</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>



