
package controlador;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
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


@WebServlet(name = "generarRuta", urlPatterns = {"/generarRuta"})
public class generarRuta extends HttpServlet {

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
        String url = "/ruta.jsp";
        List errores = new ArrayList();
        try {
            if (request.getParameter("coordenadas") == null) {
                //Error
            } else {
                //Abrir socket y enviar peticion
                Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
                //Petición
                BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
                
                String usuario="-1"; //Usuario público
                if(request.getSession(false).getAttribute("login")!=null){
                    usuario=""+(int)request.getSession(false).getAttribute("id");
                }
                String indSeguridad="0.5";
                if(request.getParameter("rangosegu")!=null){
                    indSeguridad=request.getParameter("rangosegu");
                    
                }
                
                String tipo="pie";
                if(request.getParameter("tiporuta")!=null){
                    tipo=request.getParameter("tiporuta");
                }

                //generar ruta usuario#pie/bici#indiceSeguridad#lat1;lon1#lat2;lon2
                os.write("generarruta "+usuario+"#"+indSeguridad+"#"+tipo+"#" + request.getParameter("coordenadas")+"\n");
                os.flush();
                //Obtener instrucciones
                BufferedReader is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                String respuesta = is.readLine();
                //Trocear
                String[] trozos=respuesta.split("#");
                //Obtener url kml
                String kml=trozos[0];
                //Obtener distancia
                int distancia=Integer.parseInt(trozos[1]);
                //Obtener instrucciones - Tabla html sin <table>
                String instrucciones=trozos[2];
                //Obtener kml texto
                String cadptsgoogle=trozos[3];
                //Límites
                String[] coordenadasTexto=trozos[4].split(";");
                
                //Lanzar jsp montado                
                request.setAttribute("cadptsgoogle", cadptsgoogle);
                request.setAttribute("instrucciones", instrucciones);
                request.setAttribute("distancia", distancia);
                request.setAttribute("arcos", coordenadasTexto);
                
                 /**
             * **********************
             * Frontera
            ************************
             */
            //Obtener frontera del mapa
            //Abrir socket y enviar peticion
            Datos.getDatos();
            Socket socket3 = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os3 = new BufferedWriter(new OutputStreamWriter(socket3.getOutputStream()));

            //Petición
            os3.write("frontera\n");
            os3.flush();

            //Respuesta - Lat sup, lat inf, lon izq, lon der separados por #
            BufferedReader is3 = new BufferedReader(new InputStreamReader(socket3.getInputStream()));
            String respuesta3 = is3.readLine();

            String[] trozos3 = respuesta3.split("#");
            double sup, inf, izq, der;
            sup = Double.parseDouble(trozos3[0]);
            inf = Double.parseDouble(trozos3[1]);
            izq = Double.parseDouble(trozos3[2]);
            der = Double.parseDouble(trozos3[3]);

            request.setAttribute("fsup", sup);
            request.setAttribute("finf", inf);
            request.setAttribute("fizq", izq);
            request.setAttribute("fder", der);

            /**
             * **********************
             * Iconos
            ************************
             */
            //Iconos sobre el mapa
            //Abrir socket y enviar peticion
            Socket socket2 = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os2 = new BufferedWriter(new OutputStreamWriter(socket2.getOutputStream()));

            //Petición
            os2.write("iconos\n");
            os2.flush();

            //Respuesta - Lat sup, lat inf, lon izq, lon der separados por #
            BufferedReader is2 = new BufferedReader(new InputStreamReader(socket2.getInputStream()));
            String respuesta2 = "";

            String temp;
            //Leer respuesta completa
            while ((temp = is2.readLine()) != null) {
                respuesta2 += temp;
            }

            //Lista de elementos -id, tipo, comentario, latitud, longitud
            if (!respuesta2.isEmpty()) {
                String[] iconos = respuesta2.split("#-#");
                if (iconos.length > 0) {
                    request.setAttribute("iconos", iconos);
                }
            }
            
            

                RequestDispatcher view = request.getRequestDispatcher(url);
                view.forward(request, response);

            }
        } catch (IOException | NumberFormatException | ServletException ex) {
            errores.add((ex.getMessage()));
            request.setAttribute("errores", errores);
            RequestDispatcher view = request.getRequestDispatcher("/index");
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
