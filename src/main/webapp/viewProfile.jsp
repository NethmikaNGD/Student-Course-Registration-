<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Style/viewProfileStyle.css">
    <link rel="stylesheet" href="Style/Navstyle.css">
    <title>View Profile</title>
</head>
<body>

<!-- Navigation Bar -->
<nav>
    <div class="webHeader">
        <h3 class="headerTxt"> ./EnrollEdu Admin Panel</h3>
    </div>
    <div class="searchBar">
        <input class="navSearch" placeholder="Find your Interest Subjects" name="userWant">
    </div>
    <div class="navLink">
        <ul>
            <li><a href="home.jsp">Home</a></li>
            <li><a href="#course">Course Management</a></li>
            <li><a href="userManagement.jsp">User Management</a></li>
            <li><a href="DisplayDataServlet">Dashboard</a></li>
        </ul>
    </div>
    <div class="profile">
        <div class="profile-dropdown">
            <a href="profile.jsp">User Profile</a>
            <a href="#enrolled">Enrolled Courses</a>
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</nav>
<!-- End Navigation -->

<section class="webHeader1">
    <h2 class="tit">User Profile View</h2>
    <div class="userProfile">
        <img src="Sign-in-Art-1--0fe00843-5dcc-430e-bfd0-eff8d2c9a640-1741359572315.png" alt="userProfile">
    </div>

    <div class="userDetail">
        <div class="section1">
            <p class="list">UserId : ST01 </p>
            <p class="list">Role : Student  </p>
        </div>
        <div class="section2">
            <p class="list">Name : Dineth Nethmika</p>
            <p class="list">Registrated Date : 2024-03-5</p>
        </div>
    </div>

    <div class="userDetail2">
        <div class="section1">
            <p class="list">Email : ST01 </p>
            <p class="list">Phone No:  Student  </p>
            <p class="list">Name : Dineth Nethmika</p>
            <p class="list">Registrated Date : 2024-03-5</p>
        </div>
    </div>


</section>

<section class="enrollSection">
    <h2 class="tit">User Enrolled Courses</h2>

    <div class="couserheader">
        <p>CID</p>
        <p>Course Name</p>
        <p>Instructor Name</p>
        <p>Enrolled Date</p>
    </div>

    <div class="couserDisplay">
        <p>CID:03</p>
        <p>Game Development</p>
        <p>Oliver Lucas</p>
        <p>2034-31-03</p>
    </div>

</section>

</body>
</html>