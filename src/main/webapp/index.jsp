

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
        <form action="loginServlet" method="post">
            <div>
                <input type="text" name="username" placeholder="Username" required>
            </div>

            <div>
                <input type="password" name="password"  placeholder="Password" required>
            </div>

            <div>
                <a href="#forgetpass">Forgot Password?</a>
            </div>

            <%
                String errorT3 = (String) request.getAttribute("errorT3");
                if (errorT3 != null){

            %>

                    <p> <%=errorT3%> </p>
            <%

                }
            %>

            <button type="submit"  >Login</button>

            <%@ page import="java.text.SimpleDateFormat, java.util.Date" %>
            <%
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String dateTime = formatter.format(new Date());
            %>
            Hello there!!! The time is <%= dateTime %>



            <div >
                <p>Don't have an account? <a href="register.jsp">Sign Up</a></p>
            </div>
        </form>

    </div>
    <!--Login section-->
    </body>
</html>