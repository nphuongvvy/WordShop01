<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Account"%>
<%@page import="model.Product"%>
<%@page import="java.util.List"%>
<%
    Account currentUser = (Account) session.getAttribute("user");
    List<Product> products = (List<Product>) request.getAttribute("products");
    Integer totalProducts = (Integer) request.getAttribute("totalProducts");
    Integer totalCategories = (Integer) request.getAttribute("totalCategories");
    Integer totalAccounts = (Integer) request.getAttribute("totalAccounts");
    
    if (totalProducts == null) totalProducts = 0;
    if (totalCategories == null) totalCategories = 0;
    if (totalAccounts == null) totalAccounts = 0;
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boutique. - Modern Lifestyle Collection</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 3.4.1 (Existing) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <style>
        :root {
            --primary: #2d3436;
            --accent: #00b894;
            --bg-body: #ffffff;
            --text-main: #2d3436;
            --text-muted: #636e72;
            --border-soft: #edf2f7;
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
        }

        /* --- Hero Section --- */
        .hero-section {
            background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.5)), url('https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            height: 90vh;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: white;
            margin-bottom: 80px;
            position: relative;
        }

        .hero-content h1 { font-size: 6rem; text-transform: uppercase; letter-spacing: 5px; margin-bottom: 20px; }
        .hero-content p { font-size: 1.8rem; font-weight: 300; max-width: 600px; margin: 0 auto 40px; }
        .btn-premium {
            padding: 15px 40px;
            background: white;
            color: var(--primary);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            border-radius: 50px;
            text-decoration: none !important;
            transition: all 0.3s;
            display: inline-block;
        }
        .btn-premium:hover { background: var(--accent); color: white; transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.2); }

        /* --- Modern Stats for Admins --- */
        .admin-dashboard-lite { background: white; padding: 40px; border-radius: 20px; box-shadow: var(--shadow-md); margin-bottom: 80px; }
        .stat-item { text-align: center; border-right: 1px solid var(--border-soft); }
        .stat-item:last-child { border-right: none; }
        .stat-value { font-size: 3.5rem; font-weight: 700; color: var(--accent); }
        .stat-label { font-size: 1.2rem; text-transform: uppercase; font-weight: 600; color: var(--text-muted); }

        /* --- Sections --- */
        .section-title-wrap { margin-bottom: 50px; text-align: center; }
        .section-line { width: 50px; height: 3px; background: var(--accent); margin: 20px auto; }

        /* --- Featured Mini Card --- */
        .featured-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px; margin-bottom: 80px; }
        .featured-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            transition: all 0.4s;
            border: 1px solid var(--border-soft);
            text-decoration: none !important;
            color: inherit;
            display: flex;
            align-items: center;
        }
        .featured-card:hover { transform: scale(1.05); box-shadow: var(--shadow-md); }
        .featured-card i { font-size: 2.5rem; color: var(--accent); margin-right: 20px; background: var(--bg-body); padding: 15px; border-radius: 12px; }

        /* Animations */
        @keyframes slideUp { from { opacity: 0; transform: translateY(50px); } to { opacity: 1; transform: translateY(0); } }
        .hero-content { animation: slideUp 1s ease forwards; }

    </style>
