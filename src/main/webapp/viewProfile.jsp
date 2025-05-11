<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="com.util.fileReading" %>
<!DOCTYPE html>

<%

    String profileID = request.getParameter("userID");
    String SelectRole = request.getParameter("role");

    final String filepath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    String uID = null , username = null, firstName  = null, lastName = null, email = null , birthday = null,gender = null, urole = null , avatar = null;

    List<String> fileDataStore = new ArrayList<>();
    fileReading readData = new fileReading(filepath);


    readData.readFile();

    if (SelectRole.equals("Student")) {
        fileDataStore = readData.getStData();
        for(String data : fileDataStore) {
            String[] dataSplit = data.split("\t");
            if (profileID.equals(dataSplit[0])) {
                uID = dataSplit[0];
                username =  dataSplit[1];
                firstName = dataSplit[2];
                lastName = dataSplit[3];
                email = dataSplit[4];
                birthday = dataSplit[5];
                gender= dataSplit[6];
                urole =dataSplit[7];
                avatar = dataSplit[8];
                System.out.println("Student working.....");
            }
        }


    }else {
        fileDataStore = readData.getInData();
        for(String data : fileDataStore) {
            String[] dataSplit = data.split("\t");
            if (profileID.equals(dataSplit[0])) {
                uID = dataSplit[0];
                username =  dataSplit[1];
                firstName = dataSplit[2];
                lastName = dataSplit[3];
                email = dataSplit[4];
                birthday = dataSplit[5];
                gender= dataSplit[6];
                urole =dataSplit[7];
                avatar = dataSplit[8];

                System.out.println("teacher working.....");
            }
        }

    }

%>

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
        <img src="image/<%=avatar%>" alt="userProfile">
    </div>

    <div class="userDetail">
        <div class="section1">
            <p class="list">UserId :<b> UI<%=profileID%> </b> </p>
            <p class="list">Role : <b> <%=urole%> </b>  </p>
        </div>
        <div class="section2">
            <p class="list">UserName :<b> <%=username%> </b></p>
            <p class="list">Registrated Date : 2024-03-5</p>
        </div>
    </div>

    <div class="userDetail2">
        <div class="section1">
            <p class="list">Email :<b> <%=email%></b> </p>
            <p class="list">Phone No:  Student  </p>
            <p class="list">Full Name :<b> <%=firstName%> <%=lastName%></b></p>
            <p class="list">Birthday :<b> <%=birthday%></b></p>
        </div>
    </div>


</section>

<section class="enrollSection">
    <%
        if ("Student".equals(SelectRole)) {
    %>
    <h2 class="tit">User Enrolled Courses</h2>
    <%
    } else {
    %>
    <h2 class="tit">User Created Courses</h2>
    <%
        }
    %>
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