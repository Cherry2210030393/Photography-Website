package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    private static final String DB_URL = "jdbc:mysql://localhost:3306/sys";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "srivishnu@123";
    static {
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

   
        String hashedPassword = hashPassword(password);

    
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        if (validateUser(email, hashedPassword)) {
      
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            response.sendRedirect("welcome.jsp"); 
        } else {
            out.println("<html><body>");
            out.println("<h3>Invalid email or password.</h3>");
            out.println("<a href='login.jsp'>Try again</a>");
            out.println("</body></html>");
        }
    }

    private boolean validateUser(String email, String hashedPassword) {
        boolean isValid = false;

       
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT password FROM users WHERE email = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);

                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String storedPassword = rs.getString("password");

                     
                        if (storedPassword.equals(hashedPassword)) {
                            isValid = true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isValid;
    }

    private String hashPassword(String password) {
        
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }
}
