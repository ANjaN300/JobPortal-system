package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RejectJob")
public class RejectJob extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/jobportal_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASS = "root";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS);

                String sql = "UPDATE applications SET status = 'rejected' WHERE id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(idParam));
                ps.executeUpdate();

                ps.close();
                conn.close();

                response.sendRedirect("approve_jobs.jsp");
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Error rejecting application: " + e.getMessage());
            }
        }
    }
}
