package com.courseProfile;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class feedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    final static String filepath  = "D:\\Project\\LMS\\src\\main\\Feedback\\feedback.txt";

    public feedbackServlet() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userID = request.getParameter("userID");
        String username = request.getParameter("username");
        String courseID = request.getParameter("courseId");
        String title = request.getParameter("feedbackTitle");
        String description = request.getParameter("feedbackMessage");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filepath, true))) {
            writer.write(userID + "\t" + username + "\t" + courseID + "\t" + title + "\t" + description + "\n");
        } catch (IOException e) {
            System.out.println("Error in file write");
            return;
        }


        RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
        rd.forward(request, response);


    }
}
