package com.registerServlet;


import javax.servlet.annotation.MultipartConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class registerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public registerServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();


        String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
        String allPassword = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";
        String userInterest = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInterest.txt";
        String auditReg = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditReg.txt";


        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dateOfBirth = request.getParameter("birthDate");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        // Handling multiple selection interests
        String[] interests = request.getParameterValues("interests");
        String interestsList = (interests != null) ? String.join(", ", interests) : "No interests selected";

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorT1", "Passwords do not match");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        // Check for duplicate username and email
        boolean registerSuccess = false;

        try (BufferedReader checkPass = new BufferedReader(new FileReader(allPassword))) {
            String line;
            while ((line = checkPass.readLine()) != null) {
                String[] parts = line.split("\t");
                String userN = parts[0];
                String userE = parts[1];

                if (username.equals(userN) && email.equals(userE)) {
                    request.setAttribute("errorT2", "Username and email are already taken!");
                    RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                    rd.forward(request, response);
                    return;
                }
            }
            registerSuccess = true;


        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        // Handle file upload
        Part filePart = request.getPart("image");
        String imageFileName = filePart.getSubmittedFileName();
        String uploadDirectory = getServletContext().getInitParameter("file-upload");
        String uploadPath = uploadDirectory + File.separator + imageFileName;

        File uploadDir = new File(uploadDirectory);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        filePart.write(uploadPath);

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = formatter.format(new Date());


        try (
                FileWriter userInfor = new FileWriter(dataSavePath, true);
                FileWriter userPass = new FileWriter(allPassword, true);
                FileWriter userInterestTopic = new FileWriter(userInterest, true);
                FileWriter auditLog = new FileWriter(auditReg,true);
        ) {
            userInfor.write(username + "\t" + firstName + "\t" + lastName + "\t" + email + "\t" + dateOfBirth + "\t" + gender + "\t" + role + "\t"+ imageFileName+ "\n");
            userPass.write(username + "\t" + email + "\t" + password +"\t" + role + "\n");
            userInterestTopic.write(username + "\t" + interestsList + "\n");
            auditLog.write(dateTime + "\t" + username + "\t" + role +"\n");

            System.out.println("Register Success ... ");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
    }
}
