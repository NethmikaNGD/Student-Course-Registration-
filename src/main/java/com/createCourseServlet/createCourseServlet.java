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

import com.util.ComCode;

@MultipartConfig(   //This annotation configures file upload settings
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5,   // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
// This is a servlet that handles HTTP requests
public class createCourseServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Main Method - doPost(), that Handles POST requests (form submissions)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Sets response type and gets a writer for output
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        // Creates utility object for Get current timestamp
        ComCode CommonJavaCodes = new ComCode();

        // Sets file paths and Generate new course ID by counting existing lines in the course data file
        String filePath = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
        String anotherFilePath = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor1.txt";
        int courseID = CommonJavaCodes.generateCourseID(filePath);

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

            // Collect form all data like course name, description, etc.
            String coursename = request.getParameter("title");
            String courseDescription = request.getParameter("description1");
            String instructor = request.getParameter("instructor");
            String priceStr = request.getParameter("price");
            double price = (priceStr != null && !priceStr.isEmpty()) ? Double.parseDouble(priceStr) : 0.0;
            int duration = Integer.parseInt(request.getParameter("duration"));
            int projectCont = Integer.parseInt(request.getParameter("projectCount"));
            String courseIncuding1 = request.getParameter("courseIncluding1");
            String courseIncuding2 = request.getParameter("courseIncluding2");
            String courseIncuding3 = request.getParameter("courseIncluding3");
            String dis = request.getParameter("description");
            String level = request.getParameter("level");
            String[] interests = request.getParameterValues("interests");
            String interestsList = (interests != null) ? String.join(", ", interests) : "No interests selected";

            // Handle image upload
            Part filePart = request.getPart("image");
            String imageFileName = filePart.getSubmittedFileName(); //Gets uploaded file part

            //Creates upload directory if needed
            String uploadDirectory = "D:\\Project\\LMS\\src\\main\\webapp\\image";
            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            //Saves the file
            String uploadPath = uploadDirectory + File.separator + imageFileName;
            filePart.write(uploadPath);
            System.out.println("Image saved to: " + uploadPath);


            String time = CommonJavaCodes.getTime();

            // Save course data
            String auditLog = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";
            try (
                    FileWriter courseWriter = new FileWriter(filePath, true);
                    FileWriter courseWriter1 = new FileWriter(anotherFilePath, true);
                    FileWriter auditWriter = new FileWriter(auditLog, true);
            ) {
                courseWriter.write(courseID + "\t" + username + "\t" + coursename + "\t" + courseDescription + "\t" +
                        instructor + "\t" + price + "\t" +level + "\t" + imageFileName + "\t" + interestsList + "\n");

                courseWriter1.write(courseID + "\t" + duration + "\t" + projectCont + "\t" + courseIncuding1 + "\t" + courseIncuding2 + "\t" +courseIncuding3 + "\t" + dis +"\n" );
                // Write to audit log
                auditWriter.write(time + "\t" + "New_Course_Create" + "\t-> " + courseID + "\t" + username + "\t" + coursename + "\n");
            }

            // Shows success message and returns to home page
            request.setAttribute("message", "Course created successfully!");
            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);

        } catch (Exception e) { //Catches and displays any errors
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace();
        }
    }

}
