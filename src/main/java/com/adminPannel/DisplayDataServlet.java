package com.adminPannel;

import com.util.fileReading;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

public class DisplayDataServlet extends HttpServlet {
    private static final String USER_INFO_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    private static final String USER_PASS_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";
    private static final String COURSE_FILE = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentCount = 0;
        int instructorCount = 0;
        int pendingInstructorCount = 0;
        int courseCount = 0;

        List<String[]> studentList = new ArrayList<>();
        List<String[]> instructorList = new ArrayList<>();
        List<String[]> pendingInstructorList = new ArrayList<>();

        fileReading file = new fileReading(USER_INFO_FILE);
        file.readFile();


        Map<String, String> userRoles = new HashMap<>();

        // Load user roles
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_PASS_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\t");
                if (parts.length >= 3) {
                    userRoles.put(parts[0].trim(), parts[2].trim().toLowerCase().replace("_", ""));
                }
            }
        }

        // Read user info and categorize
        File infoFile = new File(USER_INFO_FILE);
        if (infoFile.exists()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(infoFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\t");
                    if (parts.length >= 9) {
                        String username = parts[1];
                        String role = parts[6];
                        switch (role) {
                            case "Student":
                                studentList.add(parts);
                                studentCount++;
                                break;
                            case "Instructor":
                                instructorList.add(parts);
                                instructorCount++;
                                break;
                            case "Pending_Instructor":
                                pendingInstructorList.add(parts);
                                pendingInstructorCount++;
                                break;
                        }
                    }
                }
            }
        }

        // Count courses
        try (BufferedReader reader = new BufferedReader(new FileReader(COURSE_FILE))) {
            while (reader.readLine() != null) {
                courseCount++;
            }
        }

        //get the data


        // Pass data to JSP
        request.setAttribute("studentCount", studentCount);
        request.setAttribute("instructorCount", instructorCount);
        request.setAttribute("pendingInstructorCount", pendingInstructorCount);
        request.setAttribute("courseCount", courseCount);
        request.setAttribute("studentList", file.getStData());
        request.setAttribute("instructorList", file.getInData());
        request.setAttribute("pendingInstructorList", pendingInstructorList);

        System.out.println("hellow");
        System.out.println("st" + studentCount);
        System.out.println("ins" + instructorCount);
        System.out.println("pend" + pendingInstructorCount);
        System.out.println("cor" + courseCount);

        RequestDispatcher dispatcher = request.getRequestDispatcher("AdminPannelPage2.jsp");
        dispatcher.forward(request, response);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
