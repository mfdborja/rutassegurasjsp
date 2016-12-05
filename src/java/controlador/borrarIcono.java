/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author usuario
 */
@WebServlet(name = "borrarIcono", urlPatterns = {"/borrarIcono"})
public class borrarIcono extends HttpServlet {

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
        String url = "/index";
        List errores = new ArrayList();
        try {
            //Abrir socket y enviar peticion
            Datos.getDatos();
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

            //Obtener variables
            String idmensaje=request.getParameter("id");
            String idBorrador=null;
            
            if (request.getSession(false) != null) {
                idBorrador = "" + (int) request.getSession(false).getAttribute("id");
            }
            if (idBorrador == null) {
                throw new Exception("No tiene permiso para borrar mensajes.");
            }
            
            //Petición
            os.write("borraricono#"+idmensaje+"#"+idBorrador+"\n");
            os.flush();

            BufferedReader is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String respuesta = is.readLine();
               

            //Añadir request
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);

        } catch (Exception ex) {
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
