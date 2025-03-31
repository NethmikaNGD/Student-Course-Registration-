<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 3/29/2025
  Time: 4:13 PM
  To change this template use File | Settings | File Templates.
--%>

<%
    // Redirect to login if the session is invalid
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // Retrieve session attributes
    String fName = (String) session.getAttribute("username");

    String username = null;
    String role = null;
    String avatar = null;
    String Uname = null;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";


    // Read user information from the file
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 8) continue; // Prevent ArrayIndexOutOfBoundsException

            Uname = data[0]; // Username in the file
            if (fName.equals(Uname)) {
                fName = data[1]; // First name
                role = data[6];  // Role
                avatar = data[7];// Avatar file name

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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <link rel="stylesheet" href="Style/Navstyle.css">
        <link rel="stylesheet" href="Style/userProfile.css">
    </head>
    <body>

    <!--Navigation bar -->
    <nav>
        <div class="webHeader">
            <h2 class="headerTxt"> ./EnrollEdu</h2>
        </div>
        <div class="searchBar">
            <input class="navSearch"  placeholder="Find your Interest Subjects" name="userWant" >
        </div>
        <div class="navLink">
            <ul>
                <li><a class="" href="home.jsp">Home</a></li>
                <li><a class="" href="#course">Course</a></li>
                <li><a class="" href="#about">About</a></li>
            </ul>
        </div>

        <div class="instuctorBtn">
            <% if ("Instructor".equals(role)) { %>
            <a class="btn" href="createCourse.jsp">Create course</a>
            <% } %>
        </div>

        <div class="profile">
            <img class="avatar" src="./image/<%= (avatar != null) ? avatar : "davatar.webp" %>" alt="User Avatar" width="40" height="40">
            <div class="profile-dropdown">
                <a href="profile.jsp">User Profile</a>
                <a href="#enrolled">Enrolled Courses</a>
                <a href="index.jsp">Logout</a>
            </div>
        </div>
    </nav>
    <!--Navigation bar -->
    <!--userProfile -->
    <section class="content">
        <div class="userInfor">
            <div class="userNameLine">

                <div class="userProfile">
                    <img class="userProfilePic" src="image/gg.jpg" alt="profile" class="profileAvatar">
                </div>

                <div class="nameContainer">

                    <div class="userName">
                        <p class="userNameTxt">Jeremy Rose</p>
                        <p class="userTitle">Software Engineer</p>
                    </div>

                    <a href="#edit"><img class="editIcon" src="image/pencil-fill.svg"></a>

                </div>

            </div>

            <div class="contacInfor">
                <div class="userContac">
                    <div class="infor">
                        <li>Phone </li>
                        <li>Address</li>
                        <li>E-mail</li>
                        <li>Site  </li>
                        <li>Educations</li>
                        <li>Birth Day </li>
                        <li>Gender </li>
                    </div>
                    <div class="infor1">
                        <li>0703411403 </li>
                        <li>119/A Near The School, Matara </li>
                        <li>Rose@Edu66.com</li>
                        <li>Jeremy.WorkSpace.com</li>
                        <li>SLLIT</li>
                        <li>2004-04-04</li>
                        <li>Male</li>
                    </div>
                </div><!--userContact-->
            </div>

        </div>


        <div class="courseInfor">

            <div class="headerName">
                <p class="headerText"><%= ("Instructor".equals(role)) ? "Posted Courses" : "Enrolled Courses" %></p>

            </div>

            <div class="courseContainer">
                <div class="courseHeader">
                    <p class="couserTitle">Data Science and Machine Learning</p>
                </div>
                <div class="enrollCount">
                    <p class="courseEnroll">30</p>

                </div>
                <div class="earning">
                    <p class="courseIncome">$1000</p>

                </div>
                <div class="editSection">
                    <a href="#edit"><img class="editIcon" src="image/pencil-fill.svg"></a>
                    <a href="#remove"> <img class="editIcon trash" src="image/trash3-fill.svg"></a>
                </div>
            </div>


        </div>
    </section>
        <!--userProfile -->



    </body>
</html>
