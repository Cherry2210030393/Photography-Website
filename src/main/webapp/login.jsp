<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Photography Website</title>
    <style>
     
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: url('https://images.unsplash.com/photo-1506748686214e9df14f5f6e9d1b6d64dcdb9cfc233d') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
            color: #fff;
        }

     
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
            text-align: center;
            animation: scaleUp 0.5s ease;
        }

        h2 {
            margin-bottom: 20px;
            font-size: 2.2em;
            color: #333;
            font-weight: 700;
        }

       
        .login-container input[type="email"],
        .login-container input[type="password"] {
            width: 90%;
            padding: 12px;
            margin: 12px 0;
            border: 2px solid transparent;
            border-radius: 8px;
            font-size: 1em;
            background-color: #f8f8f8;
            transition: all 0.3s ease;
            color: #333;
        }

        .login-container input[type="email"]:focus,
        .login-container input[type="password"]:focus {
            outline: none;
            border-color: #5a67d8;
            box-shadow: 0 0 8px rgba(90, 103, 216, 0.6);
        }

      
        .login-container button {
            padding: 12px 20px;
            background-color: #5a67d8;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 1.1em;
            width: 90%;
            transition: all 0.3s ease;
        }

        .login-container button:hover {
            background-color: #434fc7;
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(90, 103, 216, 0.6);
        }

        
        .login-container p {
            margin-top: 20px;
            color: #666;
        }

        .login-container a {
            color: #5a67d8;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-container a:hover {
            color: #434fc7;
        }

      
        @keyframes scaleUp {
            0% {
                transform: scale(0.9);
                opacity: 0;
            }
            100% {
                transform: scale(1);
                opacity: 1;
            }
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p>Don't have an account? <a href="register.jsp">Register here</a></p>
    </div>

</body>
</html>
