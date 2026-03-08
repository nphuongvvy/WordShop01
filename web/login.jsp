<!DOCTYPE html>
<html>
    <head>

        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

    </head>

    <body>

        <jsp:include page="navbar.jsp"/>


        <div class="container">

            <h2>Login</h2>

            <% if (request.getAttribute("error") != null) {%>
            <div class="alert alert-danger">
                <%= request.getAttribute("error")%>
            </div>
            <% }%>

            <form action="login" method="post">

                Username
                <input type="text" name="username" class="form-control">

                Password
                <input type="password" name="password" class="form-control">

                <br>

                <input type="submit" value="Login" class="btn btn-primary">

            </form>

        </div>


    </body>
</html>