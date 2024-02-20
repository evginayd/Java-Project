package registration;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = request.getParameter("name");
		String userpassword = request.getParameter("pass");
		String userrepeatedpassword = request.getParameter("re_pass");
		String usermail = request.getParameter("email");
		String usermobile = request.getParameter("contact");
		RequestDispatcher dispatcher = null;
		Connection con = null;
		
		if(username == null || username.equals("")) 
		{
			request.setAttribute("status", "invalidName");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		if(userpassword == null || userpassword.equals("")) 
		{
			request.setAttribute("status", "invalidPassword");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		else if(!userpassword.equals(userrepeatedpassword)) 
		{
			request.setAttribute("status", "invalidConfirm Password");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		if(usermail == null || usermail.equals("")) 
		{
			request.setAttribute("status", "invalidEmail");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		if(usermobile == null || usermobile.equals("")) 
		{
			request.setAttribute("status", "invalidMobile");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		else if(usermobile.length() > 11) 
		{
			request.setAttribute("status", "invalidMobileLength");
			dispatcher = request.getRequestDispatcher("registration.jsp");
			dispatcher.forward(request,  response);
		}
		try 
		{
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Users?useSSL=false", "", ""); // your username and password
			PreparedStatement pst = con.prepareStatement("INSERT INTO Users(username, userpassword, usermail, usermobile) VALUES(?,?,?,?) ");
			pst.setString(1, username);
			pst.setString(2, userpassword);
			pst.setString(3, usermail);
			pst.setString(4, usermobile);
			
			int rowCount = pst.executeUpdate();
			dispatcher = request.getRequestDispatcher("registration.jsp");
			if(rowCount > 0) 
			{
				request.setAttribute("status", "success");
				
			}
			else 
			{
				request.setAttribute("status", "failed");
			}
			dispatcher.forward(request, response);
		}catch(Exception e) 
		{
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

}
