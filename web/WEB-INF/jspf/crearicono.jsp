<%-- 
    Document   : crearicono
    Created on : 15-may-2015, 19:05:22
    Author     : Usuario
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            <%@include file="../../personalizacion/estiloalerta.css" %>
        </style>
        <title>Crear alerta</title>
    </head>
    <body>
        <h1>Información de la alerta</h1>
        <p>Esta ventana se utiliza para indicar elementos extraordinarios en la vía. Como por ejemplo
            un accidente, trabajos en la vía, calles cortadas...</p>
        Tipo de incidencia:<br /> 
        <form  class="crearalerta" method="post"  action="<%=request.getContextPath()%>/anadiralerta">
            <input type="hidden" name="lat" value="<%=(String)request.getAttribute("lati")%>" />
            <input type="hidden" name="lon" value="<%=(String)request.getAttribute("longi")%>" />
            <select name="incidencia">    
                <option value="0" selected="selected">Calle cortada a personas y tráfico</option>
                <option value="1">Acera intransitable</option>
                <option value="2">Trabajos en la vía</option>
                <option value="3">Trabajos en la acera</option>
                <option value="4">Andamiaje en la acera</option>
                <option value="5">Calle cortada al tráfico</option>
                <option value="25">Policía</option>
                <option value="30">Comercio adherido</option>
                <option value="100">Monitor de ruta a centro educativo</option>
                <option value="101">Colegio</option>
            </select>
<br />
            <textarea name="comentario"  placeholder="Escriba aquí un breve comentario con detalles sobre la incidencia (qué está pasando, duración, etc)." required></textarea>
            <br />
            <input type="submit" value="Compartir" />
        </form>
    </body>
</html>
