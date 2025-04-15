package com.homeServlet;

import com.util.ComCode;

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


        // Get current timestamp
        ComCode CommonJavaCodes = new ComCode();
        String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

        System.out.println(CommonJavaCodes.CountFileItem(dataSavePath));


        // Redirect to the home page
        response.sendRedirect("home.jsp");
    }
}
