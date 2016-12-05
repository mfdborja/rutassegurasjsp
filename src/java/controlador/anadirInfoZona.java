package controlador;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "anadirInfoZona", urlPatterns = {"/anadirInfoZona"})
public class anadirInfoZona extends HttpServlet {

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
        String url = "WEB-INF/jspf/gracias.jsp";
        List errores = new ArrayList();
        try {
            //Abrir socket y enviar peticion
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            

            //Obtener info del formulario
            //Cuadrado delimitador
            String sup = request.getParameter("sup");
            String inf = request.getParameter("inf");
            String izq = request.getParameter("izq");
            String der = request.getParameter("der");

            //Valores
            String atributo;

            //Densidad de tráfico
            String densidadtrafico = "-1";
            atributo = "densidadtrafico";
            if (request.getParameter(atributo) != null) {
                densidadtrafico = request.getParameter(atributo);
            }

            //Aceras
            String aceras = "-1";
            atributo = "aceras";
            if (request.getParameter(atributo) != null) {
                aceras = request.getParameter(atributo);
            }

            //Aceras
            String ancho = "-1";
            atributo = "ancho";
            if (request.getParameter(atributo) != null) {
                ancho = request.getParameter(atributo);
            }

            //criminalidad
            String criminalidad = "-1";
            atributo = "criminalidad";
            if (request.getParameter(atributo) != null) {
                criminalidad = request.getParameter(atributo);
            }

            //accidentes
            String accidentes = "-1";
            atributo = "accidentes";
            if (request.getParameter(atributo) != null) {
                accidentes = request.getParameter(atributo);
            }

            //superficie
            String superficie = "-1";
            atributo = "superficie";
            if (request.getParameter(atributo) != null) {
                superficie = request.getParameter(atributo);
            }

            //peatones
            String peatones = "-1";
            atributo = "peatones";
            if (request.getParameter(atributo) != null) {
                peatones = request.getParameter(atributo);
            }

            //semaforos
            String semaforos = "-1";
            atributo = "semaforos";
            if (request.getParameter(atributo) != null) {
                semaforos = request.getParameter(atributo);
            }

            //residencial
            String residencial = "-1";
            atributo = "residencial";
            if (request.getParameter(atributo) != null) {
                residencial = request.getParameter(atributo);
            }

            //fachadas
            String fachadas = "-1";
            atributo = "fachadas";
            if (request.getParameter(atributo) != null) {
                fachadas = request.getParameter(atributo);
            }

            //niveleconomico
            String niveleconomico = "-1";
            atributo = "niveleconomico";
            if (request.getParameter(atributo) != null) {
                niveleconomico = request.getParameter(atributo);
            }

            //iluminacion
            String iluminacion = "-1";
            atributo = "iluminacion";
            if (request.getParameter(atributo) != null) {
                iluminacion = request.getParameter(atributo);
            }

            //velocidad
            String velocidad = "-1";
            atributo = "velocidad";
            if (request.getParameter(atributo) != null) {
                velocidad = request.getParameter(atributo);
            }

            //peatonal
            String peatonal = "-1";
            atributo = "peatonal";
            if (request.getParameter(atributo) != null) {
                peatonal = request.getParameter(atributo);
            }

            //bici
            String bici = "-1";
            atributo = "bici";
            if (request.getParameter(atributo) != null) {
                bici = request.getParameter(atributo);
            }

            //carrilbici
            String carrilbici = "-1";
            atributo = "carrilbici";
            if (request.getParameter(atributo) != null) {
                carrilbici = request.getParameter(atributo);
            }

            //separacion
            String separacion = "-1";
            atributo = "separacion";
            if (request.getParameter(atributo) != null) {
                separacion = request.getParameter(atributo);
            }

            //aparcamiento
            String aparcamiento = "-1";
            atributo = "aparcamiento";
            if (request.getParameter(atributo) != null) {
                aparcamiento = request.getParameter(atributo);
            }
            
            //radar
            String badenes = "-1";
            atributo = "badenes";
            if (request.getParameter(atributo) != null) {
                badenes = request.getParameter(atributo);
            }

            //radar
            String radar = "-1";
            atributo = "radar";
            if (request.getParameter(atributo) != null) {
                radar = request.getParameter(atributo);
            }

            //pendiente
            String pendiente = "-1";
            atributo = "pendiente";
            if (request.getParameter(atributo) != null) {
                pendiente = request.getParameter(atributo);
            }

            //confort
            String confort = "-1";
            atributo = "confort";
            if (request.getParameter(atributo) != null) {
                confort = request.getParameter(atributo);
            }

            //policia
            String policia = "-1";
            atributo = "policia";
            if (request.getParameter(atributo) != null) {
                policia = request.getParameter(atributo);
            }

            //Montar cadena de la petición con los valores
            String valores = densidadtrafico + ";" + aceras + ";" + ancho + ";" + criminalidad + ";"
                    + accidentes + ";" + superficie + ";" + peatones + ";" + semaforos + ";" + residencial
                    + ";" + fachadas + ";" + niveleconomico + ";" + iluminacion + ";" + velocidad + ";"
                    + peatonal + ";" + bici + ";" + carrilbici + ";" + separacion + ";" + aparcamiento
                    + ";" +badenes+";"+ radar + ";" + pendiente + ";" + confort + ";" + policia;

            //Info de laruta
            String idCreador = "-1";
            if (request.getSession(false).getAttribute("id") != null) {
                idCreador = ""+(int) request.getSession(false).getAttribute("id");
            }

            //Privado y elevar
            String privado = "0"; //Publico o 1 si es privado
            //Elevar para validación
            String elevar = "0"; //No compartir o 1 si es para compartir en público

            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            
            //Generar petición
            os.write("anadirinfocalles#" + idCreador + "#" + privado + "#" + elevar + "#" + sup + "#" + inf + "#" + izq + "#" + der + "#" + valores + "\n");
            os.flush();
            
            //Lanzar jsp montado           
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);
        } catch (IOException | ServletException ex) {
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
