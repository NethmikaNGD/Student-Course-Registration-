<%@ page import="java.io.IOException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    // Redirect to login if the session is invalid
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Retrieve session attributes
    String username = (String) session.getAttribute("username");
    String Fname = (String) session.getAttribute("Fname");
    String Lname = (String) session.getAttribute("Lname");
    String Pemail = (String) session.getAttribute("Email");
    String PBday = (String) session.getAttribute("Bday");
    String Pgender = (String) session.getAttribute("gender");
    String Prole = (String) session.getAttribute("role");
    String Pavatar = (String) session.getAttribute("avatar");

    if (Pavatar == null || Pavatar.isEmpty()) {
        Pavatar = "davatar.webp"; // Default avatar if none is provided
    }
%>

<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="Style/Navstyle.css">
    <link rel="stylesheet" href="Style/userProfile.css">
</head>
<body>

<!-- Navigation bar -->
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
        <% if ("Instructor".equals(Prole)) { %>
        <a class="btn" href="createCourse.jsp">Create course</a>
        <% } %>
    </div>

    <div class="profile">
        <img class="avatar" src="./image/<%= Pavatar %>" alt="User Avatar" width="40" height="40">
        <div class="profile-dropdown">
            <a href="profile.jsp">User Profile</a>
            <a href="#enrolled">Enrolled Courses</a>
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</nav>
<!-- Navigation bar -->

<!-- User Profile -->
<section class="content">
    <div class="userInfor">
        <div class="userNameLine">
            <div class="userProfile">
                <img class="userProfilePic" src="image/<%= Pavatar %>" alt="profile">
            </div>

            <div class="nameContainer">
                <div class="userName">
                    <p class="userNameTxt"><%= Fname + " " + Lname %></p>
                    <p class="userTitle">Software Engineer</p>
                </div>
                <a href="#edit"><img class="editIcon" src="image/pencil-fill.svg"></a>
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
                    <li>0703411403</li>
                    <li>119/A Near The School, Matara</li>
                    <li><%= Pemail %></li>
                    <li>Jeremy.WorkSpace.com</li>
                    <li>SLIIT</li>
                    <li><%= PBday %></li>
                    <li><%= Pgender %></li>
                </div>
            </div>
        </div>
    </div>

    <div class="courseInfor">
        <div class="headerName">
            <p class="headerText"><%= ("Instructor".equals(Prole)) ? "Posted Courses" : "Enrolled Courses" %></p>
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
                <a href="#remove"><img class="editIcon trash" src="image/trash3-fill.svg"></a>
            </div>
        </div>
    </div>
</section>
<!-- User Profile -->

</body>
</html>
