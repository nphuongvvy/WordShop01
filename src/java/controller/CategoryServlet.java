package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.Category;
import model.dao.CategoryDAO;
import utilities.ConnectDB;

@WebServlet(name = "CategoryServlet", urlPatterns = { "/category" })
public class CategoryServlet extends HttpServlet {

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
        try {
            ConnectDB db = getDB(request);
            CategoryDAO dao = new CategoryDAO(db);
            String action = request.getParameter("action");
            if (action == null)
                action = "list";

            if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                Category c = dao.getObjectById(id + "");
                request.setAttribute("cat", c);
            } else if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.deleteRec(new Category(id));
                response.sendRedirect("category");
                return;
            } else {
                List<Category> list = dao.listAll();
                request.setAttribute("list", list);
            }
            request.getRequestDispatcher("/category.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/plain");
            response.getWriter().println("Servlet Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ConnectDB db = getDB(request);
            CategoryDAO dao = new CategoryDAO(db);
            String action = request.getParameter("action");
            if (action.equals("add")) {
                String name = request.getParameter("name");
                String memo = request.getParameter("memo");
                dao.insertRec(new Category(0, name, memo));
            } else if (action.equals("update")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String memo = request.getParameter("memo");
                dao.updateRec(new Category(id, name, memo));
            }
            response.sendRedirect("category");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
