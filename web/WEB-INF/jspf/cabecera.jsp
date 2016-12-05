<%@page import="java.util.List"%>
<%@page import="controlador.Datos"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html style="width:100%; height:100%;">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Rutas seguras</title>
        <!-- Incluir css -->
        <style>
            <%@include file="../../personalizacion/estilo.css" %>
        </style>
        <script>
            (function (i, s, o, g, r, a, m) {
                i['GoogleAnalyticsObject'] = r;
                i[r] = i[r] || function () {
                    (i[r].q = i[r].q || []).push(arguments)
                }, i[r].l = 1 * new Date();
                a = s.createElement(o),
                        m = s.getElementsByTagName(o)[0];
                a.async = 1;
                a.src = g;
                m.parentNode.insertBefore(a, m)
            })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

            ga('create', '<%=Datos.apigoogleanalytics%>', 'auto');
            ga('send', 'pageview');

        </script>
        <%@include file="../../segmentos/js.jsp" %>

    </head>
    <%boolean logueado = false;
        if (request.getSession(false) != null) {
            if (request.getSession(false).getAttribute("id") != null) {
                logueado = true;
            }
        }
    %>   
    <body style="width:100%; height:100%;">
        <div id="container">
            <div id="cabecera">  
                <div id="logo">
                    <a  title="Rutas seguras" href="<%= pageContext.getServletContext().getContextPath()%>/"><img src="personalizacion/logo1.png" /></a>
                </div>
                <div id="logougr">
                    <a  target="_blank" title="Universidad de Granada" href="https://www.ugr.es/"><img src="personalizacion/ugrlogo.png" /></a>
                </div>
                <div id="titulo">
                    <img src="personalizacion/logot.png" />
                </div>
                <div id="contacto">
                    <a  title="Acerca de Rutas Seguras" href="<%= pageContext.getServletContext().getContextPath()%>/acercade.jsp"><img src="personalizacion/acercade.png" /></a>
                </div>
                <div id="ayuda">
                    <a  title="Ayuda" href="<%= pageContext.getServletContext().getContextPath()%>/ayuda.jsp"><img src="personalizacion/logoayuda.png" /></a>
                </div>
                
            </div>

            <div id="menu">

                <ul>
                    <li class="button"> <a href="<%= pageContext.getServletContext().getContextPath()%>/">Ruta</a></li>

                    <%
                        //Usuario sin loguear
                        if (!logueado) {%>
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/login.jsp">Log In</a></li>
                        <%}%>
                        <%
                            //usuarios logueados
                            if (logueado) {
                        %>            
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/foro">Foro</a></li>
                        <%
                            //usuarios administradores
                            if (((String) request.getSession().getAttribute("tipo")).equalsIgnoreCase("administrador")) {%>
                    <li class="button"> <a href="<%= pageContext.getServletContext().getContextPath()%>/infozona">Seguridad</a></li>
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/email.jsp">Mensaje</a></li>
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/cargarusuarios">Usuarios</a></li>
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/crearNoticia.jsp">Noticia</a></li>
                        <%}%>

                    <%
                        //Superadministrador
                        if (((Integer) request.getSession(false).getAttribute("id")) == 0) {
                        }%>
                    <li class="button"><a href="<%= pageContext.getServletContext().getContextPath()%>/cargarUsuario">
                            <%= /*request.getSession().getAttribute("login") */""%>
                            Preferencias</a></li>
                    <li class="button"><form><a href="<%= pageContext.getServletContext().getContextPath()%>/logout">Salir</a></form></li>
                                <%}%>
                </ul>
            </div>


            <%!    List<String> errores2;

            %>
            <%    if (request.getAttribute("errores") != null) {
                    errores2 = (List<String>) request.getAttribute("errores");
            %>
            <div id="errores">
                <TABLE>
                    <caption>Error</caption>            
                    <tbody>
                        <%
                            for (String temp : errores2) {%>
                        <TR><TD><%= temp%></TD></TR><%
                            }//Fin for
                                %>                
                    </tbody>
                </TABLE>
            </div>
            <%
                }//Fin if
            %>
