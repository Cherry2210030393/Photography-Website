package servlet;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/UploadServlet")
@MultipartConfig
public class UploadServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Part filePart = request.getPart("file");
        String imageName = request.getParameter("image_name");
        String description = request.getParameter("description");
        String artist = request.getParameter("artist");
        String tags = request.getParameter("tags");

        
        String fileType = filePart.getContentType();
        if (!fileType.equals("image/jpeg") && !fileType.equals("image/png")) {
            response.getWriter().write("Error: Only JPG or PNG files are allowed.");
            return;
        }

        Connection con = null;
        PreparedStatement pst = null;
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "srivishnu@123");

     
            String query = "INSERT INTO images (image_name, image_data, description, artist, tags) VALUES (?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);

            
            InputStream inputStream = filePart.getInputStream();

            
            pst.setString(1, imageName);
            pst.setBlob(2, inputStream);
            pst.setString(3, description);
            pst.setString(4, artist);
            pst.setString(5, tags);
           
            pst.executeUpdate();

           
            response.getWriter().write("Upload successful!");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("An error occurred: " + e.getMessage());
        } finally {
            
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        
        response.sendRedirect("gallery.jsp");
    }
}
