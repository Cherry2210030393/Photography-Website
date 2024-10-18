<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
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
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            overflow: hidden;
        }

        .contact-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
            animation: slideIn 0.5s ease-in-out;
        }

        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
            text-align: left;
        }

        input[type="text"],
        input[type="email"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
            margin-bottom: 15px;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        textarea:focus {
            border-color: #3498db;
            outline: none;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            transition: background-color 0.3s ease, transform 0.3s ease;
            margin-top: 15px;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
    <script>
        function validateForm() {
            const name = document.forms["contactForm"]["name"].value;
            const email = document.forms["contactForm"]["email"].value;
            const message = document.forms["contactForm"]["message"].value;

            if (name === "" || email === "" || message === "") {
                alert("All fields must be filled out.");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

    <div class="contact-container">
        <h1>Contact Us</h1>
        <form name="contactForm" action="ContactServlet" method="post" onsubmit="return validateForm()">
            <label for="name">Name:</label>
            <input type="text" name="name" required />

            <label for="email">Email:</label>
            <input type="email" name="email" required />

            <label for="message">Message:</label>
            <textarea name="message" rows="5" required></textarea>

            <input type="submit" value="Send Message" />
        </form>
    </div>

</body>
</html>
