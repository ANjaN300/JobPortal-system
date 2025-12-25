<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"seeker".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Job Seeker Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
            color: #fff;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        h2 {
            font-size: 2rem;
            margin-bottom: 30px;
            color: #f9f9f9;
            text-shadow: 0px 0px 10px rgba(0,0,0,0.6);
        }
        .dashboard-links {
            display: flex;
            gap: 20px;
        }
        a {
            text-decoration: none;
            color: #fff;
            background: #e94560;
            padding: 12px 25px;
            border-radius: 8px;
            transition: background 0.3s ease, transform 0.2s ease;
            font-weight: bold;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.3);
        }
        a:hover {
            background: #ff6b81;
            transform: translateY(-3px);
        }
        a:active {
            transform: translateY(0px);
        }
    </style>
</head>
<body>
    <h2>Welcome, Job Seeker!</h2>
    <div class="dashboard-links">
        <a href="job_list.jsp">Browse Jobs</a>
        <a href="application_status.jsp">Application Status</a> <!-- ✅ Fixed -->
        <a href="logout.jsp">Logout</a>
    </div>
</body>
</html>
