<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>

<%
    int stCount = (request.getAttribute("studentCount") != null) ? (Integer) request.getAttribute("studentCount") : 0;
    int inCount = (request.getAttribute("instructorCount") != null) ? (Integer) request.getAttribute("instructorCount") : 0;
    int pendingIn = (request.getAttribute("pendingInstructorCount") != null) ? (Integer) request.getAttribute("pendingInstructorCount") : 0;
    int courseCount = (request.getAttribute("courseCount") != null) ? (Integer) request.getAttribute("courseCount") : 0;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";
    File file = new File(dataSavePath);

    List<String[]> studentList = new ArrayList<>();
    List<String[]> instructorList = new ArrayList<>();
    List<String[]> pendingInstructorList = new ArrayList<>();

    if (file.exists()) {
        BufferedReader read = new BufferedReader(new FileReader(file));
        String data;
        while ((data = read.readLine()) != null) {
            String[] details = data.split("\t");
            if (details.length == 9) {
                if ("Student".equals(details[7])) {
                    studentList.add(details);
                } else if ("Instructor".equals(details[7])) {
                    instructorList.add(details);
                }else {
                    pendingInstructorList.add(details);
                }
            }
        }
        read.close();
    }
%>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Style/adminStyle.css">
    <link rel="stylesheet" href="Style/Navstyle.css">
    <title>Admin DashBoard</title>
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

<div class="header">
    <h2>Web Summary</h2>
</div>

<!-- Summary Cards -->
<section class="actionBar">
    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber"><%=stCount%></p></div>
            <div class="title"><p class="pTitle">Number of Students</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber"><%=inCount%></p></div>
            <div class="title"><p class="pTitle">Number of Instructors</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber"><%=courseCount%></p></div>
            <div class="title"><p class="pTitle">Number of Courses</p></div>
        </div>
    </section>

    <section class="actionBarDiv1">
        <div class="container">
            <div class="number"><p class="pNumber"><%=pendingIn%></p></div>
            <div class="title"><p class="pTitle">Pending Instructors</p></div>
        </div>
    </section>
</section>
<!-- End Summary Cards -->

<section class="display">
    <!-- Students Table -->
    <section class="displayStudents">
        <div class="header1">
            <h2>Students' Table</h2>
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
                <%
                    for (String[] details : studentList) {
                %>
                <tr>
                    <td>ST<%=details[0]%></td>
                    <td><%=details[2]%> <%=details[3]%></td>
                    <td><%=details[4]%></td>
                    <td><%=details[5]%></td>
                    <td>
                        <form action="banUser.jsp" method="post">
                            <input type="hidden" name="id" value="<%= details[0] %>">
                            <input type="hidden" name="role" value="student">
                            <button class="ban-btn">Ban</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Instructors Table -->
    <section class="displayInstructors">
        <div class="header1">
            <h2>Instructors' Table</h2>
            <table>
                <thead>
                <tr>
                    <th>INID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (String[] details : instructorList) {
                %>
                <tr>
                    <td>IN<%=details[0]%></td>
                    <td><%=details[2]%> <%=details[3]%></td>
                    <td><%=details[4]%></td>
                    <td><%=details[5]%></td>
                    <td>
                        <form action="banUser.jsp" method="post">
                            <input type="hidden" name="id" value="<%= details[0] %>">
                            <input type="hidden" name="role" value="student">
                            <button class="ban-btn">Ban</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

    <!-- Pending Instructors Table -->
    <section class="displayInstructors">
        <div class="header1">
            <h2>Pending Instructors' Table</h2>
            <table>
                <thead>
                <tr>
                    <th>INID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                    <th>Action</th>

                </tr>
                </thead>
                <tbody>
                <%
                    for (String[] details : pendingInstructorList) {
                %>
                <tr>
                    <td>IN<%=details[0]%></td>
                    <td><%=details[2]%> <%=details[3]%></td>
                    <td><i>Not Provided</i></td>
                    <td><%=details[5]%></td>
                    <td>
                        <form method="post" action="ApproveInstructorServlet" style="display:inline;">
                            <input type="hidden" name="id"  value="${user[0]}">
                            <input type="hidden" name="fullData" value="<%=String.join("\t", details)%>">
                            <button type="submit" class="approve-btn">Approve</button>
                        </form>
                        <form method="post" action="ApproveInstructorServlet" style="display:inline;">
                            <input type="hidden" name="id" value="<%=details[0]%>">
                            <button type="submit" class="reject-btn">Reject</button>
                        </form>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>

</section>

</body>
</html>
