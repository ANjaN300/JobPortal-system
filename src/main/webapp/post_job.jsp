<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"recruiter".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Post a Job</title>
    <style>
        body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background: #121212;
    color: #f1f1f1;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
}

.container {
    background: #1e1e1e;
    padding: 30px;
    border-radius: 12px;
    width: 400px;
    box-shadow: 0px 4px 15px rgba(0,0,0,0.5);
}

h2 {
    text-align: center;
    color: #e94560; /* changed to red */
    margin-bottom: 20px;
}

label {
    font-weight: bold;
    margin-top: 10px;
    display: block;
}

input, textarea {
    width: 100%;
    padding: 10px;
    margin-top: 6px;
    border: none;
    border-radius: 8px;
    background: #2c2c2c;
    color: #f1f1f1;
}

textarea {
    resize: none;
    height: 80px;
}

button {
    margin-top: 15px;
    width: 100%;
    padding: 12px;
    background: #e94560; /* changed to red */
    border: none;
    border-radius: 8px;
    color: white;
    font-weight: bold;
    cursor: pointer;
    transition: 0.3s;
}

button:hover {
    background: #ff6b81; /* light red hover */
}

a {
    display: block;
    text-align: center;
    margin-top: 15px;
    color: #e94560; /* changed to red */
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
    color: #ff6b81; /* light red hover */
}

    </style>
</head>
<body>
    <div class="container">
        <h2>Post a New Job</h2>
        <form action="postJob" method="post">
            <label>Title:</label>
            <input type="text" name="title" required>

            <label>Description:</label>
            <textarea name="description" required></textarea>

            <label>Skills:</label>
            <input type="text" name="skills" required>

            <label>Salary:</label>
            <input type="number" name="salary" step="0.01" required>

            <label>Location:</label>
            <input type="text" name="location" required>

            <button type="submit">Submit Job</button>
        </form>
        <a href="dashboard_recruiter.jsp">← Back to Dashboard</a>
    </div>
</body>
</html>
