<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="saferoute.struct.Persona"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%!
    Persona persona;
    boolean existe;
    Calendar fecha;
    String fechaString;
    int tmpnum = -1;
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
<div id="formulario_usuario">
    <form id="preferencias_usuario" action="<%= pageContext.getServletContext().getContextPath()%>/actualizarusuario" method="post" oninput="range_control_value.value=range_control.valueAsNumber">
        <p>
        <table class="tabla">
            <tr><td>
                    Nombre de usuario*: </td><td><input type="text" pattern="^[a-zA-ZñÑ][ñÑa-zA-Z0-9-_\.]{1,20}$" size="20" id="nombreUsuario" name="nombreUsuario" value="<%= existe ? persona.nombreUsuario : ""%>" placeholder="Nombre que verán los demás usurios" required />
                </td></tr><tr><td>
                    Email: </td><td><input type="email" readonly="readonly" size="40" name="email" value="<%= existe ? persona.email : ""%>" placeholder="Email para iniciar sesión" />
                </td></tr><tr><td>
                    Clave: </td><td><input type="password" size="40" id="clave1" name="clave1" value="" placeholder="Cambiar contraseña" autocomplete="off" />
                </td></tr><tr><td>
                    Repita clave:</td><td> <input type="password" size="40" id="clave2" name="clave2" value="" placeholder="Cambiar contraseña" autocomplete="off" />
                </td></tr><tr><td>

                    <%
                        String tipo;
                        if (request.getSession(false) != null) {
                            if (request.getSession(false).getAttribute("tipo") != null) {
                                tipo = (String) request.getSession().getAttribute("tipo");
                                if (!tipo.equalsIgnoreCase("administrador")) {
                    %>

                    <!--Su nombre y apellidos*: --><input type="hidden" size="40" name="nombreReal" value="<%= existe ? persona.nombreReal : ""%>" placeholder="No lo verán los demás usuarios"  />

                    Su sexo*: </td><td>
                    <input type="radio" name="sexoTutor" required value="0" <%= (existe && persona.sexoTutor == 0) ? "checked" : ""%>> Hombre
                    <input type="radio" name="sexoTutor" value="1" <%= (existe && persona.sexoTutor == 1) ? "checked" : ""%>> Mujer
                </td></tr><tr><td>
                    <!--<br />
                    Nombre del menor:--> <input type="hidden"  size="25" name="nombreNino" value="<%= existe ? persona.nombreNino : ""%>" placeholder="Juanito o Juanita" />

                    Sexo del menor*: </td><td>
                    <input type="radio" name="sexoNino" required value="0" <%= (existe && persona.sexoNino == 0) ? "checked" : ""%>> Hombre
                    <input type="radio" name="sexoNino" value="1" <%= (existe && persona.sexoNino == 1) ? "checked" : ""%>> Mujer

                </td></tr><tr><td>
                    Direcci&oacute;n: </td><td><input type="text" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z0-9\,\s]+" size="40" name="direccion" value="<%= existe ? persona.direccion : ""%>" placeholder="Su calle y número" />
                </td></tr><tr><td>
                    Localidad:</td><td> <input type="text" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z\,\s]+" size="20" name="localidad" value="<%= existe ? persona.localidad : ""%>" placeholder="Su localidad" />
                </td></tr><tr><td>
                    Provincia: </td><td><input type="text" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z\,\s]+" size="20" name="provincia" value="<%= existe ? persona.provincia : ""%>" placeholder="Su provincia" />
                </td></tr><tr><td>
                    Código postal:</td><td> <input type="number" pattern="((0[1-9]|5[0-2])|[1-4][0-9])[0-9]{3}" name="cp" value="<%= existe ? persona.codigoPostal : ""%>" placeholder="C.Postal" min="0" max="53000" />
                </td></tr><tr><td>
                    Soy*: </td><td>
                    <input type="radio" name="parentesco" required value="0" <%= (existe && persona.parentesco == 0) ? "checked" : ""%>> Padre o Madre
                    <input type="radio" name="parentesco" value="1" <%= (existe && persona.parentesco == 1) ? "checked" : ""%>> Abuelo
                    <input type="radio" name="parentesco" value="2" <%= (existe && persona.parentesco == 2) ? "checked" : ""%>> Tío o tía
                    <input type="radio" name="parentesco" value="3" <%= (existe && persona.parentesco == 3) ? "checked" : ""%>> Primo o prima
                    <input type="radio" name="parentesco" value="4" <%= (existe && persona.parentesco == 4) ? "checked" : ""%>> Otro familiar
                    <input type="radio" name="parentesco" value="5" <%= (existe && persona.parentesco == 5) ? "checked" : ""%>> Vecino/a
                    <input type="radio" name="parentesco" value="6" <%= (existe && persona.parentesco == 6) ? "checked" : ""%>> Tutor legal
                </td></tr><tr><td>
                <%
                    fecha = new GregorianCalendar();
                    if (persona.fnacPadre != null) {
                        fecha.setTime(persona.fnacPadre);
                    }

                    fechaString = "" + fecha.get(GregorianCalendar.YEAR)/*+"-"+(fecha.get(GregorianCalendar.MONTH)+1)+"-"+fecha.get(GregorianCalendar.DAY_OF_MONTH)*/;
                %>
                    Su año de nacimiento:</td><td> <input type="number" size="6" name="fechaNacimientoPadre" value="<%= existe ? fechaString : "0"%>" />
                </td></tr><tr><td>
                <%
                    fecha = new GregorianCalendar();
                    if (persona.fnacNino != null) {
                        fecha.setTime(persona.fnacNino);
                    }

                    fechaString = "" + fecha.get(GregorianCalendar.YEAR)/*+"-"+(fecha.get(GregorianCalendar.MONTH)+1)+"-"+fecha.get(GregorianCalendar.DAY_OF_MONTH)*/;

                %>
                    Año de nacimiento del menor: </td><td><input type="number" size="6" name="fechaNacimientoNino" value="<%= existe ? fechaString : "0"%>" />
                </td></tr><tr><td>
                    Su nacionalidad: </td><td><input type="text" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z\,\s]+" name="nacionalidadPadre" placeholder="Nacionalidad" value="<%= existe ? persona.naciolidadPadre : "0"%>" />
                </td></tr><tr><td>
                    Nacionalidad del menor: </td><td><input type="text" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z\,\s]+" name="nacionalidadHijo" placeholder="Nacionalidad" value="<%= existe ? persona.nacionalidadHijo : "0"%>" />
                </td></tr><tr><td>
                    Profesión: </td><td><input type="text" name="profesion" pattern="[áéíóúÁÉÍÓÚñÑa-zA-Z\,\s]+" placeholder="Actividad laboral" value="<%= existe ? persona.profesion : "0"%>" />
                </td></tr><tr><td>
                <%}}}%>
                    Recibir alertas automatizadas por correo electrónico:</td><td>
                    <input type="radio" name="alertas" value="0" <%= (existe && persona.alertaMail == 0) ? "checked" : ""%>> Desactivado
                    <input type="radio" name="alertas" value="1" <%= (existe && persona.alertaMail == 1) ? "checked" : ""%>> Recibir
                </td></tr><tr><td></td><td>
                    <input type="submit" value="Actualizar">     </td></tr>       
        </table>
        </p>
    </form>
</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>

