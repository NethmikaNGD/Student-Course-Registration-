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
import java.util.Date;
import com.util.getTime;

@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1MB threshold for file processing
        maxFileSize = 1024 * 1024 * 5,  // Max file size 5MB
        maxRequestSize = 1024 * 1024 * 10) // Max request size 10MB
public class createCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        int courseID = 0;

        try {
            // Retrieve username from session
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            if (username == null) {
                request.setAttribute("error", "User not logged in!");
                RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                rd.forward(request, response);
                return;
            }

            String coursename = request.getParameter("title");
            String courseDescription = request.getParameter("description");
            String instructor = request.getParameter("instructor");
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
            String level = request.getParameter("level");
            String[] interests = request.getParameterValues("interests");
            String interestsList = (interests != null) ? String.join(", ", interests) : "No interests selected";

            // File Upload Handling
            Part filePart = request.getPart("image");
            String imageFileName = filePart.getSubmittedFileName();

            // Get file upload directory from web.xml
            String uploadDirectory = "D:\\Project\\LMS\\src\\main\\webapp\\image";
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String uploadPath = uploadDirectory + File.separator + imageFileName;
            System.out.println("Saving file to: " + uploadPath);
            filePart.write(uploadPath);
            System.out.println("File saved successfully.");

            getTime thisTime = new getTime();

            String time = thisTime.getTime();



            // Save Course Data to File
            String auditLog = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";
            String filePath = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
            try (
                    FileWriter courseWriter = new FileWriter(filePath, true);
                    FileWriter AuditLog = new FileWriter(auditLog, true);
                    ) {
                courseWriter.write(courseID + "\t" + username + "\t" + coursename + "\t" + courseDescription + "\t" +
                        instructor + "\t" + price + "\t" + level + "\t" + imageFileName + "\t" + interestsList + "\n");

                AuditLog.write(time + "\t" + "New_Course_Create" + "\t"+ "->"  + courseID + "\t" + username + "\t" + coursename +"\n" );
            }

            // Redirect to home page
            request.setAttribute("message", "Course created successfully!");
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
        courseID++;
        System.out.println(courseID);
    }
}
