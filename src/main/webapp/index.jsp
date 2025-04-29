<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="styleSheet" href="Style/index.css" type="text/css">
</head>
<body>
<section class="section1">
    <div class="header">
        <h4 class="webgreat">Welcome Back</h4>
        <h3 class="webHeader">CourseEnroll</h3>
        <p class="webTitle">Online Course Registration System</p>
    </div>
</section>
<section class="section2">
    <div class="loginForm">

        <form action="loginServlet" method="post">
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
                <a class="forgottLink" href="#forgetpass" title="Click Change your Password">Forgot Password?</a>
            </div>

            <div class="containerForget ">
                <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            </div>
        </form>

    </div>
</section>

</body>
</html>