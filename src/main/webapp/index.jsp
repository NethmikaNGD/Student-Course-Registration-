<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Style/index.css">
    <title>Welcome EnrollEdu</title>
</head>
<body>
<section class="section2">
    <div class="loginForm">
        <form action="loginServlet" method="post">
            <div class="heade"><p>Login</p></div>
            <div>
                <input class="inputLable" type="text" name="username" placeholder="Username" required>
            </div>

            <div>
                <input class="inputLable" type="password" name="password"  placeholder="Password" required>
            </div>

            <%
                String errorT3 = (String) request.getAttribute("errorT3");
                if (errorT3 != null){

            %>

            <p class="PrintError"> <%=errorT3%> </p>
            <%

                }
            %>


            <button type="submit" class="loginBtn"  >Login</button>

            <div class="containerForget">
                <a class="forgottLink" href="ForgetPass.jsp" title="Click Change your Password">Forgot Password?</a>
            </div>

            <div class="containerForget ">
                <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            </div>
        </form>

    </div>
</section>

</body>
</html>