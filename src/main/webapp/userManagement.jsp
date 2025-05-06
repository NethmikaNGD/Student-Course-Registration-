<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 5/5/2025
  Time: 9:56 PM
  To change this template use File | Settings | File Templates.
--%>

<html>
<head>
    <title>User Management</title>
    <link rel="stylesheet" href="Style/userManagement.css">
    <link rel="stylesheet" href="Style/Navstyle.css">
</head>
<body>
<!-- Navigation Bar -->
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


    <section class="tble">
        <section class="studentTable">
        <div class="title">
            <p class="tit">Student Management Table</p>
        </div>

        <div class="tableST">
            <table>
                <thead>
                <tr>
                    <th>STID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                    <th>Action</th>

                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>STID23</td>
                    <td>Dineth Nethmika</td>
                    <td>Dineth@gmail.com</td>
                    <td>2005-23-04</td>
                    <td>
                        <button><a href="viewProfile.jsp">View Profile</a></button>
                        <button>Ban</button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

    </section>
        <section class="instructorTable">
        <div class="title">
            <p class="tit">Instructor Management Table</p>
        </div>
        <table>
            <thead>
            <tr>
                <th>STID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Birthday</th>
                <th>Action</th>

            </tr>
            </thead>
            <tbody>
            <tr>
                <td>STID23</td>
                <td>Dineth Nethmika</td>
                <td>Dineth@gmail.com</td>
                <td>2005-23-04</td>
                <td>
                    <button> <a href="viewProfile.jsp">View Profile</a></button>
                    <button>Ban</button>
                </td>
            </tr>
            </tbody>
        </table>
        </section>
    </section>
</body>
</html>
