<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 3/30/2025
  Time: 4:21 AM
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
    String role = (String) session.getAttribute("role");
    String avatar = (String) session.getAttribute("avatar");
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <link rel="stylesheet" href="Style/Navstyle.css">
    </head>
    <body>

    <!--Navigation bar -->
    <nav>
        <div class="webHeader">
            <h2 class="headerTxt"> ./EnrollEdu</h2>
        </div>
        <div class="searchBar">
            <input class="navSearch"  placeholder="Find your Interest Subjects" name="userWant" >
        </div>
        <div class="navLink">
            <ul>
                <li><a class="" href="home.jsp">Home</a></li>
                <li><a class="" href="#course">Course</a></li>
                <li><a class="" href="#about">About</a></li>
            </ul>
        </div>

        <div class="instuctorBtn">
            <% if ("Instructor".equals(role)) { %>
            <a class="btn" href="createCourse.jsp">Create course</a>
            <% } %>
        </div>

        <div class="profile">
            <img class="avatar" src="./image/<%= (avatar != null) ? avatar : "davatar.webp" %>" alt="User Avatar" width="40" height="40">
            <div class="profile-dropdown">
                <a href="profile.jsp">User Profile</a>
                <a href="#enrolled">Enrolled Courses</a>
                <a href="index.jsp">Logout</a>
            </div>
        </div>
    </nav>
    <!--Navigation bar -->

    <form action="createCourseServlet" method="post" enctype="multipart/form-data">

    <label>Course Title:</label>
        <input type="text" name="title" class="form-control" required>

        <br>

        <label>Course Description:</label>
        <input type="text" name="description" class="form-control" maxlength="500" size="50" required>

        <br>

        <label>Instructor Name:</label>
        <input type="text" name="instructor" class="form-control" required>

        <br>


        <label>Price:</label>
        <input type="number" name="price" class="form-control" required>

        <br>

        <label>Level :</label>
        <label>
            <select name="level" required>
                <option value="Beginner">Beginner Level</option>
                <option value="Advance">Advance Level</option>
                <option value="Intermediate">Intermediate Level</option>
            </select>
        </label>

        <div>
            <label>Course Type:</label>
            <div>
                <input type="checkbox" id="math" name="interests" value="Mathematics">
                <label for="math">Mathematics</label>

                <input type="checkbox" id="science" name="interests" value="Science">
                <label for="science">Science</label>

                <input type="checkbox" id="programming" name="interests" value="Programming">
                <label for="programming">Programming</label>

                <input type="checkbox" id="history" name="interests" value="History">
                <label for="history">History</label>

                <input type="checkbox" id="literature" name="interests" value="Literature">
                <label for="literature">Literature</label>

                <input type="checkbox" id="physics" name="interests" value="Physics">
                <label for="physics">Physics</label>

                <input type="checkbox" id="chemistry" name="interests" value="Chemistry">
                <label for="chemistry">Chemistry</label>

                <input type="checkbox" id="arts" name="interests" value="Arts">
                <label for="arts">Arts</label>
            </div>
        </div>



        <label>Upload Course Image:</label>
        <input type="file" name="image" class="form-control" accept="image/*" required>

        <br>


        <button type="submit" class="btn btn-success mt-3 w-100">Create Course</button>
    </form>

    </body>
</html>
