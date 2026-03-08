package model.dao;

import java.sql.*;
import java.util.*;
import model.Category;
import utilities.ConnectDB;

public class CategoryDAO implements Accessible<Category> {

    private Connection con;
    private ConnectDB db;

    public CategoryDAO() {
    }

    public CategoryDAO(Connection con) {
        this.con = con;
    }

    public CategoryDAO(ConnectDB db) {
        this.db = db;
    }

    private Connection createConnection() throws Exception {
        if (db != null) {
            return db.getConnection();
        }
        return new ConnectDB().getConnection();
    }

    @Override
    public List<Category> listAll() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories";
        boolean closeExplicitly = false;
        Connection c = this.con;
        try {
            if (c == null || c.isClosed()) {
                c = createConnection();
                closeExplicitly = true;
            }
            try (Statement st = c.createStatement();
                    ResultSet rs = st.executeQuery(sql)) {
                while (rs.next()) {
                    list.add(new Category(rs.getInt("typeId"), rs.getString("categoryName"), rs.getString("memo")));
                }
            } finally {
                if (closeExplicitly && c != null)
                    c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Category getObjectById(String id) {
        String sql = "SELECT * FROM categories WHERE typeId = ?";
        boolean closeExplicitly = false;
        Connection c = this.con;
        try {
            if (c == null || c.isClosed()) {
                c = createConnection();
                closeExplicitly = true;
            }
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setInt(1, Integer.parseInt(id));
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        return new Category(rs.getInt("typeId"), rs.getString("categoryName"), rs.getString("memo"));
                    }
                }
            } finally {
                if (closeExplicitly && c != null)
                    c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int insertRec(Category category) {
        String sql = "INSERT INTO categories (categoryName, memo) VALUES (?, ?)";
        boolean closeExplicitly = false;
        Connection c = this.con;
        try {
            if (c == null || c.isClosed()) {
                c = createConnection();
                closeExplicitly = true;
            }
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, category.getCategoryName());
                ps.setString(2, category.getMemo());
                return ps.executeUpdate();
            } finally {
                if (closeExplicitly && c != null)
                    c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int updateRec(Category category) {
        String sql = "UPDATE categories SET categoryName = ?, memo = ? WHERE typeId = ?";
        boolean closeExplicitly = false;
        Connection c = this.con;
        try {
            if (c == null || c.isClosed()) {
                c = createConnection();
                closeExplicitly = true;
            }
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, category.getCategoryName());
                ps.setString(2, category.getMemo());
                ps.setInt(3, category.getTypeId());
                return ps.executeUpdate();
            } finally {
                if (closeExplicitly && c != null)
                    c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteRec(Category category) {
        String sql = "DELETE FROM categories WHERE typeId = ?";
        boolean closeExplicitly = false;
        Connection c = this.con;
        try {
            if (c == null || c.isClosed()) {
                c = createConnection();
                closeExplicitly = true;
            }
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setInt(1, category.getTypeId());
                return ps.executeUpdate();
            } finally {
                if (closeExplicitly && c != null)
                    c.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
