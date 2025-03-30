<%@ page import="java.util.Objects" %>
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
    String avatar = (String) session.getAttribute("avatar");
%>

<html>
    <head>
        <title>Home</title>
        <link rel="stylesheet" href="Style/Navstyle.css">
        <link rel="stylesheet" href="Style/cardstyle.css">
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
    <!--Course Card -->

    <div class="course_card">
        <div class="cardContainer">
            <div class="cardImage">
                <img class="cardAvatar" src="image/courseIMG.png">
            </div>
            <div class="profile">
                <div class="profileAvata">
                    <img class="profilePic" src="image/gg.jpg">
                    <p class="userName">Dineth Nethmika</p>
                </div>
                <div class="courseTitle">
                    <p class="titleText">Science</p>
                </div>
            </div>
            <div class="cardHeader">
                <h3 class="headerText">Data Science and Machine Learning with Python:
                    Hand On!</h3>
            </div>
            <div class="enrollbtn">
                <div class="price">
                    <h3 class="priceText">$ 386.0</h3>
                </div>
                <div class="rating">
                    <h4 class="ratingCout">4.9</h4>
                </div>
            </div>
        </div>

    </div>

    <!--Course Card -->

    </body>
</html>
