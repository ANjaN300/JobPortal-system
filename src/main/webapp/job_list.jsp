<%@ page import="java.sql.*" %>
<%@ page import="utils.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("userId") == null || !"seeker".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Available Jobs</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #121212;
            color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        header {
            background: linear-gradient(90deg, #e94560, #ff6b81);
            padding: 20px;
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #fff;
            letter-spacing: 1px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.4);
        }

        main {
            padding: 30px;
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            color: #ff4c60;
            text-align: center;
            margin-bottom: 25px;
            font-size: 24px;
        }

        .job-card {
            background: #1e1e1e;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
            transition: transform 0.2s ease, background 0.3s;
        }

        .job-card:hover {
            transform: translateY(-5px);
            background: #242424;
        }

        .job-title {
            font-size: 20px;
            font-weight: bold;
            color: #ff4c60;
            margin-bottom: 10px;
        }

        .job-details {
            font-size: 14px;
            margin-bottom: 15px;
            color: #ccc;
        }

        .job-details span {
            display: inline-block;
            margin-right: 20px;
        }

        .apply-section {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        input[type="file"] {
            background: #2e2e2e;
            border: 1px solid #555;
            border-radius: 6px;
            padding: 6px;
            color: #ccc;
            font-size: 13px;
        }

        button {
            background-color: #e94560;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            color: #fff;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: #ff6b81;
        }

        .back {
            display: block;
            margin: 30px auto;
            width: fit-content;
            padding: 10px 20px;
            text-decoration: none;
            color: #e94560;
            border: 2px solid #e94560;
            border-radius: 8px;
            transition: 0.3s;
            font-weight: bold;
        }

        .back:hover {
            background-color: #e94560;
            color: #fff;
        }
    </style>
</head>
<body>
    <header>Job Portal - Job Listings</header>
    <main>
        <h2>Available Jobs</h2>
        <%
            try (Connection conn = DBUtil.getConnection()) {
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM jobs");
                ResultSet rs = ps.executeQuery();
                boolean hasJobs = false;
                while (rs.next()) {
                    hasJobs = true;
        %>
        <div class="job-card">
            <div class="job-title"><%= rs.getString("title") %></div>
            <div class="job-details">
                <span>📍 <%= rs.getString("location") %></span>
                <span>💰 ₹<%= rs.getDouble("salary") %></span>
            </div>
            <form class="apply-section" action="applyJob" method="post" enctype="multipart/form-data">
                <input type="hidden" name="jobId" value="<%= rs.getInt("id") %>">
                <input type="file" name="resume" accept=".pdf,.doc,.docx" required>
                <button type="submit">Apply Now</button>
            </form>
        </div>
        <%
                }
                if (!hasJobs) {
                    out.println("<p style='text-align:center;color:#aaa;'>No jobs available at the moment.</p>");
                }
                rs.close();
                ps.close();
            } catch (Exception e) {
                out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            }
        %>

        <a href="dashboard_seeker.jsp" class="back">⬅ Back to Dashboard</a>
    </main>
</body>
</html>
