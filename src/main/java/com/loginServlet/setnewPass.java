package com.loginServlet;

import com.util.ReWrite;
import com.util.fileRead;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class setnewPass extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public setnewPass() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String filepath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";

        fileRead readFileData = new fileRead();


        readFileData.setFilePath(filepath);

        String username = request.getParameter("username2");

        String newPass = request.getParameter("password");
        String newPass1 = request.getParameter("Cpassword");

        if (newPass.equals(newPass1)) {
            ReWrite rw = new ReWrite(newPass1,username);

            rw.updatePassword();
            rw.sortUserIds();

            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.forward(request, response);


        }else {
            request.setAttribute("errorT6", "Not matching Password!");
            request.getRequestDispatcher("ForgetPass.jsp").forward(request, response);

        }
    }
}
