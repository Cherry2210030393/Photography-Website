package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

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
       
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        boolean termsAccepted = "on".equals(request.getParameter("terms"));

       
        if (!password.equals(confirmPassword)) {
            showError(response, "Passwords do not match.");
            return;
        }

       
        if (!termsAccepted) {
            showError(response, "You must agree to the terms and conditions.");
            return;
        }

       
        String hashedPassword = hashPassword(password);

     
        if (registerUser(name, email, hashedPassword)) {
           
            response.sendRedirect("login.jsp?message=Registration successful! Please log in.");
        } else {
            showError(response, "Registration failed. Please try again.");
        }
    }

    private boolean registerUser(String name, String email, String hashedPassword) {
        boolean success = false;

       
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, hashedPassword);

                int rowsInserted = stmt.executeUpdate();
                success = (rowsInserted > 0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
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

    private void showError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h3>" + message + "</h3>");
        out.println("<a href='register.jsp'>Try again</a>");
        out.println("</body></html>");
    }
}
