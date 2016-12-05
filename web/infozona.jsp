<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<%!    List<String> errores;
%>
<%    if (request.getAttribute("errores") != null) {
        errores = (List<String>) request.getAttribute("errores");
%>
<TABLE>
    <caption>Error</caption>            
    <tbody>
        <%
            for (String temp : errores) {%>
        <TR><TD><%= temp%></TD></TR><%
            }//Fin for
                %>                
    </tbody>
</TABLE>
<%
    }//Fin if
%>
<!-- Titulo-->
<h1>Definición de seguridad</h1>

<!-- Mostrar mapa-->
<div id="mapa">
    <%@include file="segmentos/mapaMostrar.jsp" %>

    <!-- Geoposicionador-->
    <div id="panel">
        <input id="busqueda" class="controls" type="search" size="30" onKeyPress="return submitentercentrar(this, event)" />
    </div>
</div>

<div id="infoZona">
    
</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>

