package com.courseProfile;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class CourseProfileServlet  extends HttpServlet {

    private final String userInfoPath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    private final String[] coursePaths = {
            "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt",
            "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor1.txt"
    };

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");

        String fullName = null;
        String avatar = null;
        String userID = null;

        // Get user info
        try (BufferedReader reader = new BufferedReader(new FileReader(userInfoPath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length >= 9 && data[1].equals(username)) {
                    fullName = data[2];
                    avatar = data[8];
                    userID = data[0];
                    break;
                }
            }
        }

        // Get course info
        String courseId = request.getParameter("courseId");
        String[] course = null;
        String courseType = "Free";

        outer:
        for (String path : coursePaths) {
            try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] courseData = line.split("\t");
                    if (courseData.length >= 7 && courseData[0].equals(courseId)) {
                        course = courseData;
                        try {
                            double price = Double.parseDouble(courseData[5]);
                            courseType = price == 0.0 ? "Free" : "Paid";
                        } catch (NumberFormatException ignored) {}
                        break outer;
                    }
                }
            }
        }

        if (course == null) {
            request.setAttribute("errorMessage", "Course not found");
            request.getRequestDispatcher("courseProfile.jsp").forward(request, response);
            return;
        }

        // Set attributes for JSP
        request.setAttribute("course", course);
        request.setAttribute("courseType", courseType);
        request.setAttribute("fullName", fullName);
        request.setAttribute("avatar", avatar);
        request.setAttribute("role", role);

        request.getRequestDispatcher("courseProfile.jsp").forward(request, response);
    }
}
