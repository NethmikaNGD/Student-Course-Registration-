package com.courseProfile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.FileWriter;
import java.io.IOException;

public class enrollServlet extends HttpServlet {

    private static final String SAVE_FILE = "D:\\Project\\LMS\\src\\main\\Database\\EnrollList\\courseEnroll";
    private static final long serialVersionUID = 1L;

    public enrollServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String courseID = req.getParameter("courseId");
        String userID = req.getParameter("userID");
        String username = req.getParameter("username");
        String courseOwner = req.getParameter("courseOwner");

        boolean enrolled = false;

        /// Enroll File Write


        try (FileWriter fw = new FileWriter(SAVE_FILE , true)) {
            fw.write(userID + "\t" + username + "\t" + courseID + "\t" + courseOwner + "\n" );
            enrolled = true;
            System.out.println("Enroll Success....");
        }catch(IOException e){
            System.out.println("Enroll Error....");
        }

        req.getSession().setAttribute("enrolled", enrolled);
        req.getRequestDispatcher("courseProfile.jsp").forward(req, resp);











    }
}
