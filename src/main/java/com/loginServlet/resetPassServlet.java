package com.loginServlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import com.util.fileRead;

public class resetPassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public resetPassServlet() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String filepath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";

        fileRead readFileData = new fileRead();

        readFileData.setFilePath(filepath);

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        if (readFileData.isValid(username) && readFileData.isValid(email)) {
            System.out.println("pass");
            boolean validUser = true;

            HttpSession session = request.getSession();
            session.setAttribute("validUser", validUser);

            RequestDispatcher rd = request.getRequestDispatcher("ForgetPass.jsp");
            rd.forward(request, response);

        }else{
            request.setAttribute("errorT5", "Username or Email is not Matching!");
            request.getRequestDispatcher("ForgetPass.jsp").forward(request, response);
        }








        



    }
}
