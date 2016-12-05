package controlador;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.ObjectInputStream;
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
import javax.servlet.http.HttpSession;
import saferoute.struct.Persona;


@WebServlet(name = "cargarUsuario", urlPatterns = {"/cargarUsuario"})
public class cargarUsuario extends HttpServlet {

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
        String url = "usuario.jsp";
        List errores = new ArrayList();
        try {
                //Abrir socket y enviar peticion
                Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
                //Petición
                BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

                //Petición
                os.write("infousuario " + request.getSession(false).getAttribute("id")+"\n");
                os.flush();
                
                //Obtener persona
                ObjectInputStream is=new ObjectInputStream(socket.getInputStream());
                Persona persona=(Persona)is.readObject();
                
                //Incluir en el request
                if(persona!=null){
                    HttpSession sesion = request.getSession(true);
                    sesion.removeAttribute("info");
                    sesion.setAttribute("info", persona);
                }else{
                    throw new Exception("No existe información para el usuario indicado.");
                }
                
                //Lanzar jsp montado                
                RequestDispatcher view = request.getRequestDispatcher(url);
                view.forward(request, response);

            
        } catch (Exception ex) {
            errores.add((ex.getMessage()));
            request.setAttribute("errores", errores);
            RequestDispatcher view = request.getRequestDispatcher("/index.jsp");
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
