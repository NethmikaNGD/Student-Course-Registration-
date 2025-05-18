package com.profileServlet;

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

    //default constructor
    public profileServlet() {
        super();
    }

    //doGet() Method - Handles & visits the profile page (GET request).
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        // Retrieve current user's session and their username.
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        if (username == null) { //If no user is logged in (no username), redirect to login page.
            response.sendRedirect("index.jsp");
            return;
        }

        String userDataPath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
        boolean userFound = false;

        // Opens the user data file for reading
        try (BufferedReader reader = new BufferedReader(new FileReader(userDataPath))) {
            String line;
            while ((line = reader.readLine()) != null) { //Reads each line of the file
                String[] data = line.split("\t");   //splits it by tabs,
                if (data.length < 8) continue;      //checks if it's the current user.

                //Stores user data in the session (temporary storage) to display on profile page.
                if (data[0].equals(username)) {
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
            session.invalidate(); // If user not found, clear session and redirect to login.
            response.sendRedirect("index.jsp");
            return;
        }

        // Shows the profile.jsp page with the user's data.
        RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
        dispatcher.forward(request, response);
    }

    // doPost() Method - Handles profile updates
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        //Again checks if user is logged in
        HttpSession session = request.getSession(); //Runs when user submits the profile update form (POST request)
        String username = (String) session.getAttribute("username");

        if (username == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String extraDataPath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\extraData.txt";
        String auditLogPath = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";

        // Creates a timestamp for the audit log
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = formatter.format(new Date());

        // Get updated profile data from the form
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

        // Prepares to read and update the extra data file.
        List<String> fileContent = new ArrayList<>();
        boolean userExists = false;

        // Reads the file line by line, updating the current user's data if found
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

        // If user not in file, adds them as a new entry.
        if (!userExists) {
            fileContent.add(username + "\t" + jobTitle + "\t" + phoneNo + "\t" + address + "\t" + email + "\t" + site + "\t" + edu + "\t" + birthday);
        }

        // Save the updated content back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(extraDataPath, false))) {
            for (String line : fileContent) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Error writing extraData file: " + e.getMessage());
        }

        // Logs that this user updated their profile
        try (FileWriter auditlog = new FileWriter(auditLogPath, true)) {
            auditlog.write(dateTime + "\t" + "updatedProfile" + "\t" + username + "\n");
        } catch (IOException e) {
            System.out.println("Error writing audit log: " + e.getMessage());
        }

        // Redirect to profile page to prevent form resubmission issue
        response.sendRedirect("profile.jsp");
    }
}
