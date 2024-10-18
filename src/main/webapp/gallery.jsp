<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f3f4f7, #cfd9df);
            color: #333;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        h1 {
            text-align: center;
            font-size: 3em;
            color: #333;
            margin: 40px 0;
            animation: fadeIn 1s ease-in-out;
        }

        .gallery-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin: 20px auto;
            max-width: 1200px;
            gap: 20px;
            animation: fadeInUp 1s ease-in-out;
        }

        .gallery-item {
            position: relative;
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.4s ease, box-shadow 0.4s ease;
            text-align: center; 
        }

        .gallery-item:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
        }

        .gallery-item img {
            display: block;
            width: 400px;
            height: 300px;
            object-fit: cover;
            transition: transform 0.4s ease;
        }

        .gallery-item:hover img {
            transform: scale(1.1);
        }

        .metadata {
            padding: 10px;
            font-size: 0.9em;
            color: #555;
        }

        .go-back {
            text-align: center;
            margin-top: 20px;
            font-size: 1.2em;
            color: #333;
        }

        .go-back a {
            color: #333;
            text-decoration: none;
            display: inline-block;
            padding: 10px 20px;
            background-color: #e0e0e0;
            border-radius: 5px;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        .go-back a:hover {
            background-color: #ccc;
        }

        .go-back a::before {
            content: '\2190'; 
            margin-right: 10px;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes fadeInUp {
            0% {
                opacity: 0;
                transform: translateY(50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }

        footer {
            text-align: center;
            padding: 30px 0;
            background-color: #333;
            color: #fff;
            font-size: 1.2em;
            letter-spacing: 1px;
        }

        footer p {
            margin: 0;
        }

        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>

    <h1>Image Gallery</h1>

    
    <div class="go-back">
        <a href="index.jsp">Go Back to Home</a>
    </div>

    <div class="gallery-container">
        <%
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "srivishnu@123");

                
                String query = "SELECT id, image_name, description, artist FROM images";
                pst = con.prepareStatement(query);
                rs = pst.executeQuery();

                if (!rs.isBeforeFirst()) { 
                    out.println("<div class='error-message'>No images found.</div>");
                }

                while (rs.next()) {
                    int id = rs.getInt("id");
                    String imageName = rs.getString("image_name");
                    String description = rs.getString("description");
                    String artist = rs.getString("artist");
        %>
                    <div class="gallery-item">
                        <a href="ImageServlet?id=<%= id %>" download>
                            <img src="ImageServlet?id=<%= id %>" alt="<%= imageName %>" title="<%= imageName %>">
                        </a>
                        <div class="metadata">
                            <strong><%= imageName %></strong><br>
                            <span>Description: <%= description %></span><br>
                            <span>Artist: <%= artist %></span>
                        </div>
                    </div>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<div class='error-message'>An error occurred: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pst != null) pst.close();
                    if (con != null) con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>

</body>
</html>
