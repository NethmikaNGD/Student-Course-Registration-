<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 4/3/2025
  Time: 11:50 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.File" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Redirect to login if the session is invalid
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // Retrieve session attributes
    String fName = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    String username = null;
    String avatar = null;
    String Uname = null;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    String userID = null;

    // Read user information from the file
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 8) continue; // Prevent ArrayIndexOutOfBoundsException

            userID = data[0];
            Uname = data[1]; // Username in the file
            if (fName.equals(Uname)) {
                fName = data[2]; // First name
//                role = data[6];  // Role
                avatar = data[8];// Avatar file name

                System.out.println(role);
                //want to display user Avatar pic name
                System.out.println(avatar);
                break;
            }
        }
    } catch (IOException e) {
        System.out.println("Something went wrong: " + e.getMessage());
        response.sendRedirect("index.jsp"); // Redirect to an error page if necessary
        return;
    }
%>
<html>
<head>
    <title>EditProfile</title>
    <link rel="stylesheet" href="Style/Navstyle.css">
    <link rel="stylesheet" href="Style/userProfile.css">
    <link rel="stylesheet" href="Style/editProfile.css">
</head>
<body>

<nav>
    <div class="webHeader">
        <h2 class="headerTxt"> ./EnrollEdu</h2>
    </div>
    <div class="searchBar">
        <input class="navSearch" placeholder="Find your Interest Subjects" name="userWant">
    </div>
    <div class="navLink">
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="#course">Course</a></li>
            <li><a href="#about">About</a></li>
        </ul>
    </div>
    <div class="instuctorBtn">
        <% if ("Instructor".equals(role)) { %>
        <a class="btn" href="createCourse.jsp">Create course</a>
        <% } %>
    </div>
    <div class="profile">
        <img class="avatar" src="image/<%= (avatar != null) ? avatar : "davatar.webp" %>" alt="User Avatar" width="40" height="40">
        <div class="profile-dropdown">
            <a href="profile.jsp">User Profile</a>
            <a href="#enrolled">Enrolled Courses</a>
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</nav>
<!---navigation-->

<!-- User Profile -->
<section class="content">
    <div class="userInfor">
        <div class="userNameLine">
            <div class="userProfile">
                <img class="userProfilePic" src="image/gg.jpg" alt="profile">
            </div>

            <div class="nameContainer">
                <div class="userName">
                    <p class="userNameTxt">Dineth Nethmika</p>
                    <input class="userJobType" placeholder="Job Type">
                </div>
                <p class="editIcon">Editing</p>
            </div>
        </div>

        <div class="contacInfor">
            <div class="userContac">
                <div class="infor">
                    <li>Phone</li>
                    <li>Address</li>
                    <li>E-mail</li>
                    <li>Site</li>
                    <li>Education</li>
                    <li>Birth Day</li>
                    <li>Gender</li>
                </div>
                <div class="infor1">
                    <input type="text" name="phoneNo" class="phoneNo" placeholder="0703411403">
                    <input type="text" name="address" class="phoneNo" placeholder="119/A Near the school">
                    <input type="email" name="email" class="phoneNo" placeholder="Dinethnethmika@gmail.com">
                    <input type="text" name="site" class="phoneNo" placeholder="www.gmail.com">
                    <input type="text" name="edu" class="phoneNo" placeholder="Sliit">
                    <input type="date" name="bday" class="phoneNo" placeholder="2004-4-1">
                    <p class="phoneNo">male</p>

                </div>
            </div>
        </div>
    </div>
</section>

</body>
</html>
