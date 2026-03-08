<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Account"%>
<%
    if (request.getAttribute("list") == null && request.getParameter("action") == null) {
        response.sendRedirect("account");
        return;
    }
    String action = request.getParameter("action");
    if (action == null) {
        action = "list";
    }
    List<Account> list = (List<Account>) request.getAttribute("list");
    Account acc = (Account) request.getAttribute("acc");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account Management</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>

        <jsp:include page="navbar.jsp"/>

        <div class="container">
            <h2>Account Management</h2>

            <% if ("add".equals(action) || ("edit".equals(action) && acc != null)) {%>
            <h3><%= "add".equals(action) ? "Create New Account" : "Edit Account: " + acc.getAccount()%></h3>
            <hr>
            <div class="row">
                <div class="col-md-6">
                    <form action="account" method="post">
                        <input type="hidden" name="action" value="<%= "add".equals(action) ? "add" : "update"%>">
                        <div class="form-group">
                            <label>Account:</label>
                            <input type="text" name="account" class="form-control" value="<%= (acc != null) ? acc.getAccount() : ""%>" <%= (acc != null) ? "readonly" : "required"%>>
                        </div>
                        <div class="form-group">
                            <label>Password:</label>
                            <input type="password" name="pass" class="form-control" value="<%= (acc != null) ? acc.getPass() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label>First Name:</label>
                            <input type="text" name="firstName" class="form-control" value="<%= (acc != null) ? acc.getFirstName() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label>Last Name:</label>
                            <input type="text" name="lastName" class="form-control" value="<%= (acc != null) ? acc.getLastName() : ""%>" required>
                        </div>
                        <div class="form-group">
                            <label>Phone:</label>
                            <input type="text" name="phone" class="form-control" value="<%= (acc != null) ? acc.getPhone() : ""%>">
                        </div>
                        <div class="form-group">
                            <label>Birthday:</label>
                            <input type="date" name="birthday" class="form-control" value="<%= (acc != null) ? acc.getBirthday() : ""%>">
                        </div>
                        <div class="form-group">
                            <label>Gender:</label>
                            <select name="gender" class="form-control">
                                <option value="1" <%= (acc != null && acc.isGender()) ? "selected" : ""%>>Male</option>
                                <option value="0" <%= (acc != null && !acc.isGender()) ? "selected" : ""%>>Female</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label>Role (Numeric):</label>
                            <input type="number" name="role" class="form-control" value="<%= (acc != null) ? acc.getRoleInSystem() : "1"%>">
                        </div>
                        <div class="form-group">
                            <label>Active:</label>
                            <select name="isActive" class="form-control">
                                <option value="1" <%= (acc != null && acc.isIsUse()) ? "selected" : ""%>>Yes</option>
                                <option value="0" <%= (acc != null && !acc.isIsUse()) ? "selected" : ""%>>No</option>
                            </select>
                        </div>
                        <input type="submit" value="<%= "add".equals(action) ? "Create" : "Update"%>" class="btn btn-primary">
                        <a href="account" class="btn btn-default">Back to list</a>
                    </form>
                </div>
            </div>

            <% } else { %>
            <a href="account?action=add" class="btn btn-success">
                <i class="glyphicon glyphicon-plus"></i> Create New Account
            </a>
            <br><br>

            <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd; border-top: none;">
                <table class="table table-bordered table-hover" style="margin-bottom: 0;">
                    <thead style="position: sticky; top: 0; background-color: #f7f7f7; z-index: 10;">
                        <tr class="info">
                            <th>Account</th>
                            <th>Full Name</th>
                            <th>Birthday</th>
                            <th>Gender</th>
                            <th>Phone</th>
                            <th>Role</th>
                            <th>Active</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (list != null && !list.isEmpty()) {
                                for (Account a : list) {
                        %>
                        <tr>
                            <td><%=a.getAccount()%></td>
                            <td><%=a.getFirstName() + " " + a.getLastName()%></td>
                            <td><%=a.getBirthday() != null ? a.getBirthday() : "N/A"%></td>
                            <td><%=a.isGender() ? "Male" : "Female"%></td>
                            <td><%=a.getPhone()%></td>
                            <td><%=a.getRoleInSystem()%></td>
                            <td><%=a.isIsUse() ? "Yes" : "No"%></td>
                            <td>
                                <a href="account?action=edit&id=<%=a.getAccount()%>" 
                                   class="btn btn-warning btn-sm">Edit</a>
                                <a href="account?action=delete&id=<%=a.getAccount()%>" 
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                        <%      }
                        } else { %>
                        <tr><td colspan="8" class="text-center">No accounts found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% }%>

        </div>
    </body>
</html>