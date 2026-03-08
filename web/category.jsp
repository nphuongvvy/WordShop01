<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Category"%>

<%

    if (request.getAttribute("list") == null) {
        response.sendRedirect("category");
        return;
    }

    String action = request.getParameter("action");
    if (action == null) {
        action = "";
    }

    List<Category> list = (List<Category>) request.getAttribute("list");
    Category cat = (Category) request.getAttribute("cat");
%>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category Management</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>

    <body>

        <!-- n -->
        <jsp:include page="navbar.jsp"/>

        <div class="container">

            <h2>List Of Categories</h2>

            <!-- FORM ADD -->
            <% if ("add".equals(action)) { %>

            <h3>Add Category</h3>

            <div class="row">
                <div class="col-md-6">
                    <form action="category" method="post">

                        <input type="hidden" name="action" value="add">

                        <div class="form-group">
                            <label>Name:</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Memo:</label>
                            <input type="text" name="memo" class="form-control">
                        </div>

                        <input type="submit" value="Save" class="btn btn-success">
                        <a href="category" class="btn btn-default">Back to list</a>

                    </form>
                </div>
            </div>



            <!-- form edit -->
            <% } else if ("edit".equals(action) && cat != null) {%>

            <h3>Edit Category</h3>

            <div class="row">
                <div class="col-md-6">
                    <form action="category" method="post">

                        <input type="hidden" name="action" value="update">

                        <input type="hidden" name="id" value="<%=cat.getTypeId()%>">

                        <div class="form-group">
                            <label>Name:</label>
                            <input type="text" name="name"
                                   value="<%=cat.getCategoryName()%>" class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label>Memo:</label>
                            <input type="text" name="memo"
                                   value="<%=cat.getMemo()%>" class="form-control">
                        </div>

                        <input type="submit" value="Update" class="btn btn-primary">
                        <a href="category" class="btn btn-default">Back to list</a>

                    </form>
                </div>
            </div>



            <!-- list -->
            <% } else { %>

            <a href="category?action=add" class="btn btn-success">
                <i class="glyphicon glyphicon-plus"></i> Add Category
            </a>

            <br><br>

            <div style="max-height: 400px; overflow-y: auto; border: 1px solid #ddd;">
                <table class="table table-bordered table-hover" style="margin-bottom: 0;">
                    <thead style="position: sticky; top: 0; background-color: #f7f7f7; z-index: 10;">
                        <tr class="info">
                            <th>ID</th>
                            <th>Name</th>
                            <th>Memo</th>
                            <th style="width: 150px;">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            if (list != null && !list.isEmpty()) {
                                for (Category c : list) {
                        %>
                        <tr>
                            <td><%=c.getTypeId()%></td>
                            <td><%=c.getCategoryName()%></td>
                            <td><%=c.getMemo()%></td>
                            <td>
                                <a href="category?action=edit&id=<%=c.getTypeId()%>"
                                   class="btn btn-warning btn-sm">Edit</a>
                                <a href="category?action=delete&id=<%=c.getTypeId()%>"
                                   class="btn btn-danger btn-sm"
                                   onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                        <%      }
                        } else {
                        %>
                        <tr><td colspan="4" class="text-center">No categories found.</td></tr>
                        <%  } %>
                    </tbody>
                </table>
            </div>
            <% }%>

        </div>

    </body>
</html>