package com.registerServlet;

import com.util.ComCode;

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

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class registerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public String imageFileName = "davatar.webp"; // Default avatar

    public registerServlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        ComCode CommonJavaCodes = new ComCode();

        String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
        String allPassword = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";
        String userInterest = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInterest.txt";
        String auditReg = "D:\\Project\\LMS\\src\\main\\Database\\adminLog\\AuditLog.txt";

        int userID = CommonJavaCodes.generateCourseID(dataSavePath);

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dateOfBirth = request.getParameter("birthDate");
        String gender = request.getParameter("gender");
        String role = request.getParameter("role");

        // Interests
        String[] interests = request.getParameterValues("interests");
        String interestsList = (interests != null) ? String.join(", ", interests) : "No interests selected";

        // Password confirmation
        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorT1", "Passwords do not match");
            RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
            rd.forward(request, response);
            return;
        }

        // Check for duplicates
        try (BufferedReader checkPass = new BufferedReader(new FileReader(allPassword))) {
            String line;
            while ((line = checkPass.readLine()) != null) {
                String[] parts = line.split("\t");
                if (parts.length >= 3) {
                    String userN = parts[1];
                    String userE = parts[2];

                    if (username.equals(userN) || email.equals(userE)) {
                        request.setAttribute("errorT2", "Username and email are already taken!");
                        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
                        rd.forward(request, response);
                        return;
                    }
                }
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }

        // Handle image upload
        Part filePart = request.getPart("image");

        if (filePart != null && filePart.getSize() > 0 && !filePart.getSubmittedFileName().equals("")) {
            imageFileName = filePart.getSubmittedFileName();  // <-- Fix: update global variable

            String uploadDirectory = getServletContext().getInitParameter("file-upload");
            String uploadPath = uploadDirectory + File.separator + imageFileName;

            File uploadDir = new File(uploadDirectory);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            filePart.write(uploadPath);
        }

        // Save records
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateTime = formatter.format(new Date());

        try (
                FileWriter userInfor = new FileWriter(dataSavePath, true);
                FileWriter userPass = new FileWriter(allPassword, true);
                FileWriter userInterestTopic = new FileWriter(userInterest, true);
                FileWriter auditLog = new FileWriter(auditReg, true);
        ) {
            userInfor.write(userID + "\t" + username + "\t" + firstName + "\t" + lastName + "\t" + email + "\t" + dateOfBirth + "\t" + gender + "\t" + role + "\t" + imageFileName + "\n");
            userPass.write(userID + "\t" + username + "\t" + email + "\t" + password + "\t" + role + "\n");
            userInterestTopic.write(userID + "\t" + username + "\t" + interestsList + "\n");
            auditLog.write(dateTime + "\t" + "new_user_Register" + "\t" + "->" + "\t" + userID + "\t" + username + "\t" + role + "\n");

            System.out.println("Register Success ... ");
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);
    }
}
