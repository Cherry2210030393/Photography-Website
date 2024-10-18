<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photography Website</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        nav {
            background: #111;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.2);
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 10;
            animation: fadeInDown 1s ease-in-out;
        }

        .logo h2 {
            color: #fff;
            font-size: 2em;
            font-weight: bold;
            letter-spacing: 3px;
            transition: transform 0.3s ease;
        }

        .logo h2:hover {
            transform: scale(1.1);
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        nav ul li {
            position: relative;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            font-size: 1.2em;
            letter-spacing: 1px;
            transition: color 0.3s ease, transform 0.3s ease;
        }

        nav ul li a:hover {
            color: #f39c12;
            transform: scale(1.1);
        }

        nav ul li a::before {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -5px;
            left: 50%;
            background-color: #f39c12;
            transition: all 0.3s ease;
        }

        nav ul li a:hover::before {
            width: 100%;
            left: 0;
        }

        .welcome-section {
            text-align: center;
            margin: 150px auto;
            animation: fadeIn 2s ease-in-out;
        }

        .welcome-section h1 {
            font-size: 3.5em;
            color: #333;
            margin-bottom: 15px;
            font-weight: bold;
        }

        .welcome-section p {
            font-size: 1.5em;
            color: #555;
            margin-bottom: 50px;
        }

        .search-form {
            margin: 40px auto;
            text-align: center;
            animation: fadeInUp 1.5s ease-in-out;
        }

        .search-form input[type="text"] {
            padding: 15px;
            width: 350px;
            font-size: 1.1em;
            border: 2px solid #ccc;
            border-radius: 5px;
            transition: all 0.4s ease;
        }

        .search-form input[type="text"]:focus {
            border-color: #333;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
            outline: none;
        }

        .search-form button {
            padding: 15px 30px;
            background-color: #f39c12;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            margin-left: 20px;
            transition: all 0.3s ease;
        }

        .search-form button:hover {
            background-color: #e67e22;
            transform: scale(1.1);
        }

        .latest-uploads {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin: 40px;
            animation: fadeIn 2s ease-in-out;
        }

        .latest-uploads div {
            margin: 15px;
            text-align: center;
            transform: scale(1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .latest-uploads div:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
        }

        .latest-uploads img {
    width: 400px;
    height: 400px;
    border-radius: 10px;
    transition: transform 0.4s ease;
}


        .latest-uploads img:hover {
            transform: scale(1.1);
        }

        footer {
            background-color: #111;
            color: #fff;
            text-align: center;
            padding: 30px 0;
            animation: fadeInUp 1.5s ease-in-out;
            width: 100%;
        }

        footer p {
            margin: 0;
            font-size: 1.1em;
            letter-spacing: 2px;
        }

        @keyframes fadeIn {
            0% {
                opacity: 0;
            }
            100% {
                opacity: 1;
            }
        }

        @keyframes fadeInDown {
            0% {
                opacity: 0;
                transform: translateY(-50px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
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

        @media screen and (max-width: 768px) {
            nav ul {
                gap: 15px;
            }

            nav ul li a {
                font-size: 1em;
            }

            .welcome-section h1 {
                font-size: 2.5em;
            }

            .welcome-section p {
                font-size: 1.2em;
            }

            .search-form input[type="text"] {
                width: 250px;
            }

            .search-form button {
                padding: 12px 20px;
            }
        }

    </style>
</head>
<body>
    
    <nav>
        <div class="logo">
            <h2>World Of Amazement</h2>
        </div>
        <ul>
            <li><a href="index.jsp">Home</a></li>
            <li><a href="gallery.jsp">Gallery</a></li>
            <li><a href="contact.jsp">Contact</a></li>
            <li><a href="login.jsp">Login</a></li>
            <li><a href="register.jsp">Register</a></li>
        </ul>
    </nav>

    <div class="welcome-section">
        <h1>Welcome to the Photography Website</h1>
        <p>Browse amazing photos from our collection!</p>
    </div>

    <div class="search-form">
    <form action="PhotoServlet" method="post">
        <input type="text" name="searchQuery" placeholder="Search for photos...">
        <button type="submit">Search</button>
    </form>
</div>

    
    <h2 style="text-align: center; margin: 20px;">Latest Uploads</h2>
   <div class="latest-uploads">
    <%
        Connection con = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys", "root", "srivishnu@123");

            
            String query = "SELECT id FROM images ORDER BY id DESC LIMIT 5";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
    %>
                <div>
                    <a href="ImageServlet?id=<%= id %>" download>
                        <img src="ImageServlet?id=<%= id %>" width="400px" height="400px" />
                    </a>
                </div>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignored) {}
            if (pst != null) try { pst.close(); } catch (SQLException ignored) {}
            if (con != null) try { con.close(); } catch (SQLException ignored) {}
        }
    %>
</div>
</body>
</html>
