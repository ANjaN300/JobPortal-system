<%@ page import="java.sql.*" %>
<%@ page import="utils.DBUtil" %>
<%
    if (session.getAttribute("userId") == null || !"recruiter".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Applicants for Your Jobs</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #1a1a2e, #16213e, #0f3460);
            color: #fff;
            padding: 30px;
            text-align: center;
        }
        h2 { margin-bottom: 20px; }
        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            margin-top: 20px;
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
        .status-approved { color: #00ff00; font-weight: bold; }
        .status-rejected { color: #ff4444; font-weight: bold; }
        .status-pending { color: #ffcc00; font-weight: bold; }
        a.back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 15px;
            color: #00d4ff;
            text-decoration: none;
            border: 1px solid #00d4ff;
            border-radius: 5px;
        }
        a.back-link:hover {
            background-color: #00d4ff;
            color: #000;
        }
    </style>
</head>
<body>
    <h2>Applicants for Your Jobs</h2>
    <table>
        <tr>
            <th>Job Title</th>
            <th>Applicant Name</th>
            <th>Status</th>
        </tr>
<%
    try (Connection conn = DBUtil.getConnection()) {
        String sql = "SELECT j.title, u.name, a.status FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.id " +
                     "JOIN users u ON a.seeker_id = u.id " +
                     "WHERE j.recruiter_id = ?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, (Integer)session.getAttribute("userId"));
        ResultSet rs = ps.executeQuery();
        boolean hasData = false;
        while (rs.next()) {
            hasData = true;
            String status = rs.getString("status");
            String statusClass = "status-pending";
            if ("approved".equalsIgnoreCase(status)) statusClass = "status-approved";
            else if ("rejected".equalsIgnoreCase(status)) statusClass = "status-rejected";
%>
        <tr>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("name") %></td>
            <td class="<%= statusClass %>"><%= status %></td>
        </tr>
<%
        }
        if(!hasData) {
%>
        <tr>
            <td colspan="3" style="color: lightgray;">No applicants found.</td>
        </tr>
<%
        }
    } catch (Exception e) {
        out.println("<tr><td colspan='3' style='color:red;'>Error: " + e.getMessage() + "</td></tr>");
        e.printStackTrace();
    }
%>
    </table>
    <a class="back-link" href="dashboard_recruiter.jsp">Back</a>
</body>
</html>
