package com.adminPannel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

//@WebServlet("/ApproveInstructorServlet")
public class ApproveInstructorServlet extends HttpServlet {

    private static final String USER_INFO_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    private static final String USER_PASS_FILE = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userPass.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String usernameToApprove = request.getParameter("username");

        if (usernameToApprove == null || usernameToApprove.trim().isEmpty()) {
            response.sendRedirect("AdminPannelPage2.jsp?error=missingUsername");
            return;
        }

        boolean updatedInfo = updateRoleInFile(USER_INFO_FILE, usernameToApprove);
        boolean updatedPass = updateRoleInFile(USER_PASS_FILE, usernameToApprove);

        if (updatedInfo && updatedPass) {
            response.sendRedirect("AdminPannelPage2.jsp?status=success");
        } else {
            response.sendRedirect("AdminPannelPage2.jsp?status=fail");
        }
    }

    private boolean updateRoleInFile(String filePath, String username) {
        File file = new File(filePath);
        List<String> updatedLines = new ArrayList<>();
        boolean updated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\t");

                if (parts.length >= 8 && parts[0].equals(username)) {
                    // Update role at 8th index (index 7)
                    parts[7] = "instructor";
                    updated = true;
                    line = String.join("\t", parts);
                }

                updatedLines.add(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }

        if (updated) {
            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, false))) {
                for (String updatedLine : updatedLines) {
                    writer.write(updatedLine);
                    writer.newLine();
                }
            } catch (IOException e) {
                e.printStackTrace();
                return false;
            }
        }

        return updated;
    }
}
