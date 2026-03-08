<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%
    Account userLoggedIn = (Account) session.getAttribute("user");
%>

<nav class="navbar navbar-inverse">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="home">Product Management</a>
        </div>

        <ul class="nav navbar-nav">
            <li><a href="home">Home</a></li>
            <li><a href="account">Accounts</a></li>
            <li><a href="category">Categories</a></li>
            <li><a href="products">Products</a></li>
            

        </ul>

        <ul class="nav navbar-nav navbar-right">
            <% if (userLoggedIn != null) { %>
                <li>
                    <a href="#">
                        <i class="glyphicon glyphicon-user"></i> Hello, <%= userLoggedIn.getFirstName() %>
                    </a>
                </li>
                <li>
                    <a href="logout">
                        <i class="glyphicon glyphicon-log-out"></i> Logout
                    </a>
                </li>
            <% } else { %>
                <li>
                    <a href="login.jsp">
                        <i class="glyphicon glyphicon-log-in"></i> Login
                    </a>
                </li>
            <% } %>
        </ul>
    </div>
</nav>

<!-- bootstrap -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>