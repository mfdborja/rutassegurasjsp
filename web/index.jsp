<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>

<%! List<String[]> noticias;%>
<% noticias = (List<String[]>) request.getAttribute("noticias");%>
<div >&nbsp;</div>
<div id="contenido" style="height:100%;">
    <!-- Bajo menú-->
    <div id="bajomenu">
        <%if (noticias != null) {%>
        <div id="titulonoticias">
            <h1>Últimas noticias</h1>
            <div id="slider-outer">
                <input type="radio" id="btn-goto-last" class="slide-check" name="slider">
                <input type="radio" id="btn-1" class="slide-check" name="slider" checked="checked">
                <input type="radio" id="btn-2" class="slide-check" name="slider">
                <input type="radio" id="btn-3" class="slide-check" name="slider">
                <input type="radio" id="btn-4" class="slide-check" name="slider">
                <input type="radio" id="btn-5" class="slide-check" name="slider">
                <input type="radio" id="btn-goto-first" class="slide-check" name="slider">

                <label for="btn-goto-last" id="arrow-goto-last" class="arrows" onclick="">►</label>
                <label for="btn-1" id="arrow-1" class="arrows" onclick="">►</label>
                <label for="btn-2" id="arrow-2" class="arrows" onclick="">►</label>
                <label for="btn-3" id="arrow-3" class="arrows" onclick="">►</label>
                <label for="btn-4" id="arrow-4" class="arrows" onclick="">►</label>
                <label for="btn-5" id="arrow-5" class="arrows" onclick="">►</label>
                <label for="btn-goto-first" id="arrow-goto-first" class="arrows" onclick="">►</label>

                <div id="slider">
                    <div class="slides">
                        <%
                            int i = 0;
                            for (String[] noticia : noticias) {
                                i++;%>
                        <div>
                            <div>
                                <span class="title"><b><%=noticia[2]%></b></span>
                                <span class="num">(<%= "" + i%>/<%= "" + noticias.size()%>)</span><br>
                                <%=noticia[3]%>
                                <%
                                    //Si es un usuario administrador puede borrar noticias
                                    if (logueado) {
                                        if (((String) request.getSession().getAttribute("tipo")).equalsIgnoreCase("administrador")) {
                                %>
                                <p class="more"><a class="link tip" href="borrarNoticia?id=<%=noticia[0]%>" title=Borrar">Borrar</a></p>
                                <%
                                        }
                                    }%>


                            </div>
                        </div>
                        <%}%>

                    </div><!-- closing ".slides" -->
                </div><!-- closing "#slider" -->
            </div>
        </div>

        <div id="bannertiempo">
            <!--<h1>Previsión</h1>-->
            <%=Datos.bannerTiempo%>
        </div>
    </div>
    <%}%>
    <div >&nbsp;</div>

    <!-- Mostrar salida-->
    <div id="configuracionruta">
        <form id="generarRuta" action="<%= pageContext.getServletContext().getContextPath()%>/generarRuta">
            <div class="confruta-boton">
            <input type="button" value="Generar ruta" onclick="generarRuta()" class="register-button" />
            </div>
            
            <div class="register-switch">
                <input type="radio" name="tiporuta" value="pie" id="tipo_p" class="register-switch-input" checked>
                <label for="tipo_p" class="register-switch-label">Peatonal</label>
                <input type="radio" name="tiporuta" value="bici" id="tipo_b" class="register-switch-input">
                <label for="tipo_b" class="register-switch-label">Ciclista</label>
            </div>            
            
            <div class="confruta-rango">
            <img src="personalizacion/rutasegura2.png" /> 
            <input type="range" value="0.5" id="rangosegu" name="rangosegu"  min="0.0" max="1.0" step="0.1" />
            <img src="personalizacion/rutasegura.png" />
            </div>           
            
            <input type="hidden" value="" id="coordenadas" name="coordenadas" />
        </form>
    </div>

    <!-- Mostrar mapa-->
    <div id="mapa"  style="height:100%;">
        <%@include file="segmentos/mapaMostrar.jsp" %>

        <!-- Geoposicionador-->
        <div id="panel">
            <input id="busqueda" class="controls" type="search" placeholder="Introduzca origen" size="30"   />

        </div>
    </div>

</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>

