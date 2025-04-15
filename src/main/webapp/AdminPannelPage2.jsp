<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 4/9/2025
  Time: 3:22 AM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Style/adminStyle.css">
    <link rel="stylesheet" href="Style/Navstyle.css">
    <title>Admin DashBoard</title>
</head>
<body>

<!--Navigation Bar -->
<nav>
    <div class="webHeader">
        <h2 class="headerTxt"> ./EnrollEdu Admin Panel</h2>
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

    </div>
    <div class="profile">
        <div class="profile-dropdown">
            <a href="profile.jsp">User Profile</a>
            <a href="#enrolled">Enrolled Courses</a>
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</nav>
<!--Navigation Bar -->

<div class="header">
    <h2>Web Summery</h2>
</div>

<!--home Content -->
<section class="actionBar">
    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber">40</p></div>
            <div class="title"><p class="pTitle">Number of Students</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber">40</p></div>
            <div class="title"><p class="pTitle">Number of Instructors</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber">40</p></div>
            <div class="title"><p class="pTitle">Number of Courses</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber">12</p></div>
            <div class="title"><p class="pTitle">Pending Instructors</p></div>
        </div>
    </section>
</section>

<section class="display">
    <section class="displayStudents">
        <div class="header1">
            <h2>Students' Table</h2>

            <table>
                <thead>
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Jane Doe</td>
                    <td>jane.doe@example.com</td>
                    <td>1990-01-15</td>
                </tr>
                <!-- Add more rows as needed -->
                </tbody>
            </table>
        </div>
    </section>
    <section class="displayInstructors">
        <div class="header1">
            <h2>Instructors' Table</h2>

            <table>
                <thead>
                <tr>
                    <th>No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>1</td>
                    <td>Jane Doe</td>
                    <td>jane.doe@example.com</td>
                    <td>1990-01-15</td>
                </tr>
                <!-- Add more rows as needed -->
                </tbody>
            </table>
        </div>
    </section>
</section>
<!--home Content -->


</body>
</html>
