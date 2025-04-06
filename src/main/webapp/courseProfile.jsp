<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 4/6/2025
  Time: 11:41 AM
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
    <link rel="stylesheet" href="Style/courseProfilestyle.css">
</head>
<body>
<!---nav -->
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

<!---nav -->
    <section class="coursePage">
    <section class="Banner">
        <section class="header">
            <div class="details">

                <div class="paidtype">
                    <p class="price">Free</p>
                    <p class="courseType">Course</p>
                </div>

                <div class="Cheader">
                    <p class="courseHeader">Learning Rasberry PI</p>
                </div>

                <div class="Cdes">
                    Learn the basics of Rasberry PI, the world-famous credit card size computer, and linux operating system.
                </div>

                <div class="rating">
                    <p class="rate">4.3</p>
                </div>

                <div class="enrollBTN">
                    <button class="Start">Start</button>
                    <p class="countEnrolled">11,550 learners enrolled</p>
                </div>

            </div>
            <div class="includes">
                <div class="list">
                    <p class="includeHeader">This Course includes</p>
                    <p class="list">Al assistance for guided coding help</p>
                    <p class="list">Project to apply new skills</p>
                    <p class="list">A cetificate of completion</p>

                </div>
            </div>
        </section>
    </section>

    <section class="main">
        <div class="level">
            <p class="topic">Skill Level</p>
            <p class="includeData">Beginner</p>
        </div>
        <div class="time">
            <p class="topic">Timme to Complete</p>
            <p class="includeData">2 hours</p>
        </div>
        <div class="project">
            <p class="topic">Project</p>
            <p class="includeData">1</p>
        </div>
        <div class="prerequistites">
            <p class="topic">Prerequisites</p>
            <p class="includeData">None</p>
        </div>
    </section>

    <section class="about">
        <div class="aboutThis">
            <h2 class="topic2">About this course</h2>
            <p class="description">Build on your JavaScript foundation with Intermediate JavaScript. This course dives into advanced concepts like classes, promises, async/await, and requests. You’ll learn how to create more dynamic and efficient web applications while mastering essential techniques for structuring and optimizing large-scale projects.</p>
        </div>
        <div class="skill">
            <h2 class="topic2">Skill you'll gain</h2>
            <li class="point">Understanding currying, hoisting, and concurrency</li>
            <li class="point">Structuring web apps with classes and modules</li>
            <li class="point">Using promises and async/await for asynchronous programming</li>
            <li class="point">Using promises and async/await for asynchronous programming</li>
        </div>
    </section>
</section>


</body>
</html>
