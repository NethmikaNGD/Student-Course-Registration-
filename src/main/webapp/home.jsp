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


    // Read user information from the file
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 8) continue; // Prevent ArrayIndexOutOfBoundsException

            Uname = data[0]; // Username in the file
            if (fName.equals(Uname)) {
                fName = data[1]; // First name
//                role = data[6];  // Role
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
%><html>
<head>
    <title>Home</title>
    <link rel="stylesheet" href="Style/Navstyle.css">
    <link rel="stylesheet" href="Style/courseCard.css">

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

       <% if ("admin".equals(role)){ %>
        <a class="btn" href="AdminPannel.jsp">Admin Panel</a>
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

<!-- Course Container -->
<div class="displaycourseArea">
    <%
        // CID +  User +  CT  + CD + FN + PRICE + TYpe = IMG
        String dataFile = "D:\\Project\\LMS\\src\\main\\Database\\courseData\\CourseInfor.txt";
        File file = new File(dataFile);
        if (file.exists()) {
            BufferedReader read = new BufferedReader(new FileReader(file));
            String data;
            while ((data = read.readLine()) != null) {
                String[] details = data.split("\t");
                if (details.length == 9) {

                    String courseImage = "image/" + details[7]; // Ensure image path is correct
                    System.out.println(courseImage);
    %>
    <div class="allContainer">
        <div class="image">
            <img class="courseimg" src="<%=courseImage%>" alt="Course Image">
        </div>
        <div class="textContainer">
            <h2 class="header"> <%=details[2]%> </h2>
            <p class="authur"><%=details[4]%></p>
            <p class="dis"><%=details[3]%></p>
        </div>
        <div class="bottonBar">
            <div class="price">
                <p class="priceOne">$<%=details[5]%></p>
            </div>
            <div class="buyBar">
                <a href="courseProfile.jsp" class="enroll">Enroll</a>
            </div>
        </div>
    </div>
    <%
                }
            }
        }
    %>

</div> <!-- End of course_container -->



</body>
</html>

