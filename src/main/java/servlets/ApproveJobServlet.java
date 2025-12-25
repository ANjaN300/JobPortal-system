package servlets;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DBUtil;

@WebServlet("/approveJob") 
public class ApproveJobServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        String role = (String) session.getAttribute("role");

        // Only logged-in recruiters can approve jobs
        if (userId == null || !"recruiter".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String jobIdParam = request.getParameter("id");
        if (jobIdParam == null || jobIdParam.isEmpty()) {
            response.sendRedirect("view_jobs.jsp?error=Invalid+job");
            return;
        }

        int jobId;
        try {
            jobId = Integer.parseInt(jobIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("view_jobs.jsp?error=Invalid+job+ID");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            // Verify recruiter owns this job
            String checkSql = "SELECT recruiter_id FROM jobs WHERE id = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, jobId);
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (!rs.next()) {
                        response.sendRedirect("view_jobs.jsp?error=Job+not+found");
                        return;
                    }
                    int recruiterId = rs.getInt("recruiter_id");
                    if (recruiterId != userId) {
                        response.sendRedirect("view_jobs.jsp?error=Not+authorized");
                        return;
                    }
                }
            }

            // Approve the job
            String updateSql = "UPDATE jobs SET status = 'approved' WHERE id = ?";
            try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                updateStmt.setInt(1, jobId);
                updateStmt.executeUpdate();
            }

            response.sendRedirect("view_jobs.jsp?success=Job+approved");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view_jobs.jsp?error=" + e.getMessage());
        }
    }
}
