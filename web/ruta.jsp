<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<%! /*
     * Variables
     */
    String instrucciones;
    int distanciaRuta;
%>

<%
    /*Obtener datos*/
    instrucciones = (String) request.getAttribute("instrucciones");
    distanciaRuta = (int) request.getAttribute("distancia");  
    
%>


<!-- Titulo-->


<!-- Mostrar mapa-->
<%@include file="segmentos/mapaMostrar.jsp" %>

<!-- Mostrar ruta instrucciones-->
<TABLE class="inforuta" id="inforuta">
            <caption>Información de la ruta</caption>            
            <tbody>
                <%= instrucciones %>    
            </tbody>
            <tfoot>
                <tr>
                    <td></td><td>Distancia total: </td><td><%= distanciaRuta %>  m.</td>
                </tr>
            </tfoot>
        </TABLE>


<%@include file="WEB-INF/jspf/pie.jsp" %>

