<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - BOUTIQUE.</title>
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 3.4.1 (Existing) -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
    <style>
        :root {
            --primary: #2d3436;
            --accent: #00b894;
            --bg-body: #f8fafc;
            --card-bg: rgba(255, 255, 255, 0.95);
            --text-main: #2d3436;
            --text-muted: #636e72;
            --border-soft: #edf2f7;
            --shadow-lg: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-body);
            color: var(--text-main);
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* --- Full Page Layout --- */
        .login-wrapper {
            flex-grow: 1;
            display: flex;
            height: 100%;
        }

        /* Left side: Lifestyle Image */
        .login-side-image {
            width: 55%;
            background: linear-gradient(rgba(0,0,0,0.1), rgba(0,0,0,0.3)), 
                        url('https://images.unsplash.com/photo-1490481651871-ab68de25d43d?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            position: relative;
            display: none; /* Hidden on mobile */
        }

        .image-overlay-text {
            position: absolute;
            bottom: 60px;
            left: 60px;
            color: white;
            max-width: 400px;
        }

        .image-overlay-text h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 4.5rem;
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 20px;
            letter-spacing: -2px;
        }

        /* Right side: Login Form */
        .login-side-form {
            width: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px;
            background: white;
        }

        @media (min-width: 992px) {
            .login-side-image { display: block; }
            .login-side-form { width: 45%; }
        }

        /* --- Login Card --- */
        .login-card {
            width: 100%;
            max-width: 420px;
            animation: fadeIn 0.8s ease;
        }

        .brand-logo {
            font-family: 'Montserrat', sans-serif;
            font-size: 28px;
            font-weight: 700;
            letter-spacing: -1px;
            color: var(--primary);
            margin-bottom: 40px;
            display: block;
            text-decoration: none !important;
        }

        .brand-logo span { color: var(--accent); }

        .login-title {
            font-family: 'Montserrat', sans-serif;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: -0.5px;
        }

        .login-subtitle {
            color: var(--text-muted);
            font-size: 15px;
            margin-bottom: 40px;
        }

        /* --- Form Elements --- */
        .form-group-premium {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group-premium label {
            font-size: 12px;
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 0.5px;
            color: var(--text-muted);
            margin-bottom: 8px;
            display: block;
        }

        .input-premium {
            width: 100%;
            height: 55px;
            padding: 15px 20px;
            border-radius: 12px;
            border: 1px solid var(--border-soft);
            background: #fcfdfe;
            font-family: 'Inter', sans-serif;
            font-size: 15px;
            transition: all 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
            outline: none !important;
        }

        .input-premium:focus {
            border-color: var(--accent);
            background: white;
            box-shadow: 0 0 0 4px rgba(0, 184, 148, 0.1);
            transform: translateY(-1px);
        }

        .btn-login-premium {
            width: 100%;
            height: 55px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-family: 'Montserrat', sans-serif;
            font-weight: 700;
            font-size: 16px;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-top: 15px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-login-premium:hover {
            background: #000;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.15);
        }

        /* --- Alert --- */
        .alert-modern {
            background: #fff5f5;
            border: 0;
            border-left: 4px solid #ff7675;
            color: #d63031;
            border-radius: 8px;
            padding: 15px 20px;
            font-weight: 500;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
        }

        .alert-modern i { margin-right: 12px; font-size: 18px; }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

    </style>
</head>
<body>

    <jsp:include page="navbar.jsp"/>

    <div class="login-wrapper">
        <!-- Decoration side -->
        <div class="login-side-image">
            <div class="image-overlay-text">
                <h1>Crafting Timeless Elegance<span style="color:var(--accent)">.</span></h1>
                <p style="opacity: 0.8; font-weight: 300;">Step into our world of curated excellence and refined design.</p>
            </div>
        </div>

        <!-- Form side -->
        <div class="login-side-form">
            <div class="login-card">
                <a href="home" class="brand-logo">BOUTIQUE<span>.</span></a>
                
                <h2 class="login-title">Welcome Back</h2>
                <p class="login-subtitle">Please enter your credentials to access your account.</p>

                <% if (request.getAttribute("error") != null) {%>
                    <div class="alert-modern">
                        <i class="glyphicon glyphicon-exclamation-sign"></i>
                        <%= request.getAttribute("error")%>
                    </div>
                <% }%>

                <form action="login" method="post">
                    <div class="form-group-premium">
                        <label>Username</label>
                        <input type="text" name="username" class="input-premium" placeholder="e.g. boutique_user" required>
                    </div>

                    <div class="form-group-premium" style="margin-bottom: 10px;">
                        <label>Password</label>
                        <input type="password" name="password" class="input-premium" placeholder="••••••••" required>
                    </div>

                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 35px;">
                        <label style="display: flex; align-items: center; font-weight: 400; color: var(--text-muted); font-size: 13px; cursor: pointer;">
                            <input type="checkbox" style="margin-right: 8px;"> Remember me
                        </label>
                        <a href="#" style="color: var(--accent); font-size: 13px; font-weight: 600; text-decoration: none;">Forgot password?</a>
                    </div>

                    <button type="submit" class="btn-login-premium">SIGN IN</button>
                    
                    <p style="text-align: center; margin-top: 40px; color: var(--text-muted); font-size: 14px;">
                        Don't have an account? <a href="register.jsp" style="color: var(--primary); font-weight: 700; text-decoration: none;">Create One</a>
                    </p>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap/jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

</body>
</html>