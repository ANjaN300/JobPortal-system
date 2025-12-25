package servlets;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;
import utils.DBUtil;

@WebServlet("/applyJob")
@MultipartConfig // required for file upload
public class ApplyJobServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        int jobId = Integer.parseInt(request.getParameter("jobId"));
        int seekerId = (Integer) request.getSession().getAttribute("userId");

        Part filePart = request.getPart("resume"); // uploaded file
        String fileName = filePart.getSubmittedFileName();
        
        // Save uploaded file to a folder
        String uploadPath = getServletContext().getRealPath("") + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO applications (job_id, seeker_id, resume) VALUES (?,?,?)"
            );
            ps.setInt(1, jobId);
            ps.setInt(2, seekerId);
            ps.setString(3, fileName); // store file name or path in DB
            ps.executeUpdate();

            response.sendRedirect("job_list.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
