<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %><%--
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

    String username = null;
    String avatar = null;
    String Uname = null;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    String userID = null;

    // Read user information from the file
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 9) continue; // Prevent ArrayIndexOutOfBoundsException

            userID = data[0];
            Uname = data[1]; // Username in the file
            if (fName.equals(Uname)) {
                fName = data[2]; // First name
//                role = data[6];  // Role
                avatar = data[8];// Avatar file name

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
        <link rel="stylesheet" href="Style/courseRegStyle.css">
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

        <label>Course mini Description:</label>
        <textarea name="description1" class="form-control des" id="description" maxlength="100" rows="3" required></textarea>
        <p id="charCount">0/100 characters used</p>


        <script>
            const descriptionInput = document.getElementById("description");
            const charCount = document.getElementById("charCount");

            descriptionInput.addEventListener("input", function () {
                const currentLength = this.value.length;
                charCount.textContent = `${currentLength}/100 characters used`;

                // Optional: Prevent user from entering more text when limit is reached
                if (currentLength >= 100) {
                    charCount.style.color = "red"; // Warn user when max is reached
                } else {
                    charCount.style.color = "black";
                }
            });
        </script>



        <label>Instructor Name:</label>
        <input type="text" name="instructor" class="form-control" required>

        <label>Price: $</label>
        <input type="text" name="price" class="form-control" required>

        <label>Duration:</label>
        <input type="number" name="duration" class="form-control" required>

        <label>Project count:</label>
        <input type="number" name="projectCount" class="form-control" required>

        <label>Courses Including:</label>
        <input type="text" name="courseIncluding1" class="form-control" required>
        <label></label>
        <input type="text" name="courseIncluding2" class="form-control" required>
        <label></label>
        <input type="text" name="courseIncluding3" class="form-control" required>

        <label>Course Description:</label>
        <textarea name="description" class="form-control des" class="description1" rows="3" required></textarea>

        <label>Level:</label>
        <select name="level" required>
            <option value="Beginner">Beginner Level</option>
            <option value="Advance">Advance Level</option>
            <option value="Intermediate">Intermediate Level</option>
        </select>

        <div>
            <label>Course Type:</label>
            <div class="course-type-container">
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
        <input type="file" name="image" class="form-control" accept="image/*" id="imageUpload" required>

        <!-- Preview Container -->
        <div id="preview-container">
            <img id="preview" alt="Course Thumbnail Preview">
        </div>

        <button type="submit" class="btn">Create Course</button>
    </form>

    <!-- JavaScript for Image Preview -->
    <script>
        document.getElementById("imageUpload").addEventListener("change", function(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById("preview").src = e.target.result;
                    document.getElementById("preview").style.display = "block";
                };
                reader.readAsDataURL(file);
            }
        });
    </script>

    </body>
</html>
