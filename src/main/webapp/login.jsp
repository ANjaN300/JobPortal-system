<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Job Portal</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 400px; margin: 50px auto; background: #fff;
            padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);}
        h2 { text-align: center; }
        input, button {
            width: 100%; padding: 10px; margin: 8px 0;
            border: 1px solid #ccc; border-radius: 4px;
        }
        button { background: #007bff; color: white; border: none; cursor: pointer; }
        button:hover { background: #0056b3; }
        a { display: block; text-align: center; margin-top: 10px; color: #28a745; }
    </style>
</head>
<body>
<div class="container">
    <h2>Login</h2>
    <form action="login" method="post">
        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <button type="submit">Login</button>
    </form>
    <a href="register.jsp">Don't have an account? Register</a>
</div>
</body>
</html>
