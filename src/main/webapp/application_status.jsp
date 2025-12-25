<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%
    if (session.getAttribute("userId") == null || !"seeker".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jobportal_db", "root", "root");

        String sql = "SELECT j.title, a.status " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "WHERE a.seeker_id = ?";
        ps = conn.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();
%>
<html>
<head>
    <title>Application Status</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
            color: #fff;
            padding: 30px;
        }
        h2 { margin-bottom: 20px; }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #e94560;
            color: white;
        }
    </style>
</head>
<body>
    <h2>Your Application Status</h2>
    <table>
        <tr>
            <th>Job Title</th>
            <th>Status</th>
        </tr>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
        %>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("status") %></td>
        </tr>
        <%
            }
            if (!hasData) {
        %>
        <tr>
            <td colspan="2">No applications found.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    }
%>
