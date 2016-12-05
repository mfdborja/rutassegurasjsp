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
<a href="<%= pageContext.getServletContext().getContextPath()%>/nuevousuario.jsp">Nuevo usuario</a> 

<div id="lista_usuarios" class="tabla">
    <table>
        <tr>
            <th>Email</th>
            <th>Nombre</th>
            <th>Nick</th>
            <th>Tipo</th>
            <th>Acciones</th>
            
        </tr>

        <%        usuarios = (List) request.getAttribute("usuarios");

            for (String usuario : usuarios) {
                String[] trozos = usuario.split("#");
                //id email nombrereal nick
        %>
        <tr>
            <td>
                <%= trozos.length >= 2 ? trozos[1] : ""%>
            </td>
            <td>
                <%= trozos.length >= 3 ? trozos[2] : ""%>
            </td>
            <td>
                <%= trozos.length >= 4 ? trozos[3] : ""%>
            </td>
            <td>
                <%= trozos.length >= 5 ? trozos[4] : ""%>
            </td>
            <td>
                <% int id;
                String tipo;
                    if (request.getSession(false) != null) {
                        if (request.getSession(false).getAttribute("id") != null) {
                            id = (int) request.getSession(false).getAttribute("id");
                            tipo=(String)request.getSession().getAttribute("tipo");
                            if (id == 0) {
                %>
                <% if(!trozos[4].equalsIgnoreCase("administrador")){%><a href="<%= pageContext.getServletContext().getContextPath()%>/nombraradmin?id=<%=trozos[0]%>" onclick="if(!confirm('¿Seguro que desea nombrar a <%=trozos[1]%> como administrador de la plataforma?'))return false"><img src="personalizacion/admin.png" alt="Nombrar administrador"/></a><%}else{%><img src="personalizacion/admint.png" alt="Sin acciones"/><%}%>&nbsp;
                <% if(!trozos[4].equalsIgnoreCase("administrador")){%><a href="<%= pageContext.getServletContext().getContextPath()%>/borrarUsuario?id=<%=trozos[0]%>" onclick="if(!confirm('¿Seguro que desea eliminar a <%=trozos[1]%> de la plataforma?'))return false"><img src="personalizacion/userno.png" alt="Borrar usuario"/></a><%}%>
                    <%
                                }
                            
                            else if(tipo.equalsIgnoreCase("administrador")){
                                %>
                <% if(!trozos[4].equalsIgnoreCase("administrador")){%><a href="<%= pageContext.getServletContext().getContextPath()%>/borrarUsuario?id=<%=trozos[0]%>" onclick="if(!confirm('¿Seguro que desea eliminar a <%=trozos[1]%> de la plataforma?'))return false"><img src="personalizacion/userno.png" alt="Borrar usuario"/></a><%}%>
                <%
                            }
                            }
                        }
                    %>
            </td>
        </tr>
        <%
            }
        %>

    </table>
</div>

<%@include file="WEB-INF/jspf/pie.jsp" %>


