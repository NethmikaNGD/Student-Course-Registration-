package com.adminPannel;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@WebServlet("/DisplayDataServlet")
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

        // Step 1: Load roles from userPass.txt into a map
        Map<String, String> userRoles = new HashMap<>();
        File passFile = new File(USER_PASS_FILE);

        if (passFile.exists() && passFile.canRead()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(passFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\t");
                    if (parts.length >= 3) {
                        String username = parts[0].trim();
                        String role = parts[2].trim().toLowerCase().replace("_", "");
                        userRoles.put(username, role);

                        // Count and collect
                        switch (role) {
                            case "student":
                                studentCount++;
                                studentList.add(parts);
                                break;
                            case "instructor":
                                instructorCount++;
                                instructorList.add(parts);
                                break;
                            case "pendinginstructor":
                                pendingInstructorCount++;
                                pendingInstructorList.add(parts);
                                break;
                        }
                    }
                }
            }
        }

        // Step 2: Update roles in userInfor.txt
        File infoFile = new File(USER_INFO_FILE);
        File tempFile = new File("D:\\Project\\LMS\\src\\main\\Database\\userRegister\\tempInfor.txt");

        if (infoFile.exists() && infoFile.canRead()) {
            try (
                    BufferedReader reader = new BufferedReader(new FileReader(infoFile));
                    BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile))
            ) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] parts = line.split("\\t");

                    if (parts.length >= 9) {
                        String username = parts[0].trim();
                        String updatedRole = userRoles.get(username);

                        if (updatedRole != null) {
                            parts[7] = updatedRole;  // Update role field (index 7)
                        }

                        writer.write(String.join("\t", parts));
                        writer.newLine();
                    } else {
                        writer.write(line);
                        writer.newLine();
                    }
                }
            }

            // Replace original file with updated
            if (infoFile.delete()) {
                tempFile.renameTo(infoFile);
            }
        }

        // Step 3: Count courses
        File courseFile = new File(COURSE_FILE);
        if (courseFile.exists() && courseFile.canRead()) {
            try (BufferedReader courseReader = new BufferedReader(new FileReader(courseFile))) {
                while (courseReader.readLine() != null) {
                    courseCount++;
                }
            }
        }

        // Step 4: Send to JSP
        request.setAttribute("studentCount", studentCount);
        request.setAttribute("instructorCount", instructorCount);
        request.setAttribute("pendingInstructorCount", pendingInstructorCount);
        request.setAttribute("courseCount", courseCount);
        request.setAttribute("studentList", studentList);
        request.setAttribute("instructorList", instructorList);
        request.setAttribute("pendingInstructorList", pendingInstructorList);


        System.out.println("hellow");

        RequestDispatcher rd = request.getRequestDispatcher("AdminPannelPage2.jsp");
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
