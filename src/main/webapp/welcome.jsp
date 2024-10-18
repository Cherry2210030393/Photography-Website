<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Image</title>
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

        .form-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
            width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
            animation: slideIn 1s ease-in-out;
        }

        label {
            display: block;
            margin: 15px 0 5px;
            font-weight: bold;
        }

        input[type="text"],
        textarea,
        input[type="file"] {
            width: 100%;
            padding: 10px;
            border: 2px solid #ccc;
            border-radius: 5px;
            transition: border-color 0.3s ease;
            margin-bottom: 15px;
        }

        input[type="text"]:focus,
        textarea:focus,
        input[type="file"]:focus {
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

        textarea {
            resize: none;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h1>Upload Image</h1>
        <form action="UploadServlet" method="post" enctype="multipart/form-data">
            <label for="image_name">Image Name:</label>
            <input type="text" name="image_name" required />

            <label for="description">Description:</label>
            <textarea name="description" rows="4" required></textarea>

            <label for="artist">Artist:</label>
            <input type="text" name="artist" required />

            <label for="tags">Tags (comma-separated):</label>
            <input type="text" name="tags" />

            <label for="file">Select JPG or PNG Image:</label>
            <input type="file" name="file" accept="image/jpeg,image/png" required /><br>

            <input type="submit" value="Upload" />
        </form>
    </div>

</body>
</html>