</head>
<body>

    <jsp:include page="navbar.jsp"/>

    <!-- Hero Section -->
    <div class="hero-section">
        <div class="hero-content">
            <h4 style="font-weight: 500; letter-spacing: 5px; margin-bottom: 10px;">CURATED LIFESTYLE</h4>
            <h1>BOUTIQUE<span style="color: var(--accent);">.</span></h1>
            <p>Elevate your everyday experience with our hand-picked collection of premium design and craftsmanship.</p>
            <a href="products" class="btn-premium">Explore Collection</a>
        </div>
    </div>

    <div class="container">
        
        <!-- Dashboard Stats (Admin Only) -->
        <% if (currentUser != null && currentUser.getRoleInSystem() == 1) { %>
            <div class="admin-dashboard-lite">
                <div class="row">
                    <div class="col-md-9">
                        <h4 style="margin-bottom: 25px; font-weight: 700; font-size: 1.2rem; text-transform: uppercase; letter-spacing: 1px; color: var(--text-muted)">Warehouse Analytics</h4>
                        <div class="row">
                            <div class="col-xs-4 stat-item">
                                <div class="stat-value"><%= totalProducts %></div>
                                <div class="stat-label">Stock Items</div>
                            </div>
                            <div class="col-xs-4 stat-item">
                                <div class="stat-value"><%= totalCategories %></div>
                                <div class="stat-label">Collections</div>
                            </div>
                            <div class="col-xs-4 stat-item">
                                <div class="stat-value"><%= totalAccounts %></div>
                                <div class="stat-label">Active Users</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 text-right" style="padding-top: 40px; border-left: 1px solid var(--border-soft)">
                        <a href="products?mode=manage" class="btn btn-block btn-modern" style="background: var(--primary); color: white; border-radius: 12px; padding: 15px;">
                             Manage Inventory <i class="glyphicon glyphicon-arrow-right" style="font-size: 10px; margin-left: 10px;"></i>
                        </a>
                    </div>
                </div>
            </div>
        <% } %>

        <!-- Featured Highlights -->
        <div class="section-title-wrap">
            <h2 style="font-size: 3rem;">Why Choose BOUTIQUE.</h2>
            <div class="section-line"></div>
        </div>

        <div class="featured-grid">
            <div class="featured-card">
                <i class="glyphicon glyphicon-certificate"></i>
                <div>
                    <h4 style="margin-bottom: 5px; font-weight: 700;">Premium Quality</h4>
                    <span style="color: var(--text-muted); font-size: 12px;">Only the finest materials used.</span>
                </div>
            </div>
            <div class="featured-card">
                <i class="glyphicon glyphicon-send"></i>
                <div>
                    <h4 style="margin-bottom: 5px; font-weight: 700;">Fast Delivery</h4>
                    <span style="color: var(--text-muted); font-size: 12px;">Worldwide shipping in 24h.</span>
                </div>
            </div>
            <div class="featured-card">
                <i class="glyphicon glyphicon-heart"></i>
                <div>
                    <h4 style="margin-bottom: 5px; font-weight: 700;">Luxury Design</h4>
                    <span style="color: var(--text-muted); font-size: 12px;">Aesthetics meet functionality.</span>
                </div>
            </div>
        </div>

        <!-- Latest Arrivals -->
        <div class="section-title-wrap" style="margin-top: 50px;">
            <h2 style="font-size: 2.5rem;">The Masterpieces</h2>
            <p class="text-muted">A sneak peek of our newest additions</p>
            <div class="section-line"></div>
        </div>

        <!-- Re-use the card styles but slightly tweaked for home or just show more minimal grid -->
        <div class="row">
            <% if (products != null && !products.isEmpty()) { 
                int limit = 0;
                for (Product prod : products) { 
                    if(limit++ >= 3) break; // Only show 3 on home
            %>
                <div class="col-md-4">
                    <div style="background: white; border-radius: 24px; padding: 25px; border: 1px solid var(--border-soft); transition: all 0.3s; margin-bottom: 30px;">
                        <img src="<%= request.getContextPath() + prod.getProductImage() %>" style="width: 100%; height: 250px; object-fit: contain; margin-bottom: 20px;">
                        <span style="color: var(--accent); font-size: 10px; font-weight: 700; text-transform: uppercase;"><%= (prod.getType() != null) ? prod.getType().getCategoryName() : "Collection" %></span>
                        <h4 style="margin: 10px 0; height: 1.4em; overflow: hidden;"><%= prod.getProductName() %></h4>
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <strong style="font-size: 18px; color: var(--primary);">₫<%= String.format("%,d", prod.getPrice()) %></strong>
                            <a href="products?action=detail&id=<%= prod.getProductId() %>" style="color: var(--primary); font-weight: 700; text-decoration: none;">VIEW <i class="glyphicon glyphicon-menu-right" style="font-size: 8px;"></i></a>
                        </div>
                    </div>
                </div>
            <% } } %>
        </div>
        
    </div>

    <!-- Bootstrap/jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>
