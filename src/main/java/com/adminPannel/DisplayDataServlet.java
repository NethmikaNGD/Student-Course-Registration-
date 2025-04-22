package com.adminPannel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

//@WebServlet("/DisplayDataServlet")
public class DisplayDataServlet extends HttpServlet {
    private static final String DATA_SAVE_PATH = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    private static final String COURSE_FILE = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int studentCount = 0;
        int instructorCount = 0;
        int pendingInstructorCount = 0;
        int courseCount = 0;

        List<String[]> studentList = new ArrayList<>();
        List<String[]> instructorList = new ArrayList<>();
        List<String[]> pendingInstructorList = new ArrayList<>();

        File userFile = new File(DATA_SAVE_PATH);
        if (userFile.exists() && userFile.canRead()) {
            try (BufferedReader reader = new BufferedReader(new FileReader(userFile))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    String[] details = line.split("\\t");
                    if (details.length >= 9) {
                        String role = details[7].trim().toLowerCase();
                        switch (role) {
                            case "student":
                                studentCount++;
                                studentList.add(details);
                                break;
                            case "instructor":
                                instructorCount++;
                                instructorList.add(details);
                                break;
                            case "pendinginstructor":
                                pendingInstructorCount++;
                                pendingInstructorList.add(details);
                                break;
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("Error reading user file: " + e.getMessage());
            }
        }

        File courseData = new File(COURSE_FILE);
        if (courseData.exists() && courseData.canRead()) {
            try (BufferedReader courseReader = new BufferedReader(new FileReader(courseData))) {
                while (courseReader.readLine() != null) {
                    courseCount++;
                }
            } catch (IOException e) {
                System.err.println("Error reading course file: " + e.getMessage());
            }
        }

        request.setAttribute("studentCount", studentCount);
        request.setAttribute("instructorCount", instructorCount);
        request.setAttribute("pendingInstructorCount", pendingInstructorCount);
        request.setAttribute("courseCount", courseCount);
        request.setAttribute("studentList", studentList);
        request.setAttribute("instructorList", instructorList);
        request.setAttribute("pendingInstructorList", pendingInstructorList);

        request.getRequestDispatcher("adminpanel.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
