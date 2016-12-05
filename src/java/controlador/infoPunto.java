package controlador;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "infopunto", urlPatterns = {"/infopunto"})
public class infoPunto extends HttpServlet {

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

        try (PrintWriter out = response.getWriter()) {
            //Obtener usuario
            //Info de laruta
            String idCreador = "-1";
            if (request.getSession(false).getAttribute("id") != null) {
                if (((String) request.getSession(false).getAttribute("tipo")).equalsIgnoreCase("administrador")) {
                    idCreador = "" + (int) request.getSession(false).getAttribute("id");
                }
            }

            //Abrir socket y enviar peticion
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

            String lat = request.getParameter("lat");
            String lon = request.getParameter("lon");
            os.write("infopunto#" + lat + "#" + lon + "\n");
            os.flush();

            //Respuesta
            BufferedReader is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String respuesta;

            //Escribir salida
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">");
            out.println("<title>Información</title>");
            out.println("<style>\n"
                    + "*{ margin: 2px; padding: 0; }"
                    + "a{"
                    + "background: #efefef; /* For browsers that do not support gradients */\n"
                    + "    background: -webkit-linear-gradient(left top, #efefef,#d5e5ee); /* For Safari 5.1 to 6.0 */\n"
                    + "    background: -o-linear-gradient(bottom right, #efefef,#d5e5ee); /* For Opera 11.1 to 12.0 */\n"
                    + "    background: -moz-linear-gradient(bottom right, #efefef,#d5e5ee); /* For Firefox 3.6 to 15 */\n"
                    + "    background: linear-gradient(to bottom right,#efefef,#d5e5ee); /* Standard syntax */\n"
                    + "    background-attachment: fixed;"
                    + "}"
                    + ".caja{"
                    + "width:320px;"
                    + "padding:20px;"
                    + "}"
                    + "fieldset{"
                    + "border:0px groove #efefef;"
                    + "}"
                    + "input[type=\"number\"]{background: transparent; border:0px; width: 40px;}"
                    + "label {\n"
                    + "  white-space: nowrap;"
                    + "  display:block;\n"
                    + "}"
                    + "        </style>");
            out.println("</head>");
            out.println("<body>");

            //Botón añadir icono
            if (request.getSession(false).getAttribute("id") != null) {

                out.println("<div class=\"caja\"> <form  method='GET' action=\"" + request.getContextPath() + "/lanzarcrearalerta\">");
                out.println("<input type='hidden' name='lat' value='" + lat + "' />");
                out.println("<input type='hidden' name='lon' value='" + lon + "' />");
                out.println("<input type='submit' value='Informar de alerta' />");
                out.println("</form>");
            }

            //Formulario calle            
            out.println("<form  method=\"post\"  action=\"" + request.getContextPath() + "/anadirInfoPunto?lat=" + lat
                    + "&lon=" + lon + "\">");

            if (idCreador.equals("-1")) {
                out.println("<fieldset disabled>");
            } else {
                out.println("<fieldset>");
            }

            while ((respuesta = is.readLine()) != null) {
                out.println(respuesta);
            }

            if (!idCreador.equals("-1")) {
                out.println("<input type=\"hidden\" name=\"lat\" value=\"" + lat + "\" />");
                out.println("<input type=\"hidden\" name=\"lon\" value=\"" + lon + "\" />");
                out.println("<input type=\"submit\" value=\"Actualizar\" />");
            }
            out.println("</fieldset>");
            out.println("</form></div></body>");
            out.println("</html>");

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
