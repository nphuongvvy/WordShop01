package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import model.Account;
import model.dao.AccountDAO;
import utilities.ConnectDB;

@WebServlet("/account")
public class AccountServlet extends HttpServlet {

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
            AccountDAO dao = new AccountDAO(db);
            String action = request.getParameter("action");
            if (action == null) {
                action = "list";
            }

            if ("edit".equals(action)) {
                String id = request.getParameter("id");
                Account acc = dao.getObjectById(id);
                request.setAttribute("acc", acc);
            } else if ("delete".equals(action)) {
                String id = request.getParameter("id");
                dao.deleteRec(new Account(id));
                response.sendRedirect("account");
                return;
            }

            request.setAttribute("list", dao.listAll());
            request.getRequestDispatcher("account.jsp").forward(request, response);
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
            AccountDAO dao = new AccountDAO(db);
            String account = request.getParameter("account");
            String pass = request.getParameter("pass");
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String phone = request.getParameter("phone");
            String birthdayStr = request.getParameter("birthday");
            java.sql.Date birthday = (birthdayStr != null && !birthdayStr.isEmpty())
                    ? java.sql.Date.valueOf(birthdayStr)
                    : null;
            boolean gender = "1".equals(request.getParameter("gender"));
            int roleInSystem = Integer.parseInt(request.getParameter("role"));
            boolean isUse = "1".equals(request.getParameter("isActive"));

            Account acc = new Account(account, pass, lastName, firstName, birthday, gender, phone, isUse, roleInSystem);
            if ("add".equals(action)) {
                dao.insertRec(acc);
            } else if ("update".equals(action)) {
                dao.updateRec(acc);
            }

            response.sendRedirect("account");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("account");
        }
    }
}
