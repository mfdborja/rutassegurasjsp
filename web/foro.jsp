<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<%!    List<String[]> hilos = new ArrayList();
%>
<%    if (request.getAttribute("hilos") != null) {
        hilos = (List<String[]>) request.getAttribute("hilos");
    //Respuesta - listado id idpadre idautor fecha
        // titulo mensaje 
    }
%>
<div id="contenido" style="height:100%;">

    <div class="foro">
        <%if (request.getAttribute("idpadre") != null) {%>
        <a class="nuevomensajeforo" href="<%= pageContext.getServletContext().getContextPath()%>/mensajeforo.jsp?id=<%=request.getAttribute("idpadre")%>"><img src="personalizacion/addr.png" alt="Responder"/></a>
            <%} else {%>
        <a class="nuevomensajeforo" href="<%= pageContext.getServletContext().getContextPath()%>/mensajeforo.jsp?id=-1"><img src="personalizacion/addm.png" alt="Publicar hilo"/></a>
            <%}%>

        <%for (String[] hilo : hilos) {%>
        <table class="tablaforo">            
            <tr>
                <td  class="tituloforo">
                    <%if (request.getAttribute("idpadre") == null) {%>
                    <a href="<%= pageContext.getServletContext().getContextPath()%>/hilo?id=<%=hilo[0]%>">
                        <%=hilo[4]%>
                    </a><%}else{%>
                    <%=hilo[4]%>
                    <%}%>
                    
                    <%if (((String) request.getSession().getAttribute("tipo")).equalsIgnoreCase("administrador")) {%><a href="<%= pageContext.getServletContext().getContextPath()%>/borrarmensaje?id=<%=hilo[0]%>"><img src="personalizacion/delete.png" alt="Borrar mensaje"/></a><%}%>
                </td>
                <td class="autorforo"><%=hilo[2]%></td>
            </tr>
            <tr>
                <td class="mensajeforo" colspan="2">
                    <%if (request.getAttribute("idpadre") == null) {%>
                    <a href="<%= pageContext.getServletContext().getContextPath()%>/hilo?id=<%=hilo[0]%>">
                        <%
                                String texto=hilo[5];
                        if(texto.length()>250){
                            hilo[5]=texto.substring(0,249)+"[...]";
                        }%>
                        <%=hilo[5]%>
                    </a><%}else{%>
                    <%=hilo[5]%>
                    <%}%>
                </td>
            </tr>
            <tr>
                <td class="fechaforo" colspan="2">
                    <%String fecha = "";
                        GregorianCalendar gc = new GregorianCalendar();
                        gc.setTimeInMillis(Long.parseLong(hilo[3]));

                        fecha += gc.get(GregorianCalendar.DAY_OF_MONTH) + " del " + (gc.get(GregorianCalendar.MONTH) + 1) + " de " + gc.get(GregorianCalendar.YEAR);
                        hilo[3] = fecha;
                    %>
                    <%=hilo[3]%>
                </td>
            </tr>
        </table>
        <%}%>
    </div>

</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>