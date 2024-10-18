package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        
        String dbURL = "jdbc:mysql://localhost:3306/sys"; 
        String dbUser = "root"; 
        String dbPassword = "srivishnu@123"; 

        Connection con = null;
        PreparedStatement pst = null;

        try {
           
            Class.forName("com.mysql.cj.jdbc.Driver");

            
            con = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            
            String query = "INSERT INTO contact_form (name, email, message) VALUES (?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, message);

            
            int rowsAffected = pst.executeUpdate();

            
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html lang='en'>");
            out.println("<head>");
            out.println("<meta charset='UTF-8'>");
            out.println("<meta name='viewport' content='width=device-width, initial-scale=1.0'>");
            out.println("<title>Contact Confirmation</title>");
            out.println("<link rel='stylesheet' href='styles.css'>"); 
            out.println("<style>");
            out.println("body { background: linear-gradient(135deg, #f3f4f7, #cfd9df); font-family: 'Poppins', sans-serif; }");
            out.println(".container { max-width: 600px; margin: 50px auto; padding: 20px; border-radius: 10px; background: #fff; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); }");
            out.println("h2 { text-align: center; color: #333; animation: fadeIn 1s; }");
            out.println("p { text-align: center; color: #555; animation: fadeInUp 1s; }");
            out.println("a { display: block; text-align: center; margin-top: 20px; font-size: 1.2em; color: #007BFF; text-decoration: none; }");
            out.println("a:hover { text-decoration: underline; }");
            out.println("@keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }");
            out.println("@keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }");
            out.println("</style>");
            out.println("</head>");
            out.println("<body>");

            if (rowsAffected > 0) {
                out.println("<div class='container'>");
                out.println("<h2>Thank you for contacting us, " + name + "!</h2>");
                out.println("<p>Your message has been received and we will get back to you shortly.</p>");
                out.println("<a href='index.jsp'>Go Back</a>");
                out.println("</div>");
            } else {
                out.println("<div class='container'>");
                out.println("<h2>Error: Your message could not be sent.</h2>");
                out.println("<p>Please try again later.</p>");
                out.println("<a href='index.jsp'>Go Back</a>");
                out.println("</div>");
            }
            out.println("</body>");
            out.println("</html>");
            out.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body>");
            out.println("<h2>Error: An error occurred while processing your request.</h2>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='index.jsp'>Go Back</a>");
            out.println("</body></html>");
            out.close();
        } finally {
            
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
