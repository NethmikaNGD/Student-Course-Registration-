<%-- Created by IntelliJ IDEA. User: Dinet Date: 3/29/2025 Time: 9:08 AM To change this template use File | Settings |
    File Templates. --%>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>

        <% String errorMSG=(String) request.getAttribute("errorT1"); String errorMSG1=(String)
            request.getAttribute("errorT2"); %>

            <html>

            <head>
                <title>./EnrollEdu|Register</title>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="Style/index.css">
                <style>
                    .section2{
                        margin-top: 30pc;
                    }
                </style>

            </head>

            <body>
                <section class="section2">
                    <div class="loginForm">
                        <div class="heade">
                            <p>Student & Instructor Registration</p>
                        </div>

                        <form action="registerServlet" method="post" enctype="multipart/form-data">
                            <div>
                                <input type="file" name="image" class="inputLable" accept="image/*"
                                    placeholder="Upload Profile Image">
                            </div>

                            <div>
                                <input type="text" id="firstName" name="firstName" class="inputLable"
                                    placeholder="First Name" required>
                            </div>

                            <div>
                                <input type="text" id="lastName" name="lastName" class="inputLable"
                                    placeholder="Last Name" required>
                            </div>

                            <div>
                                <input type="text" id="username" name="username" class="inputLable"
                                    placeholder="Username" required>
                            </div>

                            <div>
                                <input type="email" id="email" name="email" class="inputLable"
                                    placeholder="Email Address" required>
                            </div>

                            <div>
                                <input type="date" id="birthDate" name="birthDate" class="inputLable" required>
                            </div>

                            <div class="inputLable" style="padding: 10px;">
                                <label style="display: inline; margin-right: 15px;">Gender:</label>
                                <input type="radio" id="male" name="gender" value="Male" required>
                                <label for="male" style="display: inline;">Male</label>
                                <input type="radio" id="female" name="gender" value="Female" style="margin-left: 10px;">
                                <label for="female" style="display: inline;">Female</label>
                                <input type="radio" id="other" name="gender" value="Other" style="margin-left: 10px;">
                                <label for="other" style="display: inline;">Other</label>
                            </div>

                            <div>
                                <select id="role" name="role" class="inputLable" required>
                                    <option value="" disabled selected>Select Role</option>
                                    <option value="Student">Student</option>
                                    <option value="Pending_Instructor">Instructor</option>
                                </select>
                            </div>

                            <div>
                                <input type="password" id="password" name="password" class="inputLable"
                                    placeholder="Create Password" required>
                            </div>

                            <div>
                                <input type="password" id="confirmPassword" name="confirmPassword" class="inputLable"
                                    placeholder="Confirm Password" required>
                            </div>

                            <div class="inputLable" style="padding: 10px;">
                                <label>Interest Topics:</label>
                                <div
                                    style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 5px; margin-top: 5px;">
                                    <div>
                                        <input type="checkbox" id="math" name="interests" value="Mathematics">
                                        <label for="math" style="display: inline;">Mathematics</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="science" name="interests" value="Science">
                                        <label for="science" style="display: inline;">Science</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="programming" name="interests" value="Programming">
                                        <label for="programming" style="display: inline;">Programming</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="history" name="interests" value="History">
                                        <label for="history" style="display: inline;">History</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="literature" name="interests" value="Literature">
                                        <label for="literature" style="display: inline;">Literature</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="physics" name="interests" value="Physics">
                                        <label for="physics" style="display: inline;">Physics</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="chemistry" name="interests" value="Chemistry">
                                        <label for="chemistry" style="display: inline;">Chemistry</label>
                                    </div>
                                    <div>
                                        <input type="checkbox" id="arts" name="interests" value="Arts">
                                        <label for="arts" style="display: inline;">Arts</label>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="loginBtn">Register</button>
                        </form>

                        <% if(errorMSG1 !=null){ %>
                            <p class="PrintError">
                                <%=errorMSG1%>
                            </p>
                            <% } else if (errorMSG !=null){ %>
                                <p class="PrintError">
                                    <%=errorMSG%>
                                </p>
                                <%}%>

                                    <div class="containerForget">
                                        <p>Already have an account? <a href="./index.jsp">Login here</a></p>
                                    </div>
                    </div>
                </section>
            </body>

            </html>