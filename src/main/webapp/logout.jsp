<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Logged Out</title>
    <style>
        body {
            background: #1a1a1a;
            font-family: Arial, sans-serif;
            color: #fff;
            text-align: center;
            padding: 100px;
        }
        .box {
            background: #2c2c2c;
            display: inline-block;
            padding: 30px 50px;
            border-radius: 15px;
            box-shadow: 0px 0px 20px rgba(0,0,0,0.6);
        }
        h2 {
            color: #ff4b5c;
        }
        p {
            color: #ccc;
            margin-bottom: 20px;
        }
        a {
            background: #ff4b5c;
            color: #fff;
            padding: 12px 25px;
            text-decoration: none;
            border-radius: 8px;
            transition: 0.3s;
        }
        a:hover {
            background: #e63946;
        }
    </style>
    <meta http-equiv="refresh" content="3;url=login.jsp">
</head>
<body>
    <div class="box">
        <h2>You have been logged out</h2>
        <p>Redirecting to login page in 3 seconds...</p>
        <a href="login.jsp">Go to Login Now</a>
    </div>
</body>
</html>
