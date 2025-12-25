package servlets;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;

@WebServlet("/postJob")
public class PostJobServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String skills = request.getParameter("skills");
        String salary = request.getParameter("salary");
        String location = request.getParameter("location");

        int recruiterId = (int) request.getSession().getAttribute("userId");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/jobportal_db", "root", "root");

            String sql = "INSERT INTO jobs (title, description, skills, salary, location, recruiter_id, status) VALUES (?, ?, ?, ?, ?, ?, 'pending')";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, description);
            ps.setString(3, skills);
            ps.setBigDecimal(4, new java.math.BigDecimal(salary));
            ps.setString(5, location);
            ps.setInt(6, recruiterId);

            ps.executeUpdate();
            conn.close();

            response.sendRedirect("dashboard_recruiter.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
