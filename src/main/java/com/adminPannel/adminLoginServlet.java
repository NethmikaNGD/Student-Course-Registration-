package com.adminPannel;

import com.util.ComCode;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class adminLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public adminLoginServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String adminCode = request.getParameter("AdminUser");
        String password = request.getParameter("AdminPass");

        // Get current date/time
        ComCode userComCode = new ComCode();
        String dateTime = userComCode.getTime();

        String auditLog = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";

        // Check admin credentials
        if ("EnrollEducationAdminPannel".equals(adminCode) && "08110607Dineth".equals(password)) {

            // Set session attributes
            HttpSession session = request.getSession();
            session.setAttribute("username", "AdminBoss");
            session.setAttribute("role", "admin");

            // Log the login
            try (FileWriter logwrite = new FileWriter(auditLog, true)) {
                logwrite.write(dateTime + "\t" + "Admin_Login" + "\t"+ "->" + "\t" + adminCode + "\t" + "Admin" + "\n");
            } catch (IOException e) {
                e.printStackTrace();
            }

            // Forward to home page or admin panel
            RequestDispatcher rd = request.getRequestDispatcher("DisplayDataServlet"); // or "AdminPannelPage2"
            rd.forward(request, response);

        } else {
            request.setAttribute("AdminError", "Try Again! OR You Are not admin");
            request.getRequestDispatcher("AdminPannel.jsp").forward(request, response);
        }

        System.out.println(adminCode + " " + password);
    }
}
