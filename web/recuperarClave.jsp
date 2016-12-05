<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>
    

    <section id="content">
                        <form action="<%= ""+pageContext.getServletContext().getContextPath()%>/recuperarClave" method="get">
                            <div>
                                <input type="email" placeholder="Email" required  name="login" id="username" size="20" />
                            </div>
                            <div>
                                <input type="submit" value="Recuperar" />
                            </div>

                        </form>
                    </section>


<%@include file="WEB-INF/jspf/pie.jsp" %>

