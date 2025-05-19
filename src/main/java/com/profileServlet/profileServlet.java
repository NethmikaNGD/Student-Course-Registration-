package com.profileServlet;

import com.util.CourseFileReading;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.*;

public class profileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public profileServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        // Retrieve session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("index.jsp"); // Redirect if not logged in
            return;
        }

        String userDataPath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
        boolean userFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(userDataPath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length < 8) continue;

                if (data[0].equals(username)) { // Check if the username matches
                    session.setAttribute("userID", data[0]);
                    session.setAttribute("Fname", data[1]);
                    session.setAttribute("Lname", data[2]);
                    session.setAttribute("Email", data[3]);
                    session.setAttribute("Bday", data[4]);
                    session.setAttribute("gender", data[5]);
                    session.setAttribute("role", data[6]);
                    session.setAttribute("avatar", data[7]);
                    userFound = true;
                    break;
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading user file: " + e.getMessage());
        }

        if (!userFound) {
            session.invalidate(); // Clear session if user not found
            response.sendRedirect("index.jsp");
            return;
        }

        // Forward to profile page
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String extraDataPath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\extraData.txt";
        String auditLogPath = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = formatter.format(new Date());

        // Get updated profile data
        String jobTitle = request.getParameter("jobTitle");
        String phoneNo = request.getParameter("phoneNo");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String site = request.getParameter("site");
        String edu = request.getParameter("edu");
        String birthday = request.getParameter("bday");

        // Update session attributes to reflect changes immediately
        session.setAttribute("Email", email);
        session.setAttribute("Bday", birthday);

        // Read existing data & update the current user's info
        List<String> fileContent = new ArrayList<>();
        boolean userExists = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(extraDataPath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split("\t");
                if (data[0].equals(username)) {
                    // Update the user's existing data
                    fileContent.add(username + "\t" + jobTitle + "\t" + phoneNo + "\t" + address + "\t" + email + "\t" + site + "\t" + edu + "\t" + birthday);
                    userExists = true;
                } else {
                    fileContent.add(line);
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading extraData file: " + e.getMessage());
        }

        // If user not found in file, append new entry
        if (!userExists) {
            fileContent.add(username + "\t" + jobTitle + "\t" + phoneNo + "\t" + address + "\t" + email + "\t" + site + "\t" + edu + "\t" + birthday);
        }

        // Write the updated content back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(extraDataPath, false))) {
            for (String line : fileContent) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing extraData file: " + e.getMessage());
        }

        // Log the update in audit log
        try (FileWriter auditlog = new FileWriter(auditLogPath, true)) {
            auditlog.write(dateTime + "\t" + "updatedProfile" + "\t" + username + "\n");
        } catch (IOException e) {
            System.out.println("Error writing audit log: " + e.getMessage());
        }

//        course file reading

        final String courseFile = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
        List<String> courseData = new ArrayList<>();

        CourseFileReading coursefile = new CourseFileReading();
        coursefile.setFileName(courseFile);
        coursefile.readFile();
        courseData = coursefile.getCouseList();


        session.setAttribute("courseData", courseData);
        // Redirect to profile page to prevent form resubmission issue
        response.sendRedirect("profile.jsp");
    }
}
