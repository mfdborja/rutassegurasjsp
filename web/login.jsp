<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>


    
<section id="content">
                        <form action="<%= pageContext.getServletContext().getContextPath()%>/identificarUsuario" method="post">
                            <div>
                                <input type="email" placeholder="Email" required  name="login" id="username" size="20" />
                            </div>
                            <div>
                                <input type="password" required name="clave" id="password" size="20" />         
                            </div>
                            <div>
                                <input type="submit" value="Entrar" />
                                <a href="<%=pageContext.getServletContext().getContextPath()%>/recuperarClave.jsp">Recuperar clave</a>
                            </div>

                        </form>
                    </section>

<%@include file="WEB-INF/jspf/pie.jsp" %>

