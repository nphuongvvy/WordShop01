<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%
    Account currentUser = (Account) session.getAttribute("user");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    Integer totalCategories = (Integer) request.getAttribute("totalCategories");
    Integer totalAccounts = (Integer) request.getAttribute("totalAccounts");
    
    if (totalProducts == null) totalProducts = 0;
    if (totalCategories == null) totalCategories = 0;
    if (totalAccounts == null) totalAccounts = 0;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - Dashboard</title>
    
    <link href="https://fonts.googleapis.com/css2?family=Segoe+UI:wght@400;600&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <style>
        :root {
            
            --soft-red: #FF8A8A;
            --creamy-beige: #F4DEB3;
            --pale-yellow: #F0EAAC;
            --mint-green: #CCE0AC;
            
            --bg-color: #ffffff;
            --text-main: #333333;
            --text-muted: #666666;
            --border-color: #f1f1f1;
            --card-shadow: 0 4px 15px rgba(0, 0, 0, 0.04);
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: #ffffff;
            color: var(--text-main);
            margin-bottom: 50px;
        }

        .dashboard-header {
            background: #ffffff;
            padding: 85px 0 45px;
            color: var(--text-main);
            margin-bottom: 50px;
            position: relative;
        }

        .welcome-msg {
            font-size: 3.4rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -1px;
            color: #333;
        }

        .header-subtext {
            font-size: 1.4rem;
            color: var(--text-muted);
            margin-top: 5px;
        }

        .card-stat {
            background: #fff;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 40px 25px;
            text-align: center;
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            margin-bottom: 30px;
            box-shadow: var(--card-shadow);
        }

        .card-stat:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.06);
        }

        .icon-box {
            width: 75px;
            height: 75px;
            line-height: 75px;
            border-radius: 22px;
            margin: 0 auto 25px;
            font-size: 30px;
            background: #fdfdfd;
            transition: all 0.3s;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
        }

       
        .card-categories { background: #fffcfc; border: 1px solid var(--border-color); }
        .card-products { background: #fafffa; border: 1px solid var(--border-color); }
        .card-users { background: #fffdfa; border: 1px solid var(--border-color); }

        .card-categories .icon-box { color: var(--soft-red); background: #fff5f5; }
        .card-products .icon-box { color: #84a260; background: #f4f8f0; }
        .card-users .icon-box { color: #d1b681; background: #faf8f0; }

        .card-stat:hover .icon-box {
            transform: scale(1.1) rotate(3deg);
            color: white;
        }

        .card-categories:hover .icon-box { background: var(--soft-red); }
        .card-products:hover .icon-box { background: var(--mint-green); }
        .card-users:hover .icon-box { background: var(--creamy-beige); }

        .card-stat .value {
            font-size: 4rem;
            font-weight: 800;
            display: block;
            margin-bottom: 5px;
            color: #333;
        }

        .card-stat .label {
            color: var(--text-muted);
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            font-weight: 700;
        }

        .btn-action {
            border-radius: 12px;
            padding: 12px 20px;
            font-weight: 700;
            text-transform: uppercase;
            font-size: 1.1rem;
            letter-spacing: 1px;
            margin-top: 30px;
            transition: all 0.3s;
            border: none;
            color: white;
        }

        .card-categories .btn-action { background: var(--soft-red); }
        .card-products .btn-action { background: #84a260; }
        .card-users .btn-action { background: #d1b681; }

        .btn-action:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            color: white;
        }

        .shortcut-container {
            background: #fff;
            padding: 45px;
            border-radius: 24px;
            margin-top: 30px;
            border: 1px solid var(--border-color);
            box-shadow: var(--card-shadow);
        }

        .shortcut-title {
            font-weight: 800;
            color: #333;
            margin-bottom: 35px;
            display: flex;
            align-items: center;
            font-size: 2.22rem;
        }

        .shortcut-title i { 
            margin-right: 15px; 
            color: var(--soft-red);
            background: #fff5f5;
            padding: 12px;
            border-radius: 14px;
        }

        .btn-quick {
            border-radius: 14px;
            padding: 16px 32px;
            font-weight: 700;
            margin-right: 15px;
            margin-bottom: 20px;
            border: none;
            transition: all 0.3s;
            color: white;
        }

        .btn-quick:nth-of-type(1) { background: var(--soft-red); }
        .btn-quick:nth-of-type(2) { background: var(--mint-green); color: #555; }
        .btn-quick:nth-of-type(3) { background: var(--creamy-beige); color: #775522; }

        .btn-quick:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.08);
            opacity: 0.95;
        }

        .alert-nature {
            background: #fff;
            border-radius: 16px;
            border: 1px solid #fce7e7;
            color: #e53e3e;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp"/>

    <div class="dashboard-header">
        <div class="container">
            <h1 class="welcome-msg">
                Hello, <%= (currentUser != null) ? currentUser.getFirstName() : "Admin" %>!
            </h1>
            <p class="header-subtext">Welcome back to your Product Management Dashboard.</p>
            
            <% if (request.getAttribute("dbError") != null) { %>
                <div class="alert alert-danger" style="margin-top: 30px; border-radius: 12px; border: none; background: rgba(255,255,255,0.2); color: white;">
                    <i class="glyphicon glyphicon-exclamation-sign"></i>
                    <strong>Connection Alert:</strong> <%= request.getAttribute("dbError") %>
                </div>
            <% } %>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <!-- categories card -->
            <div class="col-md-4">
                <div class="card-stat card-categories">
                    <div class="icon-box"><i class="glyphicon glyphicon-th-list"></i></div>
                    <span class="value"><%= totalCategories %></span>
                    <span class="label">Total Categories</span>
                    <a href="category" class="btn btn-action btn-block">View List</a>
                </div>
            </div>
            
            <!-- products card -->
            <div class="col-md-4">
                <div class="card-stat card-products">
                    <div class="icon-box"><i class="glyphicon glyphicon-shopping-cart"></i></div>
                    <span class="value"><%= totalProducts %></span>
                    <span class="label">Total Products</span>
                    <a href="products" class="btn btn-action btn-block">View Inventory</a>
                </div>
            </div>
            
            <!-- users card -->
            <div class="col-md-4">
                <div class="card-stat card-users">
                    <div class="icon-box"><i class="glyphicon glyphicon-user"></i></div>
                    <span class="value"><%= totalAccounts %></span>
                    <span class="label">Active Users</span>
                    <a href="account" class="btn btn-action btn-block">Manage Team</a>
                </div>
            </div>
        </div>

        <div class="shortcut-container">
            <h3 class="shortcut-title"><i class="glyphicon glyphicon-flash"></i> Quick Utilities</h3>
            <div class="row">
                <div class="col-md-12">
                    <a href="products?action=add" class="btn btn-quick"><i class="glyphicon glyphicon-plus"></i> New Product</a>
                    <a href="category?action=add" class="btn btn-quick"><i class="glyphicon glyphicon-folder-close"></i> Create Category</a>
                    <a href="account?action=add" class="btn btn-quick"><i class="glyphicon glyphicon-plus-sign"></i> Register User</a>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
