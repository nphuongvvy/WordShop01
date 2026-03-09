package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Define public paths
        boolean isPublicPage = path.equals("/") ||
                path.startsWith("/home") ||
                path.startsWith("/login") ||
                path.startsWith("/register") ||
                path.startsWith("/detail") ||
                path.equals("/products") ||
                path.startsWith("/images") ||
                isStaticResource(req);

        // Special check for products management (private)
        if (path.equals("/products") && "manage".equals(req.getParameter("mode"))) {
            isPublicPage = false;
        }

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (isPublicPage || loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    private boolean isStaticResource(HttpServletRequest req) {
        String path = req.getRequestURI().toLowerCase();
        return path.endsWith(".css") || path.endsWith(".js") ||
                path.endsWith(".png") || path.endsWith(".jpg") ||
                path.endsWith(".jpeg") || path.endsWith(".gif") ||
                path.endsWith(".svg");
    }

    @Override
    public void destroy() {
    }
}
