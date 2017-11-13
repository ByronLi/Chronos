package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.Database;
import objectFiles.*;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   // this servlet needs two parameters 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // what should the port be here????
        Database db = new Database("HostInfo", "localhost", 6789);
        try {
			db.getConnection();
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
        
        int hostID = db.authenticateHost(username, password);
        if(hostID > 0)
        {
        		Host host = db.getHost(hostID);
        		request.setAttribute("host", host);
        		// CHANGE the destination
            RequestDispatcher rs = request.getRequestDispatcher("host.jsp");
            rs.forward(request, response);
        }
        else if (hostID == -1)
        {
           // go back to the login page
           RequestDispatcher rs = request.getRequestDispatcher("login.html");
           rs.include(request, response);
        }
    }  
}
