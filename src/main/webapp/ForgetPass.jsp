<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reset Password</title>
    <link rel="stylesheet" href="Style/index.css">
    <link rel="stylesheet" href="Style/reset.css">

    <style>
        /*body{*/
        /*    background-image: url('../image/reset.png');*/
        /*    background-repeat: no-repeat;*/
        /*    background-attachment: fixed;*/
        /*    background-size: 100% 100%;*/
        /*    font-family: Arial, Helvetica, sans-serif;*/
        /*}*/

        .inputLable{
            height: 30px;
            font-size: 20px;
        }

        .login{

        }


    </style>

</head>
<body>
<%
    Boolean isValidUser = (Boolean) session.getAttribute("validUser");
    String  username = (String) session.getAttribute("username");

%>

<div id="forgotModal" class="modal">
    <div class="modal-content">

        <% if (isValidUser == null || !isValidUser) { %>
        <!-- Show this only when user is not validated -->
        <div class="loginForm">
            <form action="resetPassServlet" method="post">
                <div class="heade"><p>Reset Password</p></div>
                <div>
                    <input class="inputLable" type="text" name="username" placeholder="Username" required>
                </div>

                <div>
                    <input class="inputLable" type="email" name="email"  placeholder="Email" required>
                </div>

                <%
                    String errorT5 = (String) request.getAttribute("errorT5");
                    if (errorT5 != null){

                %>

                <p class="PrintError"> <%=errorT5%> </p>
                <%

                    }
                %>
                <button type="submit" class="loginBtn">Next</button>
            </form>
        </div>

        <% } else { %>
        <!-- Show this only when username/email are valid -->
        <div class="loginForm">
            <form action="setnewPass" method="post">
                <div class="heade"><p>Set New Password</p></div>
                <div>
                    <input class="inputLable" type="text" name="password" placeholder="New Password" required>
                    <input class="inputLable" type="hidden" name="username2" value="<%= username %>">
                </div>

                <div>
                    <input class="inputLable" type="password" name="Cpassword"  placeholder="Comfirm Password" required>
                </div>

                <%
                    String errorT6 = (String) request.getAttribute("errorT6");
                    if (errorT6 != null){

                %>

                <p class="PrintError"> <%=errorT6%> </p>
                <%

                    }
                %>
                <button type="submit" class="loginBtn">Save</button>
            </form>
        </div>
        <%
                // Optional: reset session attribute after displaying new password form
                session.removeAttribute("validUser");
            } %>
    </div>
</div>

</body>
</html>
