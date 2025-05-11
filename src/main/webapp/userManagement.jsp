<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 5/5/2025
  Time: 9:56 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    List<String> StData = (List<String>) request.getAttribute("StData");
    List<String> InData = (List<String>) request.getAttribute("InData");


%>

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
                    <th>UID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Birthday</th>
                    <th>Gender</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (StData != null && !StData.isEmpty()) {
                        for (String item : StData) {
                            String[] fields = item.split("\t");
                            if (fields.length >= 8) {
                %>
                <tr>
                    <td>UI<%= fields[0] %></td>
                    <td><%= fields[2] +" "+ fields[3] %></td>
                    <td><%= fields[4] %></td>
                    <td><%= fields[5] %></td>
                    <td><%= fields[6] %></td>
                    <td>
                        <form action="ViewProfileServlet" method="post">
                            <input type="hidden" value="<%= fields[7] %>" name="role">
                            <input type="hidden" name="userID"  value="<%=fields[0]%>">
                            <button type="submit">View Profile</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                } else {
                %>
                <tr>
                    <td colspan="5">No instructor data found.</td>
                </tr>
                <%
                    }
                %>
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
                <th>UID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Birthday</th>
                <th>Gender</th>
                <th>Role</th>
                <th>Action</th>

            </tr>
            </thead>
            <tbody>
            <%
                if (InData != null && !InData.isEmpty()) {
                    for (String item : InData) {
                        String[] fields = item.split("\t");
                        if (fields.length >= 8) {
            %>
            <tr>
                <td>UI<%= fields[0] %></td>
                <td><%= fields[2] +" "+ fields[3] %></td>
                <td><%= fields[4] %></td>
                <td><%= fields[5] %></td>
                <td><%= fields[6] %></td>
                <td><%= fields[7] %></td>
                <td>
                    <form action="ViewProfileServlet" method="post">
                        <input type="hidden" value="<%= fields[7] %>" name="role">
                        <input type="hidden" name="userID"  value="<%=fields[0]%>">
                        <button type="submit">View Profile</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                }
            } else {
            %>
            <tr>
                <td colspan="5">No instructor data found.</td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
        </section>
    </section>
</body>
</html>
