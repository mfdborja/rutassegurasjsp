<%@page import="java.util.List"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Incluir el head y comienzo body-->
<%@include file="WEB-INF/jspf/cabecera.jsp" %>


<h1>¿Qué es la plataforma de Rutas Seguras?</h1>
<p>Es una herramienta diseñada para la generación de rutas orientadas a peatones y ciclistas
    mediante el análisis y explotación de variables objetivas y subjetivas de seguridad.
    Se encuentra enmarcado en una línea de investigación orientada a fomentar el desplazamiento activo al 
    colegio en jóvenes en el marco de un proyecto denominado PACO (procedente de las siglas: “Anda y Pedalea al Colegio”).
    Uno de los objetivos del proyecto es fomentar el desplazamiento al colegio y la creación de esta 
    plataforma supone una efectiva herramienta para trabajar con los padres y 
    mejorar la percepción de seguridad que estos tienen del trayecto de casa al colegio.</p>
</br>
<h1>¿Quienes sois?</h1>
<p>La plataforma de Rutas Seguras se enmarca en un trabajo multidisciplinar con la línea de 
    investigación de movilidad activa que se desarrolla por el grupo trabajo multidisciplinar, 
    “Promoting Fitness and Healt Through Physical Activity”, de la Facultad de Ciencias 
    del Deporte de la Universidad de Granada y el departamento de Ciencias de la Computación
    e Inteligencia Artificial de la Universidad de Granada focalizado en el estudio 
    y fomento de la actividad física.</p>
<p>Así mismo, el diseño y desarrollo de la plataforma se ha enmarcado en el desarrollo
de un Proyecto Final de Grado del alumno del Grado en Ingeniería Informática:
</br></br>
    Borja Rodríguez - mfdborja [at] gmail.com
    </br></br>
    Tutorizado por:
        </br>
    Juan Manuel Fernández 
    </br>
    Palma Chillón
</p>
</br>
<h1>¿Cómo puedo comunicarme con vosotros?</h1>
<p>Puede comunicarse con nosotros a través del formulario de contacto que aparece en esta página y con el
que podrá realizar sugerencias, exponer dudas, etc.</p>


<p>Formulario de contacto con el administrador:</p>
<form id="formcontacto" method="post"  action="<%= pageContext.getServletContext().getContextPath()%>/contactoAdmin">    
    <br />
    <input id="asunto" name="asunto" type="text" size="60" placeholder="Asunto del mensaje" required/>
    <br />
    <input id="email" name="email" type="email" size="60" placeholder="Su email" required/>
    <br />
    <textarea id="contenido" name="contenido" rows="20" cols="62" placeholder="Escriba aquí lo que desee. Puede ser una propuesta para mejorar la plataforma, un posible fallo que haya detectado, un mensaje de ánimo, etc." required></textarea>
    <br />
    <input type="submit" value="Enviar">    
    
</form>

<%@include file="WEB-INF/jspf/pie.jsp" %>

