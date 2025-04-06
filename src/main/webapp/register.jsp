<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 3/29/2025
  Time: 9:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String errorMSG = (String) request.getAttribute("errorT1");
    String errorMSG1 = (String) request.getAttribute("errorT2");
%>

<html>
    <head>
        <title>./EnrollEdu|Register</title>
    </head>
    <body>

    <div class="registration-container">
        <div class="registration-box">
            <h2>Student & Instructor Registration</h2>

            <form action="registerServlet" method="post" enctype="multipart/form-data" >

                <div>
                    <label>Upload Course Image:</label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                </div>

                <div>
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" required  >
                </div>

                <div>
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>

                <div>
                    <label for="username">Username:</label>
                    <input type="text" id="username" name="username" required>
                </div>

                <div >
                    <label for="email">Email Address:</label>
                    <input type="email" id="email" name="email" required>
                </div>

                <div >
                    <label for="birthDate">Birth Date:</label>
                    <input type="date" id="birthDate" name="birthDate" required>
                </div>

                <div>
                    <label>Gender:</label>
                    <div class="radio-group">
                        <input type="radio" id="male" name="gender" value="Male" required>
                        <label for="male">Male</label>

                        <input type="radio" id="female" name="gender" value="Female">
                        <label for="female">Female</label>

                        <input type="radio" id="other" name="gender" value="Other">
                        <label for="other">Other</label>
                    </div>
                </div>

                <div >
                    <label for="role">Role:</label>
                    <select id="role" name="role" required>
                        <option value="Student">Student</option>
                        <option value="Instructor">Instructor</option>
                    </select>
                </div>

                <div>
                    <label for="password">Create Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div >
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>

                <div>
                    <label>Interest Topics/Subjects:</label>
                    <div >
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

                <button type="submit">Register</button>

            </form>

            <%
                if(errorMSG1 != null){
            %>

            <p> <%=errorMSG1%> </p>

            <%
                } else if (errorMSG != null){
            %>
            <p> <%=errorMSG%> </p>
            <%}%>

    <div>
                <p>Already have an account? <a href="./index.jsp">Login here</a></p>
            </div>
        </div>
    </div>


    </body>
</html>
