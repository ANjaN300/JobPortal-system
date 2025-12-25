<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register - Job Portal</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .container { width: 400px; margin: 50px auto; background: #fff;
            padding: 20px; border-radius: 8px; box-shadow: 0 0 10px rgba(0,0,0,0.1);}
        h2 { text-align: center; }
        input, select, button {
            width: 100%; padding: 10px; margin: 8px 0;
            border: 1px solid #ccc; border-radius: 4px;
        }
        button { background: #28a745; color: white; border: none; cursor: pointer; }
        button:hover { background: #218838; }
        a { display: block; text-align: center; margin-top: 10px; color: #007bff; }
    </style>
</head>
<body>
<div class="container">
    <h2>Create an Account</h2>
    <form action="register" method="post">
        <label>Name:</label>
        <input type="text" name="name" required>

        <label>Email:</label>
        <input type="email" name="email" required>

        <label>Password:</label>
        <input type="password" name="password" required>

        <label>Role:</label>
        <select name="role" required>
            <option value="">--Select--</option>
            <option value="seeker">Job Seeker</option>
            <option value="recruiter">Recruiter</option>
        </select>

        <button type="submit">Register</button>
    </form>
    <a href="login.jsp">Already have an account? Login</a>
</div>
</body>
</html>
