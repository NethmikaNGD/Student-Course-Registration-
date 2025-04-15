package com.createCourseServlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.*;

import com.util.getTime;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,   // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class createCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Generate new course ID by counting existing lines in the course data file
        String filePath = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
        int courseID = generateCourseID(filePath);

        try {
            // Get the logged-in username from session
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            if (username == null) {
                request.setAttribute("error", "User not logged in!");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
                return;
            }

            // Collect form data
            String coursename = request.getParameter("title");
            String courseDescription = request.getParameter("description");
            String instructor = request.getParameter("instructor");
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
            String level = request.getParameter("level");
            String[] interests = request.getParameterValues("interests");
            String interestsList = (interests != null) ? String.join(", ", interests) : "No interests selected";

            // Handle image upload
            Part filePart = request.getPart("image");
            String imageFileName = filePart.getSubmittedFileName();

            String uploadDirectory = "D:\\Project\\LMS\\src\\main\\webapp\\image";
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String uploadPath = uploadDirectory + File.separator + imageFileName;
            filePart.write(uploadPath);
            System.out.println("Image saved to: " + uploadPath);

            // Get current timestamp
            getTime thisTime = new getTime();
            String time = thisTime.getTime();

            // Save course data
            String auditLog = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";
            try (
                    FileWriter courseWriter = new FileWriter(filePath, true);
                    FileWriter auditWriter = new FileWriter(auditLog, true);
            ) {
                courseWriter.write(courseID + "\t" + username + "\t" + coursename + "\t" + courseDescription + "\t" +
                        instructor + "\t" + price + "\t" + level + "\t" + imageFileName + "\t" + interestsList + "\n");

                auditWriter.write(time + "\t" + "New_Course_Create" + "\t-> " + courseID + "\t" + username + "\t" + coursename + "\n");
            }

            // Redirect with success message
            request.setAttribute("message", "Course created successfully!");
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }

    // Method to generate a new Course ID based on existing lines in CourseInfor.txt
    private int generateCourseID(String filePath) {
        int lines = 0;
        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            while (reader.readLine() != null) {
                lines++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return lines + 1;
    }
}
