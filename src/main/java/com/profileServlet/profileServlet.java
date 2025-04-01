package com.profileServlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;

public class profileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public profileServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

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
}
