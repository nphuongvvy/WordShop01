<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.Product"%>
<%@page import="model.Category"%>
<%
    String action = request.getParameter("action");
    if (action == null) {
        action = "list";
    }

    List<Product> list = (List<Product>) request.getAttribute("list");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    Product p = (Product) request.getAttribute("p");

    if (list == null && request.getParameter("action") == null) {
        response.sendRedirect("products");
        return;
    }

    String msg = (String) session.getAttribute("msg");
    if (msg != null)
        session.removeAttribute("msg");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Management</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    </head>
    <body>

        <jsp:include page="navbar.jsp"/>

        <div class="container">
            <div style="display: flex; justify-content: space-between; align-items: center;">
                <h2>Product Management</h2>
                <% if (msg != null) {%>
                <div class="alert alert-success" style="padding: 10px; display: inline-block; margin-bottom: 0;">
                    <i class="glyphicon glyphicon-ok"></i> <%= msg%>
                </div>
                <% } %>
            </div>

            <!-- add/ edit -->
            <% if ("add".equals(action) || ("edit".equals(action) && p != null)) {%>
            <h3><%= "edit".equals(action) ? "Edit Product: " + p.getProductId() : "Add New Product"%></h3>
            <hr>
            <form action="products" method="post" class="row">
                <input type="hidden" name="action" value="<%= "edit".equals(action) ? "update" : "add"%>">

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Product ID:</label>
                        <input type="text" name="productId" class="form-control" value="<%= p != null ? p.getProductId() : ""%>" <%= p != null ? "readonly" : "required"%>>
                    </div>
                    <div class="form-group">
                        <label>Product Name:</label>
                        <input type="text" name="productName" class="form-control" value="<%= p != null ? p.getProductName() : ""%>" required>
                    </div>
                    <div class="form-group">
                        <label>Category:</label>
                        <select name="typeId" class="form-control" size="4" style="height: auto !important; overflow-y: auto;">
                            <% if (categories != null) {
                                        for (Category c : categories) {%>
                            <option value="<%= c.getTypeId()%>" <%= (p != null && p.getType() != null && p.getType().getTypeId() == c.getTypeId()) ? "selected" : ""%>><%= c.getCategoryName()%></option>
                            <% }
                                    }%>
                        </select>
                        <small class="text-muted">Scroll to select category</small>
                    </div>
                </div>

                <div class="col-md-6">
                    <div class="form-group">
                        <label>Price:</label>
                        <input type="number" name="price" class="form-control" value="<%= p != null ? p.getPrice() : "0"%>" required>
                    </div>
                    <div class="form-group">
                        <label>Discount (%):</label>
                        <input type="number" name="discount" class="form-control" value="<%= p != null ? p.getDiscount() : "0"%>">
                    </div>
                    <div class="form-group">
                        <label>Unit:</label>
                        <input type="text" name="unit" class="form-control" value="<%= p != null ? p.getUnit() : "piece"%>">
                    </div>
                    <div class="form-group">
                        <label>Brief Description:</label>
                        <textarea name="brief" class="form-control" rows="4" style="resize: vertical;"><%= p != null ? p.getBrief() : ""%></textarea>
                    </div>
                </div>

                <div class="col-md-12">
                    <hr>
                    <button type="submit" class="btn btn-primary"><%= "edit".equals(action) ? "Update Product" : "Save Product"%></button>
                    <a href="products" class="btn btn-default">Cancel</a>
                </div>
            </form>

            <!-- list table -->
            <% } else { %>
            <div style="max-height: 500px; overflow-y: auto; border: 1px solid #ddd;">
                <table class="table table-bordered table-hover" style="margin-bottom: 0;">
                    <thead style="position: sticky; top: 0; background-color: #f7f7f7; z-index: 10;">
                        <tr class="info">
                            <th>ID</th>
                            <th>Product Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Unit</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (list != null && !list.isEmpty()) {
                                    for (Product prod : list) {%>
                        <tr>
                            <td><%= prod.getProductId()%></td>
                            <td>
                                <%= prod.getProductName()%>
                                <% if (prod.getDiscount() > 0) {%>
                                <span class="label label-warning">-<%= prod.getDiscount()%>%</span>
                                <% }%>
                            </td>
                            <td><%= (prod.getType() != null) ? prod.getType().getCategoryName() : "N/A"%></td>
                            <td>
                                <%= String.format("%,d", prod.getPrice())%> VND
                            </td>
                            <td><%= prod.getUnit()%></td>
                            <td>
                                <a href="products?action=edit&id=<%= prod.getProductId()%>" class="btn btn-warning btn-sm">Edit</a>
                                <a href="products?action=delete&id=<%= prod.getProductId()%>" class="btn btn-danger btn-sm" onclick="return confirm('Delete this product?')">Delete</a>
                            </td>
                        </tr>
                        <% }
                            } else { %>
                        <tr><td colspan="6" class="text-center">No products found.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% }%>
        </div>

    </body>
</html>
