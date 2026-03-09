<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%
    Account userLoggedIn = (Account) session.getAttribute("user");
%>

<nav class="navbar navbar-default navbar-fixed-top" style="background: rgba(255,255,255,0.9); backdrop-filter: blur(10px); border-bottom: 1px solid #f1f1f1; padding: 10px 0; height: auto;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#main-nav" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="home" style="color: #2d3436; font-size: 24px; font-weight: 700; letter-spacing: -1px;">
                BOUTIQUE<span style="color: #00b894;">.</span>
            </a>
        </div>

        <div class="collapse navbar-collapse" id="main-nav">
            <ul class="nav navbar-nav" style="margin-left: 30px;">
                <li><a href="home" style="font-weight: 500; color: #636e72;">Discover</a></li>
                <li><a href="products" style="font-weight: 500; color: #636e72;">Collections</a></li>
                <li><a href="category" style="font-weight: 500; color: #636e72;">Categories</a></li>
            </ul>

            <!-- Minimal Search -->
            <form class="navbar-form navbar-left" action="products" method="get" style="margin-top: 15px; margin-left: 40px;">
                <div class="input-group" style="width: 280px;">
                    <input type="text" name="txtSearch" class="form-control" placeholder="Search treasures..." 
                           style="border-radius: 50px 0 0 50px; border: 1px solid #edf2f7; box-shadow: none; padding-left: 20px;"
                           value="<%= request.getParameter("txtSearch") != null ? request.getParameter("txtSearch") : "" %>">
                    <div class="input-group-btn">
                        <button class="btn btn-default" type="submit" style="border-radius: 0 50px 50px 0; border: 1px solid #edf2f7; border-left: none; background: #fff; color: #00b894;">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </div>
                </div>
            </form>

            <ul class="nav navbar-nav navbar-right">
                <% if (userLoggedIn != null) { %>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="collapse" data-target="#user-menu" style="font-weight: 600; color: #2d3436;">
                            <i class="glyphicon glyphicon-user" style="margin-right: 5px;"></i> <%= userLoggedIn.getFirstName() %> <span class="caret"></span>
                        </a>
                        <ul id="user-menu" class="nav navbar-nav visible-xs" style="background: transparent; padding-left: 20px;">
                             <li><a href="account">My Account</a></li>
                             <li><a href="logout">Sign Out</a></li>
                        </ul>
                        <!-- Desktop Dropdown simulation with bootstrap classes if needed, or just keep it simple for now -->
                    </li>
                    <li class="hidden-xs"><a href="logout" style="color: #ff7675; font-weight: 600;">Sign Out</a></li>
                <% } else { %>
                    <li>
                        <a href="login.jsp" style="font-weight: 600; color: #2d3436;">
                            <i class="glyphicon glyphicon-log-in"></i> Sign In
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<div style="height: 80px;"></div> <!-- Spacer for fixed-top navbar -->