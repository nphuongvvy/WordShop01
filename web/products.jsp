<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%@page import="model.Account"%>
<%
    String action = request.getParameter("action");
    if (action == null) action = "list";

    List<Product> list = (List<Product>) request.getAttribute("list");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String searchTerm = (String) request.getAttribute("searchTerm");
    Integer selectedType = (Integer) request.getAttribute("selectedType");
    Product p = (Product) request.getAttribute("p");
    
    Account user = (Account) session.getAttribute("user");
    boolean isAdmin = (user != null && user.getRoleInSystem() == 1);
    boolean isManageMode = "manage".equals(request.getParameter("mode"));
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Premium Collection - Explore Our Products</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 3.4.1 (Existing) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <style>
        :root {
            --primary: #2d3436;
            --accent: #00b894;
            --accent-soft: rgba(0, 184, 148, 0.1);
            --bg-body: #f8fafc;
            --card-bg: #ffffff;
            --text-main: #2d3436;
            --text-muted: #636e72;
            --border-soft: #edf2f7;
            --shadow-sm: 0 2px 4px rgba(0,0,0,0.02);
            --shadow-md: 0 10px 15px -3px rgba(0,0,0,0.05);
            --shadow-lg: 0 20px 25px -5px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }

        h1, h2, h3, h4, .navbar-brand {
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        /* --- Header Section --- */
        .page-header-minimal {
            background: #fff;
            padding: 60px 0;
            margin-bottom: 40px;
            border-bottom: 1px solid var(--border-soft);
        }

        .breadcrumb-minimal {
            background: transparent;
            padding: 0;
            margin-bottom: 15px;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .breadcrumb-minimal a { color: var(--accent); font-weight: 600; text-decoration: none; }
        .breadcrumb-minimal .active { color: var(--text-muted); }

        /* --- Sidebar & Filters --- */
        .sidebar-container {
            position: sticky;
            top: 20px;
        }

        .filter-group {
            background: #fff;
            padding: 24px;
            border-radius: 16px;
            box-shadow: var(--shadow-sm);
            margin-bottom: 24px;
            border: 1px solid var(--border-soft);
        }

        .filter-title {
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            color: var(--text-main);
        }

        .category-nav { list-style: none; padding: 0; }
        .category-nav li { margin-bottom: 8px; }
        .category-nav a {
            padding: 10px 15px;
            display: block;
            border-radius: 10px;
            color: var(--text-muted);
            text-decoration: none !important;
            transition: all 0.3s;
            font-weight: 500;
        }

        .category-nav li.active a, .category-nav a:hover {
            background: var(--accent-soft);
            color: var(--accent);
            transform: translateX(5px);
        }

        /* --- Product Cards --- */
        .product-card-premium {
            background: var(--card-bg);
            border-radius: 20px;
            border: 1px solid var(--border-soft);
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            position: relative;
            overflow: hidden;
            height: 100%;
            display: flex;
            flex-direction: column;
            margin-bottom: 30px;
            box-shadow: var(--shadow-md);
        }

        .product-card-premium:hover {
            transform: translateY(-10px);
            box-shadow: var(--shadow-lg);
            border-color: var(--accent);
        }

        .img-container {
            position: relative;
            padding-top: 100%;
            background: #fdfdfd;
            overflow: hidden;
        }

        .product-image {
            position: absolute;
            top: 50%;
            left: 50%;
            width: 85%;
            height: 85%;
            object-fit: contain;
            transform: translate(-50%, -50%);
            transition: transform 0.6s ease;
        }

        .product-card-premium:hover .product-image {
            transform: translate(-50%, -50%) scale(1.1);
        }

        .card-body-premium {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .product-cat {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .product-title {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 12px;
            line-height: 1.4;
            color: var(--text-main);
            height: 2.8em;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .price-tag {
            font-size: 18px;
            font-weight: 700;
            color: var(--primary);
            margin-top: auto;
        }

        .price-old {
            font-size: 14px;
            text-decoration: line-through;
            color: var(--text-muted);
            margin-right: 8px;
            font-weight: 400;
        }

        .badge-discount {
            position: absolute;
            top: 15px;
            right: 15px;
            background: #ff7675;
            color: white;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 700;
            z-index: 5;
            box-shadow: 0 4px 10px rgba(255, 118, 117, 0.3);
        }

        .btn-view-details {
            position: absolute;
            bottom: -50px;
            left: 0;
            width: 100%;
            background: var(--accent);
            color: white;
            padding: 12px;
            text-align: center;
            text-transform: uppercase;
            font-weight: 700;
            font-size: 12px;
            letter-spacing: 1px;
            transition: all 0.3s;
            opacity: 0;
            text-decoration: none !important;
        }

        .product-card-premium:hover .btn-view-details {
            bottom: 0;
            opacity: 1;
        }

        /* --- Management View --- */
        .admin-panel {
            background: #fff;
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow-md);
            border: 1px solid var(--border-soft);
        }

        .table-premium { border: none !important; }
        .table-premium th { border: none !important; background: var(--bg-body); padding: 15px !important; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .table-premium td { vertical-align: middle !important; padding: 20px 15px !important; border-bottom: 1px solid #f1f1f1 !important; }

        .btn-modern {
            border-radius: 12px;
            padding: 10px 20px;
            font-weight: 600;
            transition: all 0.3s;
            border: none;
        }

        .btn-modern-primary { background: var(--accent); color: white; }
        .btn-modern-primary:hover { background: #00a383; transform: translateY(-2px); box-shadow: 0 4px 12px rgba(0, 184, 148, 0.3); }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in { animation: fadeIn 0.6s ease forwards; }

    </style>
</head>
<body>

    <jsp:include page="navbar.jsp"/>

    <% if (!isManageMode && !"add".equals(action) && !"edit".equals(action)) { %>
    <!-- Hero/Page Header -->
    <header class="page-header-minimal">
        <div class="container text-center">
            <ul class="breadcrumb-minimal">
                <li><a href="home">Home</a></li>
                <li class="active">Collection</li>
            </ul>
            <h1 style="font-size: 4rem; margin-bottom: 20px;">
                <%= (searchTerm != null) ? "Search: " + searchTerm : "Our Collection" %>
            </h1>
            <p class="text-muted" style="max-width: 600px; margin: 0 auto;">
                Explore our curated selection of high-quality products designed for your modern lifestyle.
            </p>
        </div>
    </header>
    <% } %>

    <div class="container" style="margin-top: 20px;">
        <div class="row">

            <!-- Sidebar -->
            <div class="col-md-3">
                <div class="sidebar-container">
                    <div class="filter-group">
                        <h4 class="filter-title">
                            <i class="glyphicon glyphicon-th-large" style="margin-right: 10px;"></i>
                            Categories
                        </h4>
                        <ul class="category-nav">
                            <li class="<%= (selectedType == null) ? "active" : "" %>">
                                <a href="products">All Masterpieces</a>
                            </li>
                            <% if (categories != null) {
                                for (Category c : categories) { %>
                                <li class="<%= (selectedType != null && selectedType == c.getTypeId()) ? "active" : "" %>">
                                    <a href="products?type=<%= c.getTypeId() %>"><%= c.getCategoryName() %></a>
                                </li>
                            <% } } %>
                        </ul>
                    </div>

                    <% if (isAdmin) { %>
                    <div class="filter-group" style="padding: 15px;">
                        <a href="products?mode=manage" class="btn btn-modern btn-block" style="background: #2d3436; color: white;">
                            <i class="glyphicon glyphicon-lock"></i> Administration Panel
                        </a>
                    </div>
                    <% } %>
                </div>
            </div>

            <!-- Main Content -->
            <div class="col-md-9">

                <% if (!isManageMode && !"add".equals(action) && !"edit".equals(action)) { %>
                    <!-- SORT BAR -->
                    <div style="display: flex; justify-content: flex-end; align-items: center; margin-bottom: 30px;">
                        <span style="font-size: 13px; color: var(--text-muted); margin-right: 15px;">Sort by:</span>
                        <select class="form-control" style="width: 180px; border-radius: 10px; border: 1px solid var(--border-soft); height: 40px; box-shadow: none;">
                            <option>Default Sorting</option>
                            <option>Price: Low to High</option>
                            <option>Price: High to Low</option>
                            <option>Newest Arrivals</option>
                        </select>
                    </div>

                    <!-- PRODUCT LIST (GRID) -->
                    <div class="row">
                        <% if (list != null && !list.isEmpty()) {
                            int delay = 0;
                            for (Product prod : list) { %>
                            <div class="col-sm-6 col-md-4 fade-in" style="animation-delay: <%= (delay++ * 0.1) %>s;">
                                <div class="product-card-premium">
                                    <% if (prod.getDiscount() > 0) { %>
                                        <div class="badge-discount">-<%= prod.getDiscount() %>%</div>
                                    <% } %>
                                    
                                    <div class="img-container">
                                        <img src="<%= (prod.getProductImage() != null && !prod.getProductImage().isEmpty()) ? request.getContextPath() + prod.getProductImage() : "https://via.placeholder.com/300" %>" 
                                             alt="<%= prod.getProductName() %>" class="product-image">
                                    </div>

                                    <div class="card-body-premium">
                                        <div class="product-cat">
                                            <%= (prod.getType() != null) ? prod.getType().getCategoryName() : "Essential" %>
                                        </div>
                                        <h3 class="product-title"><%= prod.getProductName() %></h3>
                                        <div class="price-row">
                                            <% if (prod.getDiscount() > 0) { %>
                                                <span class="price-old">₫<%= String.format("%,d", prod.getPrice()) %></span>
                                            <% } %>
                                            <span class="price-tag">₫<%= String.format("%,d", (int)prod.getFinalPrice()) %></span>
                                        </div>
                                    </div>

                                    <a href="products?action=detail&id=<%= prod.getProductId() %>" class="btn-view-details">
                                        Quick View <i class="glyphicon glyphicon-arrow-right" style="font-size: 10px; margin-left: 5px;"></i>
                                    </a>
                                </div>
                            </div>
                        <% } } else { %>
                            <div class="col-xs-12 text-center" style="padding: 100px 0;">
                                <i class="glyphicon glyphicon-inbox" style="font-size: 6rem; color: #dfe6e9; margin-bottom: 20px; display: block;"></i>
                                <h3 style="color: var(--text-muted);">No gems found here yet.</h3>
                                <p>Try adjusting your search or filters.</p>
                            </div>
                        <% } %>
                    </div>

                <% } else if (isManageMode) { %>
                    <!-- ADMIN PANELS -->
                    <div class="admin-panel fade-in">
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                            <h2 style="margin:0;">Inventory Management</h2>
                            <a href="products?action=add" class="btn btn-modern btn-modern-primary">+ Add New Item</a>
                        </div>
                        
                        <div class="table-responsive">
                            <table class="table table-premium">
                                <thead>
                                    <tr>
                                        <th>Visual</th>
                                        <th>Product Identity</th>
                                        <th>Category</th>
                                        <th>Valuation</th>
                                        <th class="text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% if (list != null) {
                                        for (Product prod : list) { %>
                                        <tr>
                                            <td style="width: 100px;">
                                                <div style="width: 60px; height: 60px; background: #f9f9f9; border-radius: 12px; overflow: hidden; display: flex; align-items: center; justify-content: center;">
                                                    <img src="<%= request.getContextPath() + prod.getProductImage() %>" style="max-width: 85%; max-height: 85%; object-fit: contain;">
                                                </div>
                                            </td>
                                            <td>
                                                <div style="font-size: 12px; font-weight: 700; color: var(--accent);"><%= prod.getProductId() %></div>
                                                <div style="font-weight: 600; color: var(--text-main);"><%= prod.getProductName() %></div>
                                            </td>
                                            <td><span class="label" style="background: var(--bg-body); color: var(--text-muted); font-weight: 600; padding: 5px 10px; border-radius: 5px;"><%= (prod.getType() != null) ? prod.getType().getCategoryName() : "N/A" %></span></td>
                                            <td><strong style="color: var(--primary);">₫<%= String.format("%,d", prod.getPrice()) %></strong></td>
                                            <td class="text-right">
                                                <a href="products?action=edit&id=<%= prod.getProductId() %>" class="btn btn-xs" style="color: var(--text-muted); margin-right: 10px;"><i class="glyphicon glyphicon-pencil"></i></a>
                                                <a href="products?action=delete&id=<%= prod.getProductId() %>" class="btn btn-xs" style="color: #ff7675;" onclick="return confirm('Archive this masterpiece?')"><i class="glyphicon glyphicon-trash"></i></a>
                                            </td>
                                        </tr>
                                    <% } } %>
                                </tbody>
                            </table>
                        </div>
                        <div style="margin-top: 30px;">
                            <a href="products" class="btn btn-link" style="color: var(--text-muted); text-decoration: none;"><i class="glyphicon glyphicon-menu-left"></i> Return to Shop</a>
                        </div>
                    </div>

                <% } else if ("add".equals(action) || ("edit".equals(action) && p != null)) { %>
                    <div class="admin-panel fade-in">
                        <h2 style="margin-bottom: 30px;"><%= "edit".equals(action) ? "Refine Product" : "Curate New Product" %></h2>
                        <form action="products" method="post" class="row">
                            <input type="hidden" name="action" value="<%= "edit".equals(action) ? "update" : "add" %>">
                            
                            <div class="col-md-5">
                                <div style="background: var(--bg-body); border: 2px dashed #d1d8e0; border-radius: 24px; padding: 40px; text-align: center; height: 100%; min-height: 400px; display: flex; flex-direction: column; justify-content: center;">
                                    <img id="preview" src="<%= (p != null && p.getProductImage() != null) ? request.getContextPath() + p.getProductImage() : "" %>" 
                                         style="max-width: 100%; max-height: 250px; object-fit: contain; margin: 0 auto 30px; border-radius: 12px; <%= (p == null || p.getProductImage() == null) ? "display:none;" : "" %>">
                                    
                                    <h4 style="font-weight: 600; margin-bottom: 20px;">Product Visual</h4>
                                    <input type="text" name="productImage" id="imgUrl" class="form-control" 
                                           style="border-radius: 12px; height: 45px; text-align: center;"
                                           placeholder="Image path (e.g., /images/xxx.jpg)" 
                                           value="<%= p != null ? p.getProductImage() : "" %>"
                                           oninput="document.getElementById('preview').src='<%= request.getContextPath() %>' + this.value; document.getElementById('preview').style.display='block';">
                                </div>
                            </div>

                            <div class="col-md-7">
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Unique Identity (ID)</label>
                                        <input type="text" name="productId" class="form-control" style="height: 45px; border-radius: 12px;" value="<%= p != null ? p.getProductId() : "" %>" <%= p != null ? "readonly" : "required" %>>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Public Name</label>
                                        <input type="text" name="productName" class="form-control" style="height: 45px; border-radius: 12px;" value="<%= p != null ? p.getProductName() : "" %>" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Category</label>
                                        <select name="typeId" class="form-control" style="height: 45px; border-radius: 12px;">
                                            <% if (categories != null) {
                                                for (Category c : categories) { %>
                                                <option value="<%= c.getTypeId() %>" <%= (p != null && p.getType() != null && p.getType().getTypeId() == c.getTypeId()) ? "selected" : "" %>><%= c.getCategoryName() %></option>
                                            <% } } %>
                                        </select>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Inventory Unit</label>
                                        <input type="text" name="unit" class="form-control" style="height: 45px; border-radius: 12px;" value="<%= p != null ? p.getUnit() : "Piece" %>">
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Retail Price (₫)</label>
                                        <input type="number" name="price" class="form-control" style="height: 45px; border-radius: 12px;" value="<%= p != null ? p.getPrice() : "0" %>" required>
                                    </div>
                                    <div class="form-group col-md-6">
                                        <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Promotion (%)</label>
                                        <input type="number" name="discount" class="form-control" style="height: 45px; border-radius: 12px;" value="<%= p != null ? p.getDiscount() : "0" %>">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label style="font-size: 12px; text-transform: uppercase; color: var(--text-muted);">Product Narratives</label>
                                    <textarea name="brief" class="form-control" rows="4" style="border-radius: 12px;"><%= p != null ? p.getBrief() : "" %></textarea>
                                </div>
                                
                                <div style="margin-top: 40px;">
                                    <button type="submit" class="btn btn-modern btn-modern-primary btn-lg" style="width: 200px;">Publish Item</button>
                                    <a href="products?mode=manage" class="btn btn-link btn-lg" style="color: var(--text-muted);">Discard Changes</a>
                                </div>
                            </div>
                        </form>
                    </div>
                <% } %>

            </div>
        </div>
    </div>

    <!-- Bootstrap/jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>
