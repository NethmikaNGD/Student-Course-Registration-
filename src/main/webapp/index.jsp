
<html>
    <head>
        <title>./EnrollEdu</title>
    </head>

    <body>
    <!--Navigation section-->
    <!--Navigation section-->

    <!--Login section-->
    <div>
        <h2>Welcome Back</h2>
        <form action="LoginServlet" method="post">
            <div>
                <input type="text" name="username" placeholder="Username" required>
            </div>

            <div>
                <input type="password" name="password"  placeholder="Password" required>
            </div>

            <div>
                <a href="#forgetpass">Forgot Password?</a>
            </div>

            <button type="submit" >Login</button>

            <div >
                <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            </div>
        </form>

    </div>
    <!--Login section-->
    </body>
</html>