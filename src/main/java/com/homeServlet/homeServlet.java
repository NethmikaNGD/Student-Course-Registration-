package com.homeServlet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class homeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public homeServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");

        // Retrieve username from request
        String userName = request.getParameter("username");

        // File path to user data
        String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

        // Initialize user details
        String fName = null;
        String role = null;
        String avatar = null;
        String Uname = null;

        // Read user information from the file
        try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
            String line;
            while ((line = readData.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length < 8) continue; // Prevent ArrayIndexOutOfBoundsException

                Uname = data[0]; // Username in the file
                if (userName.equals(Uname)) {
                    fName = data[1]; // First name
                    role = data[6];  // Role
                    avatar = data[7];// Avatar file name

                    System.out.println(role);
                    System.out.println(avatar);
                    break;
                }
            }
        } catch (IOException e) {
            System.out.println("Something went wrong: " + e.getMessage());
            response.sendRedirect("index.jsp"); // Redirect to an error page if necessary
            return;
        }

        // Set user data in session
        HttpSession session = request.getSession();
        session.setAttribute("username", Uname);
        session.setAttribute("name", fName);
        session.setAttribute("role", role);
        session.setAttribute("avatar", avatar);

        // Redirect to the home page
        response.sendRedirect("home.jsp");
    }
}
