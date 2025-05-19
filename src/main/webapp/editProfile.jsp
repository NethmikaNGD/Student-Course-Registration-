<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.util.fileReading" %>
<%@ page import="com.util.CourseFileReading" %>
<%@ page import="com.util.ReadData" %>

<%
    String profileID = request.getParameter("userID");
    String SelectRole = request.getParameter("role");

    final String enrolCourse = "D:\\Project\\LMS\\src\\main\\Database\\EnrollList\\courseEnroll";
    final String filepath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    String uID = null, username = null, firstName = null, lastName = null, email = null, birthday = null, gender = null, urole = null, avatar = null;

    List<String> fileDataStore = new ArrayList<>();
    List<String> enrollList = new ArrayList<>();

    fileReading readData = new fileReading(filepath);
    ReadData read = new ReadData();
    readData.readFile();

    if ("Student".equals(SelectRole)) {
        fileDataStore = readData.getStData();
    } else {
        fileDataStore = readData.getInData();
    }

    for (String data : fileDataStore) {
        String[] dataSplit = data.split("\t");
        if (profileID.equals(dataSplit[0])) {
            uID = dataSplit[0];
            username = dataSplit[1];
            firstName = dataSplit[2];
            lastName = dataSplit[3];
            email = dataSplit[4];
            birthday = dataSplit[5];
            gender = dataSplit[6];
            urole = dataSplit[7];
            avatar = dataSplit[8];
            break;
        }
    }

    read.setFileName(enrolCourse);
    read.readFile();
    enrollList = read.getSaveData();

%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>View Profile</title>
    <link rel="stylesheet" href="Style/viewProfileStyle.css">
    <link rel="stylesheet" href="Style/Navstyle.css">
</head>
<body>

<!-- Navigation -->
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

<!-- Profile Section -->
<section class="webHeader1">
    <h2 class="tit">User Profile View</h2>
    <div class="userProfile">
        <img src="image/<%= avatar %>" alt="userProfile">
    </div>
    <div class="userDetail">
        <div class="section1">
            <p class="list">UserId : <b>UI<%= profileID %></b></p>
            <p class="list">Role : <b><%= urole %></b></p>
        </div>
        <div class="section2">
            <p class="list">UserName : <b><%= username %></b></p>
            <p class="list">Registered Date : 2024-03-05</p>
        </div>
    </div>
    <div class="userDetail2">
        <div class="section1">
            <p class="list">Email : <b><%= email %></b></p>
            <p class="list">Phone No: N/A</p>
            <p class="list">Full Name : <b><%= firstName %> <%= lastName %></b></p>
            <p class="list">Birthday : <b><%= birthday %></b></p>
        </div>
    </div>
</section>

<!-- Course Info Section -->
<section class="enrollSection">
    <h2 class="tit">
        <% if ("Student".equals(SelectRole)) { %>
        User Enrolled Courses
        <% } else { %>
        User Created Courses
        <% } %>
    </h2>

    <div class="couserheader">
        <p>CID</p>
        <p>Course Name</p>
        <p>Instructor Name</p>
        <p>Enrolled Date</p>
    </div>

    <%
        for (String data1 :enrollList ) {
            String[] dataArray = data1.split("\t");
            if (dataArray.length >= 6 && profileID.equals(dataArray[0])) {
    %>
    <div class="couserDisplay">
        <h4><%= dataArray[2] %></h4> <!-- Course ID -->
        <h4><%= dataArray[4] %></h4> <!-- Course Title -->
        <h4><%= dataArray[3] %></h4> <!-- Course Owner -->
        <h4><%= dataArray[5] %></h4> <!-- Enrollment Date -->
    </div>
    <%
            }
        }
    %>
</section>

</body>
</html>
