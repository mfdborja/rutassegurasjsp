/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.http.Part;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "crearUsuarios", urlPatterns = {"/crearUsuarios"})
public class crearUsuarios extends HttpServlet {

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
        String url = "/usuarios.jsp";
        List errores = new ArrayList();
        
        try {
             /*Part filePart = request.getP-+art("file"); // Retrieves <input type="file" name="file">
    InputStream fileContent = filePart.getInputStream();
            System.out.println(request.getParts().size());
            BufferedReader flujoArchivo = new BufferedReader(new InputStreamReader(fileContent));
            String linea="";
            while((linea+=flujoArchivo.readLine())!=null){
                System.out.println(linea);
            }*/
          
            //Abrir socket y enviar peticion
            Socket socket = new Socket(Datos.ipServidor, Datos.puertoServidor);
            //Petición
            BufferedWriter os = new BufferedWriter(new OutputStreamWriter(socket.getOutputStream()));
            os.write("nuevousuario#" +"\n");
            //Obtener id administrador
            String idAdmin = "" + (Integer) request.getSession(false).getAttribute("id");
            String asunto = request.getParameter("asunto");
            String mensaje = request.getParameter("contenido");
            if (idAdmin != null) {
                
                os.newLine();
                os.flush();
                os.write(mensaje);
            } else {
                throw new Exception("Debe loguearse como administrador para enviar emails.");
            }

            os.flush();
            os.close();

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
