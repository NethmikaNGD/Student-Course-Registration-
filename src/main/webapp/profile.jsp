<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.FileReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    // Redirect to login if the session is invalid
    if (session == null || session.getAttribute("username") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    // Retrieve session attributes
    String fName = (String) session.getAttribute("username");

    String email = null;
    String bday = null;
    String lname= null;
    String username = null;
    String role = null;
    String avatar = null;
    String Uname = null;
    String gender = null;

    String dataSavePath = "D:\\Project\\LMS\\src\\main\\Database\\userRegister\\userInfor.txt";

    //username firstName lastName email bday gender role avater

    // Read user information from the file
    try (BufferedReader readData = new BufferedReader(new FileReader(dataSavePath))) {
        String line;
        while ((line = readData.readLine()) != null) {
            String[] data = line.split("\t");
            if (data.length < 8) continue; // Prevent ArrayIndexOutOfBoundsException

            Uname = data[0]; // Username in the file
            if (fName.equals(Uname)) {
                fName = data[1]; // First name
                lname = data[2];// last name
                email = data[3];//email
                bday = data[4];
                gender = data[5];
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

<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="Style/Navstyle.css">
    <link rel="stylesheet" href="Style/userProfile.css">
    <link rel="stylesheet" href="Style/editProfile.css">
</head>
<body>

<!-- Navigation bar -->
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
        <img class="avatar" src="./image/<%= avatar %>" alt="User Avatar" width="40" height="40">
        <div class="profile-dropdown">
            <a href="profile.jsp">User Profile</a>
            <a href="#enrolled">Enrolled Courses</a>
            <a href="index.jsp">Logout</a>
        </div>
    </div>
</nav>
<!-- Navigation bar -->

<!-- User Profile -->
<!-- User Profile -->
<section class="content">
    <div class="userInfor" id="viewProfile">
        <div class="userNameLine">
            <div class="userProfile">
                <img class="userProfilePic" src="image/<%=avatar%>" alt="profile">
            </div>

            <div class="nameContainer">
                <div class="userName">
                    <p class="userNameTxt"><%=fName%>  <%=lname%></p>
                    <p class="userTitle">Software Engineer</p>
                </div>
                <!-- Edit Button -->
                <button class="edit-btn" onclick="toggleEdit()">
                    <img class="editIcon" src="image/pencil-fill.svg">
                </button>
            </div>
        </div>

        <div class="contacInfor">
            <div class="userContac">
                <div class="infor">
                    <li>Phone</li>
                    <li>Address</li>
                    <li>E-mail</li>
                    <li>Site</li>
                    <li>Education</li>
                    <li>Birth Day</li>
                    <li>Gender</li>
                </div>
                <div class="infor1">
                    <li class="txt">0703411403</li>
                    <li class="txt">119/A Near The School, Matara</li>
                    <li class="txt"><%=email%></li>
                    <li class="txt">Jeremy.WorkSpace.com</li>
                    <li class="txt">SLIIT</li>
                    <li class="txt"><%=bday%></li>
                    <li class="txt"><%=gender%></li>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Profile Form (Initially Hidden) -->
    <div class="userInfor" id="editProfile" style="display: none;">
        <div class="userNameLine">
            <div class="userProfile">
                <img class="userProfilePic" src="image/<%= avatar %>" alt="profile">
            </div>

            <div class="nameContainer">
                <div class="userName">
                    <p class="userNameTxt"><%=fName%>  <%=lname%></p>
                    <input class="userJobType" type="text" name="jobTitle" placeholder="Job Type">
                </div>
                <p class="editIcon">Editing</p>
            </div>
        </div>

        <div class="contacInfor">
            <div class="userContac">
                <div class="infor">
                    <li>Phone</li>
                    <li>Address</li>
                    <li>E-mail</li>
                    <li>Site</li>
                    <li>Education</li>
                    <li>Birth Day</li>
                    <li>Gender</li>
                </div>
                <div class="infor1">
                    <input type="text" name="phoneNo" class="phoneNo" placeholder="0703411403">
                    <input type="text" name="address" class="phoneNo" placeholder="119/A Near the school">
                    <input type="email" name="email" class="phoneNo" placeholder="<%=email%>">
                    <input type="text" name="site" class="phoneNo" placeholder="www.gmail.com">
                    <input type="text" name="edu" class="phoneNo" placeholder="SLIIT">
                    <input type="date" name="bday" class="phoneNo" value="<%=bday%>">
                    <p class="phoneNo"><%=gender%></p>
                </div>
            </div>
        </div>

        <div class="saveBtnContainer">
            <button class="save-btn" onclick="toggleEdit()">Save</button>
            <button class="cancel-btn" onclick="toggleEdit()">Cancel</button>
        </div>
    </div>
<!-- JavaScript to Toggle Edit Mode -->
<script>
    function toggleEdit() {
        var viewProfile = document.getElementById("viewProfile");
        var editProfile = document.getElementById("editProfile");

        if (editProfile.style.display === "none") {
            editProfile.style.display = "block";
            viewProfile.style.display = "none";
        } else {
            editProfile.style.display = "none";
            viewProfile.style.display = "block";
        }
    }
</script>


    <div class="courseInfor">
        <div class="headerName">
            <p class="headerText"><%= ("Instructor".equals(role)) ? "Posted Courses" : "Enrolled Courses" %></p>
        </div>
        <div class="courseContainer">
            <div class="courseHeader">
                <p class="couserTitle">Data Science and Machine Learning</p>
            </div>
            <div class="enrollCount">
                <p class="courseEnroll">30</p>
            </div>
            <div class="earning">
                <p class="courseIncome">$1000</p>
            </div>
            <%
                if("Student".equals(role)){
            %>
            <div class="studentBTN">
                <a href="#viewCourse" class="view">View</a>
            </div>
            <%
                }else{
            %>
            <div class="editSection">
                <a href="#edit"><img class="editIcon" src="image/pencil-fill.svg"></a>
                <a href="#remove"><img class="editIcon trash" src="image/trash3-fill.svg"></a>
            </div>

            <%
                }
            %>

        </div>
    </div>
</section>
<!-- User Profile -->

</body>
</html>
