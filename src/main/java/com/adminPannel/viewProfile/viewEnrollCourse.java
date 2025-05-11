package com.adminPannel.viewProfile;

import com.util.CourseFileReading;
import com.util.fileReading;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class viewEnrollCourse extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String enrollCourse = "D:\\Project\\LMS\\src\\main\\Database\\EnrollList\\courseEnroll";
    private static final String CourseInfor = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
    private static final String USER_INFO_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    public viewEnrollCourse() {
        super();
    }
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> fileDataStore = new ArrayList<>();
        List<String> EnrollList = new ArrayList<>();

        String usrID = null , userName = null , courseID = null , courseOwner = null , regDate = null ;

        CourseFileReading file = new CourseFileReading();
        file.setFileName(enrollCourse);
        file.readFile();
        EnrollList  = file.getCouseList();

        file.setFileName(CourseInfor);
        file.readFile();
        fileDataStore = file.getCouseList();

        for (String data1 : EnrollList) {
            String[] dataArray = data1.split("\t");
            usrID = dataArray[0];
            userName = dataArray[1];
            courseID = dataArray[2];
            courseOwner = dataArray[3];
            regDate = dataArray[4];

        }


        for (String data : fileDataStore) {
            String[] dataArray = data.split("\t");


        }



        RequestDispatcher rd = req.getRequestDispatcher("viewProfile.jsp");
        rd.forward(req, resp);





    }
}
