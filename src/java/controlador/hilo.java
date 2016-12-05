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
@WebServlet(name = "hilo", urlPatterns = {"/hilo"})
public class hilo extends HttpServlet {

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
        String url = "/foro.jsp";
        List errores = new ArrayList();
        try {

            /**
             * **********************
             * Hilos del foro ***********************
             */
            //Abrir socket y enviar peticion
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));

            //Obtener parámetros
            String id = request.getParameter("id");

            //Petición
            os.write("listarhilo#" + id + "\n");
            os.flush();

            //Respuesta - listado id\uffff idpadre\uffffidautor\uffff fecha\uffff
            // titulo\uffff mensaje separado por \fffe\uffff
            BufferedReader is = new BufferedReader(new InputStreamReader(socket.getInputStream()));
            String respuesta = "";

            String linea;
            while ((linea = is.readLine()) != null) {
                respuesta += linea;
            }
            String[] trozos = respuesta.split("\ufffe\uffff");

            List<String[]> hilos = new ArrayList();
            if (trozos != null) {
                for (String temp : trozos) {
                    if (temp.length() > 0) {
                        String[] noticia = temp.split("\u0001");

                        noticia[5] = noticia[5].replaceAll("\n", "<br/>");

                        hilos.add(noticia);
                    }
                }
            }

            //Salida
            request.setAttribute("hilos", hilos);
            request.setAttribute("idpadre", id);

            //Añadir request
            RequestDispatcher view = request.getRequestDispatcher(url);
            view.forward(request, response);

        } catch (Exception ex) {
            errores.add((ex.getMessage()));
            request.setAttribute("errores", errores);
            RequestDispatcher view = request.getRequestDispatcher("/foro");
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
