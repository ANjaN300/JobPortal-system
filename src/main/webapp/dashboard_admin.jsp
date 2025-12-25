<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h2>Admin Panel</h2>
<a href="approve_jobs.jsp">Approve Jobs</a> | 
<a href="logout.jsp">Logout</a>
</body>
</html>
