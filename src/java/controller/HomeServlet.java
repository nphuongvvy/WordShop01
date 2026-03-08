package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import utilities.ConnectDB;

@WebServlet(name = "HomeServlet", urlPatterns = { "/home" })
public class HomeServlet extends HttpServlet {

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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int totalProducts = 0;
        int totalCategories = 0;
        int totalAccounts = 0;
        try (Connection con = getDB(request).getConnection()) {
            try (Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM products")) {
                if (rs.next()) {
                    totalProducts = rs.getInt(1);
                }
            }
            try (Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM categories")) {
                if (rs.next()) {
                    totalCategories = rs.getInt(1);
                }
            }
            try (Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM accounts")) {
                if (rs.next()) {
                    totalAccounts = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("dbError", e.getMessage());
        }
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalAccounts", totalAccounts);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }
}
