package model.dao;

import java.sql.*;
import java.util.*;
import model.Account;
import model.Product;
import utilities.ConnectDB;

public class ProductDAO implements Accessible<Product> {

    private ConnectDB db;

    public ProductDAO() {
    }

    public ProductDAO(ConnectDB db) {
        this.db = db;
    }

    private Connection getConnection() throws Exception {
        if (db != null) {
            return db.getConnection();
        }
        return new ConnectDB().getConnection();
    }

    @Override
    public int insertRec(Product o) {
        String sql = "INSERT INTO products (productId, productName, productImage, brief, postedDate, typeId, account, unit, price, discount) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getProductId());
            ps.setString(2, o.getProductName());
            ps.setString(3, o.getProductImage());
            ps.setString(4, o.getBrief());
            ps.setDate(5, o.getPostedDate());
            ps.setInt(6, (o.getType() != null) ? o.getType().getTypeId() : 0);
            ps.setString(7, (o.getAccount() != null) ? o.getAccount().getAccount() : "admin");
            ps.setString(8, o.getUnit());
            ps.setInt(9, o.getPrice());
            ps.setInt(10, o.getDiscount());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int updateRec(Product o) {
        String sql = "UPDATE products SET productName=?, productImage=?, brief=?, postedDate=?, typeId=?, account=?, unit=?, price=?, discount=? WHERE productId=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getProductName());
            ps.setString(2, o.getProductImage());
            ps.setString(3, o.getBrief());
            ps.setDate(4, o.getPostedDate());
            ps.setInt(5, (o.getType() != null) ? o.getType().getTypeId() : 0);
            ps.setString(6, (o.getAccount() != null) ? o.getAccount().getAccount() : "admin");
            ps.setString(7, o.getUnit());
            ps.setInt(8, o.getPrice());
            ps.setInt(9, o.getDiscount());
            ps.setString(10, o.getProductId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteRec(Product o) {
        String sql = "DELETE FROM products WHERE productId=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getProductId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Product> listAll() {
        return listBySearch(null);
    }

    public List<Product> listBySearch(String query) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products";
        if (query != null && !query.trim().isEmpty()) {
            sql += " WHERE productName LIKE ?";
        }
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            if (query != null && !query.trim().isEmpty()) {
                ps.setString(1, "%" + query + "%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs, con));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Product> listByType(int typeId) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE typeId = ?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, typeId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapProduct(rs, con));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Product getObjectById(String id) {
        String sql = "SELECT * FROM products WHERE productId=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapProduct(rs, con);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private Product mapProduct(ResultSet rs, Connection con) throws Exception {
        CategoryDAO cDao = new CategoryDAO(con);
        Account acc = new Account();
        acc.setAccount(rs.getString("account"));

        int typeId = rs.getInt("typeId");

        return new Product(
                rs.getString("productId"),
                rs.getString("productName"),
                rs.getString("productImage"),
                rs.getString("brief"),
                rs.getDate("postedDate"),
                cDao.getObjectById(String.valueOf(typeId)),
                acc,
                rs.getString("unit"),
                rs.getInt("price"),
                rs.getInt("discount"));
    }
}
