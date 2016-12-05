<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<form id="infoZona" method="post"  action="<%= pageContext.getServletContext().getContextPath()%>/anadirInfoZona">
    <%! String[] valores = new String[4];%>
    <%
        valores[0] = request.getParameter("sup");
        valores[1] = request.getParameter("inf");
        valores[2] = request.getParameter("izq");
        valores[3] = request.getParameter("der");
    %>
    <input type="hidden" name="sup" value="<%= valores[0]%>" />
    <input type="hidden" name="inf" value="<%= valores[1]%>" />
    <input type="hidden" name="izq" value="<%= valores[2]%>" />
    <input type="hidden" name="der" value="<%= valores[3]%>" />
    Densidad de tráfico:
    <FIELDSET>
        <input type="radio" name="densidadtrafico" value="10" > Muy baja
        <input type="radio" name="densidadtrafico" value="7" > Baja
        <input type="radio" name="densidadtrafico" value="5" > Media
        <input type="radio" name="densidadtrafico" value="3" > Alta
        <input type="radio" name="densidadtrafico" value="0" > Muy Alta
    </FIELDSET>
    <br />
    Valoración de las aceras:
    <FIELDSET>
        <input type="radio" name="aceras" value="0" > Ausente
        <input type="radio" name="aceras" value="3" > Estrecha
        <input type="radio" name="aceras" value="5" > Normal
        <input type="radio" name="aceras" value="7" > Ancha
        <input type="radio" name="aceras" value="10" > Muy ancha
    </FIELDSET>
    <br />
    Ancho de la calle:
    <FIELDSET>
        <input type="radio" name="ancho" value="0" > Muy estrecha
        <input type="radio" name="ancho" value="3" > Estrecha
        <input type="radio" name="ancho" value="5" > Normal
        <input type="radio" name="ancho" value="7" > Ancha
        <input type="radio" name="ancho" value="10" > Muy ancha
    </FIELDSET>
    <br />
    Índice de criminalidad:
    <FIELDSET>
        <input type="radio" name="criminalidad" value="10" > Nulo
        <input type="radio" name="criminalidad" value="7" > Muy bajo
        <input type="radio" name="criminalidad" value="5" > Normal
        <input type="radio" name="criminalidad" value="3" > Alto
        <input type="radio" name="criminalidad" value="0" > Muy alto
    </FIELDSET>
    <br />
    Ratio de accidentes:
    <FIELDSET>
        <input type="radio" name="accidentes" value="10" > Nulo
        <input type="radio" name="accidentes" value="7" > Muy bajo
        <input type="radio" name="accidentes" value="5" > Normal
        <input type="radio" name="accidentes" value="3" > Alto
        <input type="radio" name="accidentes" value="0" > Muy alto
    </FIELDSET>
    <br />
    Superficie: 
    <FIELDSET>
        <input type="radio" name="superficie" value="0" > Lisa
        <input type="radio" name="superficie" value="1" > Adoquines
    </FIELDSET>
    <br />
    Pasos de peatones:
    <FIELDSET>
        <input type="radio" name="peatones" value="0" > Inexistentes y necesarios
        <input type="radio" name="peatones" value="3" > Deficientes
        <input type="radio" name="peatones" value="5" > Suficientes
        <input type="radio" name="peatones" value="7" > Muy buenos
        <input type="radio" name="peatones" value="10" > Excelentes
    </FIELDSET>
    <br />
    Semáforos:
    <FIELDSET>
        <input type="radio" name="semaforos" value="0" > Inexistentes y necesarios
        <input type="radio" name="semaforos" value="3" > Deficientes
        <input type="radio" name="semaforos" value="5" > Suficientes
        <input type="radio" name="semaforos" value="7" > Muy buenos
        <input type="radio" name="semaforos" value="10" > Excelentes
    </FIELDSET>
    <br />
    Zona residencial y/o comercial:
    <FIELDSET>
        <input type="radio" name="residencial" value="0" > No
        <input type="radio" name="residencial" value="1" > Si
    </FIELDSET>
    <br />
    Estado de conservación de los edificios:
    <FIELDSET>
        <input type="radio" name="fachadas" value="0" > Nulo
        <input type="radio" name="fachadas" value="3" > Muy bajo
        <input type="radio" name="fachadas" value="5" > Normal
        <input type="radio" name="fachadas" value="7" > Alto
        <input type="radio" name="fachadas" value="10" > Muy alto
    </FIELDSET>
    <br />
    Nivel socioeconómico:
    <FIELDSET>
        <input type="radio" name="niveleconomico" value="0" > Muy bajo
        <input type="radio" name="niveleconomico" value="3" > Bajo
        <input type="radio" name="niveleconomico" value="5" > Normal
        <input type="radio" name="niveleconomico" value="7" > Alto
        <input type="radio" name="niveleconomico" value="10" > Muy alto
    </FIELDSET>
    <br />
    Calidad de la iluminación:
    <FIELDSET>
        <input type="radio" name="iluminacion" value="0" > Sin iluminación
        <input type="radio" name="iluminacion" value="3" > Deficiente
        <input type="radio" name="iluminacion" value="5" > Normal
        <input type="radio" name="iluminacion" value="7" > Buena
        <input type="radio" name="iluminacion" value="10" > Excelente
    </FIELDSET>
    <br />
    Velocidad máxima:
    <INPUT type="number" name="velocidad" min="0" max="130" step="10" value="50" />
    <br />
    Calle peatonal: 
    <FIELDSET>
        <input type="radio" name="peatonal" value="0" > No
        <input type="radio" name="peatonal" value="1" > Si
    </FIELDSET>
    <br />
    Carril bici:
    <FIELDSET>
        <input type="radio" name="bici" value="0" > No
        <input type="radio" name="bici" value="1" > Si
    </FIELDSET>
    <br />
    Calidad del carril bici:
    <FIELDSET>
        <input type="radio" name="carrilbici" value="0" > Muy bajo
        <input type="radio" name="carrilbici" value="3" > Bajo
        <input type="radio" name="carrilbici" value="5" > Normal
        <input type="radio" name="carrilbici" value="7" > Alto
        <input type="radio" name="carrilbici" value="10" > Muy alto
    </FIELDSET>
    <br />
    Separación entre la calzada y la acera:
    <FIELDSET>
        <input type="radio" name="separacion" value="0" > No
        <input type="radio" name="separacion" value="1" > Si
    </FIELDSET>
    <br />
    Aparcamiento junto a la acera: 
    <FIELDSET>
        <input type="radio" name="aparcamiento" value="1" > No
        <input type="radio" name="aparcamiento" value="0" > Si
    </FIELDSET>
    <br />
    Badenes: 
    <FIELDSET>
        <input type="radio" name="badenes" value="0" > No
        <input type="radio" name="badenes" value="1" > Si o no necesarios
    </FIELDSET>
    <br />
    Radar:
    <FIELDSET>
        <input type="radio" name="radar" value="0" > No
        <input type="radio" name="radar" value="1" > Si o no necesarios
    </FIELDSET>
    <br />
    Nivel de pendiente:
    <FIELDSET>
        <input type="radio" name="pendiente" value="10" > Llano
        <input type="radio" name="pendiente" value="7" > Leve inclinación
        <input type="radio" name="pendiente" value="5" > Pendiente apreciable
        <input type="radio" name="pendiente" value="3" > Desnivel alto
        <input type="radio" name="pendiente" value="0" > Gran pendiente
    </FIELDSET>
    <br />
    Nivel de confort:
    <FIELDSET>
        <input type="radio" name="confort" value="0" > Muy bajo
        <input type="radio" name="confort" value="3" > Bajo
        <input type="radio" name="confort" value="5" > Normal
        <input type="radio" name="confort" value="7" > Alto
        <input type="radio" name="confort" value="10" > Muy alto
    </FIELDSET>
    <br />
    Control de policía: 
    <FIELDSET>
        <input type="radio" name="policia" value="0" > No
        <input type="radio" name="policia" value="1" > Si o no necesarios
    </FIELDSET>
    <br />
    <input type="submit" value="Asignar" />

</form>
