package com.adminPannel;

import com.util.fileReading;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class inforFileRead extends HttpServlet {
    private static final String USER_INFO_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    public inforFileRead() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        List<String> StData = new ArrayList<String>();
//        List<String> InData = new ArrayList<String>();
//
//        try (BufferedReader br = new BufferedReader(new FileReader(USER_INFO_FILE))) {
//            String line;
//            while ((line = br.readLine()) != null){
//                String[] data = line.split("\t");
//                if (data[7].equals("Student")){
//                    StData.add(line);
//                }else{
//                    InData.add(line);
//                }
//            }
//        }
        fileReading file = new fileReading(USER_INFO_FILE);

        file.readFile();

        //get the data

        request.setAttribute("StData", file.getStData());
        request.setAttribute("InData", file.getInData());

        RequestDispatcher dispatcher = request.getRequestDispatcher("userManagement.jsp");
        dispatcher.forward(request, response);




    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }


}

