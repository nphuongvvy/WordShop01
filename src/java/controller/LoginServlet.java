package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import model.Account;
import model.dao.AccountDAO;
import utilities.ConnectDB;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private ConnectDB getDB(HttpServletRequest request) {
        ServletContext sc = request.getServletContext();
        return new ConnectDB(
                sc.getInitParameter("hostAddress"),
                sc.getInitParameter("instance"),
                sc.getInitParameter("dbName"),
                sc.getInitParameter("dbPort"),
                sc.getInitParameter("userName"),
                sc.getInitParameter("userPass"));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        try {
            ConnectDB db = getDB(request);
            AccountDAO dao = new AccountDAO(db);
            Account acc = dao.login(user, pass);
            if (acc != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", acc);
                response.sendRedirect("home");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
