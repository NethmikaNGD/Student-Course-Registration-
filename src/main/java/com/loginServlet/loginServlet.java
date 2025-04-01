package com.loginServlet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.jar.JarOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

public class loginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
        String allPassword = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";
        String auditLog = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";

        boolean loginSuccess = false;
        String role = null;

        String username = request.getParameter("username");
        String password = request.getParameter("password");


        try (BufferedReader reader = new BufferedReader(new FileReader(allPassword))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] data = line.split("\t");
                if (data.length < 4) continue; // Skip invalid lines

                String storeName = data[0];
                String storeEmail = data[1];
                String storePassword = data[2];
                String storeRole = data[3];

                if ((username.equals(storeName) || username.equals(storeEmail)) && password.equals(storePassword)) {
                    loginSuccess = true;
                    role = storeRole;
                    username = storeName;
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorT3", "Error reading user data.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }

        if (loginSuccess) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            session.setAttribute("role", role);

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateTime = formatter.format(new Date());


            try(FileWriter logwrite = new FileWriter(auditLog ,true)){
                logwrite.write(dateTime + "\t"+ "UL" +"\t" + username + "\t" +role + "\n" );
            }catch (IOException e){
                e.printStackTrace();
            }

            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorT3", "Username or Password is not correct!");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }
}
