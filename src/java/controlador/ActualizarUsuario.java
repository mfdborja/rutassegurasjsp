package controlador;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import saferoute.struct.Persona;

@WebServlet(name = "actualizarusuario", urlPatterns = {"/actualizarusuario"})
public class ActualizarUsuario extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "/cargarUsuario";
        List errores = new ArrayList();
        try {
            //Abrir socket y enviar peticion
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

            //Generar petición
            os.write("actualizarusuario#");
            
            //Obtener atributos
            Persona persona = (Persona) request.getSession().getAttribute("info");
            
            if (persona != null) {
                os.write(persona.idUsuario+"#");
                //Actualizar campos
                String temp;

                //Nombre de usuario
                temp = request.getParameter("nombreUsuario");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.nombreUsuario = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.nombreUsuario+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Email
                temp = request.getParameter("email");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.email = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.email+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Nombre de real
                temp = request.getParameter("nombreReal");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.nombreReal = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.nombreReal+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Sexo tutor
                temp = request.getParameter("sexoTutor");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.sexoTutor = Byte.parseByte(temp);
                        os.write(temp+"#");
                    }else{
                         os.write(persona.sexoTutor+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Nombre menor
                temp = request.getParameter("nombreNino");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.nombreNino = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.nombreNino+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Sexo nino
                temp = request.getParameter("sexoNino");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.sexoNino = Byte.parseByte(temp);
                        os.write(temp+"#");
                    }else{
                         os.write(persona.sexoNino+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Direccion
                temp = request.getParameter("direccion");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.direccion = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.direccion+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Localidad
                temp = request.getParameter("localidad");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.localidad = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.localidad+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Provincia
                temp = request.getParameter("provincia");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.provincia = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.provincia+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Cod Postal
                temp = request.getParameter("cp");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.codigoPostal = Integer.parseInt(temp);
                        os.write(temp+"#");
                    }else{
                         os.write(persona.codigoPostal+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Parentesco
                temp = request.getParameter("parentesco");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.parentesco = Integer.parseInt(temp);
                        os.write(temp+"#");
                    }else{
                         os.write(" #");
                    }
                }else{
                    os.write(persona.parentesco+"#");
                }

                //F Nac padre
                temp = request.getParameter("fechaNacimientoPadre");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        //String[] trozos = temp.split("-");
                        persona.fnacPadre = new java.sql.Date(new GregorianCalendar(Integer.parseInt(temp),
                                Integer.parseInt("1") - 1, Integer.parseInt("1")).getTimeInMillis());
                        os.write(""+persona.fnacPadre.getTime()+"#");
                    }else{
                         os.write(persona.fnacPadre.getTime()+"#");
                    }
                }else{
                    os.write(" #");
                }

                //F Nac nino
                temp = request.getParameter("fechaNacimientoNino");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        String[] trozos = temp.split("-");
                        persona.fnacNino = new java.sql.Date(new GregorianCalendar(Integer.parseInt(temp),
                                Integer.parseInt("1") - 1, Integer.parseInt("1")).getTimeInMillis());
                        os.write(""+persona.fnacNino.getTime()+"#");
                    }else{
                         os.write(persona.fnacNino.getTime()+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Nacionalidad padre
                temp = request.getParameter("nacionalidadPadre");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.naciolidadPadre = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.naciolidadPadre+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Nacionalidad hijo
                temp = request.getParameter("nacionalidadHijo");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.nacionalidadHijo = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.nacionalidadHijo+"#");
                    }
                }else{
                    os.write(" #");
                }

                //Profesión
                temp = request.getParameter("profesion");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.profesion = temp;
                        os.write(temp+"#");
                    }else{
                         os.write(persona.profesion+"#");
                    }
                }else{
                    os.write(" #");
                }
                
                //Alertas Mail
                temp = request.getParameter("alertas");
                if (temp != null) {
                    if (!temp.isEmpty()) {
                        persona.alertaMail = Integer.parseInt(temp);
                        os.write(temp+"#");
                    }else{
                         os.write(persona.alertaMail+"#");
                    }
                }else{
                    os.write(" #");
                }
                
                os.flush();

                //Para no perder los datos
                request.getSession(true).setAttribute("info", persona);

                //Clave
                temp = request.getParameter("clave1");
                String temp2 = request.getParameter("clave2");
                if (temp != null && temp2 != null) {
                    if (!temp.isEmpty() && !temp2.isEmpty()) {
                        if (temp.equals(temp2)) {
                            if (temp.compareToIgnoreCase("")!=0) {
                                persona.clave = temp;
                                os.write(temp);
                            }
                        } else {
                            //throw new Exception("Las claves no son iguales.");
                        }
                    }
                }

                //Generar petición                
                os.write("");                
                os.write("\n");
                os.flush();
                
                HttpSession sesion = request.getSession(true);
                sesion.removeAttribute("info");
                sesion.setAttribute("info", persona);
            }

            //Lanzar jsp montado                
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);
            
        } catch (IOException | NumberFormatException | ServletException ex) {
            errores.add((ex.getMessage()));
            request.setAttribute("errores", errores);
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
