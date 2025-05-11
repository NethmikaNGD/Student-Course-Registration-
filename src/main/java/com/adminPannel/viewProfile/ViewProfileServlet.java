package com.adminPannel.viewProfile;

import com.util.fileReading;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ViewProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String USER_INFO_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    public ViewProfileServlet() {
        super();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");



    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userID = request.getParameter("userID");
        String SelectRole  = request.getParameter("role");

        List<String> fileDataStore = new ArrayList<>();
        String uID = null , username = null, firstName  = null, lastName = null, email = null , birthday = null,gender = null, urole = null , avatar = null;



        fileReading file = new fileReading(USER_INFO_FILE);
        file.readFile();

        if (SelectRole.equals("Student")) {
            fileDataStore = file.getStData();
            for(String data : fileDataStore) {
                String[] dataSplit = data.split("\t");
                if (userID.equals(dataSplit[0])) {
                    uID = dataSplit[0];
                    username =  dataSplit[1];
                    firstName = dataSplit[2];
                    lastName = dataSplit[3];
                    email = dataSplit[4];
                    birthday = dataSplit[5];
                    gender= dataSplit[6];
                    urole =dataSplit[7];
                    avatar = dataSplit[8];
                    System.out.println("Student working.....");
                }
            }



        }else {
            fileDataStore = file.getInData();
            for(String data : fileDataStore) {
                String[] dataSplit = data.split("\t");
                if (userID.equals(dataSplit[0])) {
                    uID = dataSplit[0];
                    username =  dataSplit[1];
                    firstName = dataSplit[2];
                    lastName = dataSplit[3];
                    email = dataSplit[4];
                    birthday = dataSplit[5];
                    gender= dataSplit[6];
                    urole =dataSplit[7];
                    avatar = dataSplit[8];

                    System.out.println("teacher working.....");
                }
            }

        }

        System.out.println(userID + " " + SelectRole);
        System.out.println("pwd : ViewProfileServlet");

//        request.setAttribute("userID", uID);
//        request.setAttribute("username", username);
//        request.setAttribute("firstname",firstName );
//        request.setAttribute("lastname",lastName );
//        request.setAttribute("email",email);
//        request.setAttribute("birthday",birthday );
//        request.setAttribute("gender",gender );
//        request.setAttribute("role", urole);
//        request.setAttribute("avatar",avatar);

        request.getSession().setAttribute("userID", uID);
        request.getSession().setAttribute("username", username);
        request.getSession().setAttribute("firstname", firstName);
        request.getSession().setAttribute("lastname", lastName);
        request.getSession().setAttribute("email", email);
        request.getSession().setAttribute("birthday", birthday);
        request.getSession().setAttribute("gender", gender);
        request.getSession().setAttribute("role", urole);
        request.getSession().setAttribute("avatar", avatar);
        request.getSession().setAttribute("SelectRole", SelectRole);


        RequestDispatcher rd = request.getRequestDispatcher("viewProfile.jsp");
        rd.forward(request, response);






    }


}
