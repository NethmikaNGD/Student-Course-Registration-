<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome Banner</title>
    <link rel="stylesheet" href="Style/adminStyleLogin.css">
</head>
<body>
<section class="AdminLogin">
    <div class="header">
        <h2 class="TopicHeader">Welcome Admin Pannel</h2>
    </div>
    <div class="inputSection">
        <form action="adminLoginServlet" method="post">
        <label>
            <%
                String AdminError1 = (String) request.getAttribute("AdminError");
                if (AdminError1 != null){
            %>
            <h5 class="adminError"><%=AdminError1%></h5>

            <%
                }
            %>

            <input type="text" class="userName" name="AdminUser" placeholder="Admin Login"><br>

            <input type="password" class="userName" name="AdminPass" placeholder="Password"><br>

            <button type="submit" class="submitBTN">Click to Login</button>
        </label>
        </form>
        <p class="msg">You can't login Contac Developers</p>
    </div>
</section>


</body>
</html>
