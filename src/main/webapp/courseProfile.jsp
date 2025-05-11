<%@ page import="java.io.*" %>
<%
    String courseId = request.getParameter("courseId");

    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    String fName = (String) session.getAttribute("username");
    String role = (String) session.getAttribute("role");

    String avatar = null;
    String Uname = null;
    String userID = null;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    String[] filePaths = {
            "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt",
            "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor1.txt"
    };

    // Load user info
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 9) continue;

            userID = data[0];
            Uname = data[1];
            if (fName.equals(Uname)) {
                fName = data[2];
                avatar = data[8];
                break;
            }
        }
    } catch (IOException e) {
        System.out.println("User info read error: " + e.getMessage());
        response.sendRedirect("index.jsp");
        return;
    }

    String[] course = null;
    String courseType = "Free";

    for (String path : filePaths) {
        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;
            while ((line = reader.readLine()) != null) {
                course = line.split("\t");
                if (course.length < 7) continue;

                if (course[0].equals(courseId)) {
                    try {
                        double price = Double.parseDouble(course[5]);
                        courseType = (price == 0.0) ? "Free" : "Paid";
                    } catch (NumberFormatException e) {
                        courseType = "Free"; // fallback
                    }
                    break;
                }
            }
        } catch (IOException e) {
            System.out.println("File read error: " + e.getMessage());
        }

        if (course != null && course[0].equals(courseId)) break;
    }

    if (course == null) {
        out.println("<h2>Course not found</h2>");
        return;
    }
    String name = null;
    boolean enrolled = false;
    String enrollFile = "D:\\Project\\LMS\\src\\main\\Database\\EnrollList\\courseEnroll";

    try (BufferedReader enrollReader = new BufferedReader(new FileReader(enrollFile))) {
        String line;
        while ((line = enrollReader.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 3) continue;

            if (data[0].equals(userID) && data[2].equals(courseId)) {
                enrolled = true;
                break;
            }
        }
    } catch (IOException e) {
        System.out.println("Enrollment check error: " + e.getMessage());
    }
    name = enrolled ? "working" : "not working";

%>

<!DOCTYPE html>
<html>
<head>
    <title>Course Profile</title>
    <link rel="stylesheet" href="Style/Navstyle.css">
    <link rel="stylesheet" href="Style/courseProfilestyle.css">
</head>
<body>
<!-- Nav -->
<nav>
    <div class="webHeader">
        <h2 class="headerTxt"> <a href="home.jsp">./EnrollEdu</a></h2>
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

<!-- Course Info -->
<section class="coursePage">
    <section class="Banner">
        <section class="header">
            <div class="details">
                <div class="paidtype">
                    <p class="price"><%=courseType%></p>
                    <p class="courseType">Course</p>
                </div>

                <div class="Cheader">
                    <p class="courseHeader"><%=course[2]%></p>
                </div>

                <div class="Cdes"><%=course[3]%></div>
                <div class="Cdes"><%=course[4]%></div>

                <div class="rating">
                    <p class="rate">$ <%=course[5]%></p>
                </div>

<%--Enroll here--%>
                <div class="enrollBTN">
                    <form action="enrollServlet" method="post">
                        <input type="hidden" value="<%= course[0] %>" name="courseId">
                        <input type="hidden" value="<%= userID %>" name="userID">
                        <input type="hidden" value="<%= Uname %>" name="username">
                        <input type="hidden" value="<%= course[1] %>" name="courseOwner">
                        <%
                            if (enrolled){
                        %>
                            <button class="Start" type="submit" name="Enrolled" value="true">Enrolled</button>
                        <%
                            }else{
                        %>
                            <button class="Start" type="submit" name="Enrolled" value="true">Start</button>
                        <%
                            }
                        %>

                    </form>

                    <p class="countEnrolled">11,550 learners enrolled</p>
                </div>
            </div>
            <div class="includes">
                <div class="list">
                    <p class="includeHeader">This Course includes</p>
                    <p class="list">AI assistance for guided coding help</p>
                    <p class="list">Project to apply new skills</p>
                    <p class="list">A certificate of completion</p>
                </div>
            </div>
        </section>
    </section>

    <section class="main">
        <div class="level">
            <p class="topic">Skill Level</p>
            <p class="includeData"><%=course[6]%></p>
        </div>
        <div class="time">
            <p class="topic">Time to Complete</p>
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
            <p class="description">Build on your JavaScript foundation with Intermediate JavaScript. This course dives into advanced concepts like classes, promises, async/await, and requests.</p>
        </div>
        <div class="skill">
            <h2 class="topic2">Skills you'll gain</h2>
            <li class="point">Understanding currying, hoisting, and concurrency</li>
            <li class="point">Structuring web apps with classes and modules</li>
            <li class="point">Using promises and async/await for async programming</li>
        </div>
    </section>

</section>

</body>
</html>
