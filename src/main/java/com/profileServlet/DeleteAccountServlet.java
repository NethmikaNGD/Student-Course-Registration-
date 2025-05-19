package com.profileServlet;

import com.util.DeleteCode;
import com.util.ReadData;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class DeleteAccountServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    static final String Delete_User_List = "Delete_User_List";
    static final String User_List = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    static final String User_Pass = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        DeleteCode deleteCode = new DeleteCode();
        ReadData readData = new ReadData();

        boolean validUser = false;

        //check valid User Or not:
        readData.setFileName(User_List);
        readData.readFile();
        List<String> temp = readData.getSaveData();

        readData.setFileName(User_Pass);
        readData.readFile();
        List<String> PassTemp = readData.getSaveData();

        for(String item : PassTemp) {
            String[] items = item.split("\t");

            if (username.equals(items[1]) && email.equals(items[2])&&password.equals(items[3])) {
                validUser = true;


                if (validUser) {
                    deleteCode.setDeleteFilePath(User_List);
                    deleteCode.setUsernameToDelete(username);
                    deleteCode.doDelete();


                    deleteCode.setDeleteFilePath(User_Pass);
                    deleteCode.setUsernameToDelete(username);
                    deleteCode.doDelete();

                    System.out.println("Account Deleted....");
                }

            }else{
                request.setAttribute("errorT3", "Username or Password is not correct!");
                request.getRequestDispatcher("deletePage.jsp").forward(request, response);

                System.out.println("Account not Deleted....");
            }
        }



        System.out.println("Account not  Deleted.... something have" );


        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);


    }

}
