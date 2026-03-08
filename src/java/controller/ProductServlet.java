package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.Category;
import model.Product;
import model.dao.CategoryDAO;
import model.dao.ProductDAO;
import utilities.ConnectDB;

@WebServlet(name = "ProductServlet", urlPatterns = { "/products" })
public class ProductServlet extends HttpServlet {

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
            ProductDAO dao = new ProductDAO(db);
            CategoryDAO cDao = new CategoryDAO(db);
            String action = request.getParameter("action");
            if (action == null)
                action = "list";

            if (action.equals("edit")) {
                String id = request.getParameter("id");
                Product p = dao.getObjectById(id);
                request.setAttribute("p", p);
            } else if (action.equals("delete")) {
                String id = request.getParameter("id");
                dao.deleteRec(new Product(id));
                response.sendRedirect("products");
                return;
            }

            request.setAttribute("categories", cDao.listAll());
            request.setAttribute("list", dao.listAll());

            // List images from sanPham directory
            String imagePath = request.getServletContext().getRealPath("/images/sanPham");
            java.io.File dir = new java.io.File(imagePath);
            String[] imageList = dir.list();
            if (imageList != null) {
                request.setAttribute("imageList", imageList);
            }

            request.getRequestDispatcher("products.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        try {
            ConnectDB db = getDB(request);
            ProductDAO dao = new ProductDAO(db);
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");
            String productImage = request.getParameter("productImage");
            String brief = request.getParameter("brief");
            String unit = request.getParameter("unit");
            int price = Integer.parseInt(request.getParameter("price"));
            int discount = Integer.parseInt(request.getParameter("discount"));
            int typeId = Integer.parseInt(request.getParameter("typeId"));

            Account currentUser = (Account) request.getSession().getAttribute("user");
            if (currentUser == null)
                currentUser = new Account("admin");

            Product p = new Product(productId, productName, productImage, brief,
                    new java.sql.Date(System.currentTimeMillis()), new Category(typeId), currentUser, unit, price,
                    discount);

            if ("add".equals(action))
                dao.insertRec(p);
            else if ("update".equals(action))
                dao.updateRec(p);

            response.sendRedirect("products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("products");
        }
    }
}
