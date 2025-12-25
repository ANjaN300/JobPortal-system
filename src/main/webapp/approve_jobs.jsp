<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pending Job Approvals</title>
    <style>
    body { 
        background-color: #111; 
        color: #fff; 
        font-family: Arial; 
        text-align: center; 
    }
    table { 
        margin: 20px auto; 
        border-collapse: collapse; 
        width: 90%; 
    }
    th, td { 
        padding: 10px; 
        border: 1px solid #333; 
    }
    th { 
        background-color: #222; 
        font-weight: bold; 
    }
    tr:nth-child(even) { 
        background-color: #1a1a1a; 
    }
    a { 
        color: #e94560; 
        text-decoration: none; 
        padding: 5px 10px; 
        border: 1px solid #e94560; 
        border-radius: 4px; 
        font-weight: bold;
        transition: 0.3s;
    }
    a:hover { 
        background-color: #ff6b81; 
        color: #fff; 
    }
    a.reject { 
        border-color: #ff4c4c; 
        color: #ff4c4c; 
    }
    a.reject:hover { 
        background-color: #ff4c4c; 
        color: #fff; 
    }
    h1 {
        color: #e94560; 
        text-shadow: 0 0 10px rgba(233, 69, 96, 0.5);
    }
    </style>
</head>
<body>
<h1>Pending Job Approvals</h1>

<%
    Integer recruiterId = (Integer) session.getAttribute("userId");
    if(recruiterId == null){
        response.sendRedirect("login.jsp");
        return;
    }

    String jdbcURL = "jdbc:mysql://localhost:3306/jobportal_db";
    String jdbcUsername = "root";
    String jdbcPassword = "root";

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);

        String sql = "SELECT a.id AS application_id, j.title, u.name, a.status, a.resume " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id=j.id " +
                     "JOIN users u ON a.seeker_id=u.id " +
                     "WHERE j.recruiter_id=? AND a.status='pending'";
        pst = conn.prepareStatement(sql);
        pst.setInt(1, recruiterId);
        rs = pst.executeQuery();
%>

<table>
    <tr>
        <th>Application ID</th>
        <th>Job Title</th>
        <th>Applicant Name</th>
        <th>Status</th>
        <th>Resume</th>
        <th>Actions</th>
    </tr>

<%
        boolean hasJobs = false;
        while (rs.next()) {
            hasJobs = true;
            String resume = rs.getString("resume");
%>
    <tr>
        <td><%= rs.getInt("application_id") %></td>
        <td><%= rs.getString("title") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("status") %></td>
        <td>
            <% if(resume != null && !resume.trim().isEmpty()) { %>
                <a href="uploads/<%= resume %>" target="_blank">View</a>
            <% } else { %>
                <span style="color:gray;">No file</span>
            <% } %>
        </td>
        <td>
            <a href="ApproveJob?id=<%= rs.getInt("application_id") %>">Approve</a>
            <a href="RejectJob?id=<%= rs.getInt("application_id") %>" class="reject">Reject</a>
        </td>
    </tr>
<%
        }

        if(!hasJobs){
%>
    <tr>
        <td colspan="6" style="color: lightgray;">No pending applications.</td>
    </tr>
<%
        }

    } catch(Exception e){
%>
<tr>
    <td colspan="6" style="color:red;">Error: <%= e.getMessage() %></td>
</tr>
<%
        e.printStackTrace();
    } finally {
        if(rs != null) try { rs.close(); } catch(SQLException ignore) {}
        if(pst != null) try { pst.close(); } catch(SQLException ignore) {}
        if(conn != null) try { conn.close(); } catch(SQLException ignore) {}
    }
%>
</table>
</body>
</html>
