package servlets;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/JobApproveServlet")
public class JobApproveServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String jobId = request.getParameter("jobId"); // from the link/button

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/jobportal_db", "root", "root");

            String sql = "UPDATE jobs SET status = 'Approved' WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, jobId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                out.println("<script>alert('Job Approved Successfully');window.location='ViewJobs.jsp';</script>");
            } else {
                out.println("<script>alert('Job Approval Failed');window.location='ViewJobs.jsp';</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('Error: " + e.getMessage() + "');window.location='ViewJobs.jsp';</script>");
        } finally {
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}
