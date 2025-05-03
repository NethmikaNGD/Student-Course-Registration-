<%--
  Created by IntelliJ IDEA.
  User: Dinet
  Date: 5/3/2025
  Time: 8:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>reset password</title>
</head>
<body>
<div id="forgotModal" class="modal">
    <div class="modal-content">
        <h2>Reset Your Password</h2>
        <form action="forgotPasswordServlet" method="post">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter UserName" required>
            <br>
            <label>Email</label>
            <input type="email" name="email" placeholder="Enter your email" required>
            <br>
            <input type="submit" value="Submit">
        </form>


        <form action="#">
            <label>New Password :
                <input type="password" name="password" placeholder="Enter New Password" required>
            </label>
            <br>
            <label>confirm password :
                <input type="password" name="Cpassword" placeholder="Confirm Password" required>
            </label>

            <br>
            <input type="submit" value="Submit">
        </form>

    </div>
</div>


</body>
</html>
