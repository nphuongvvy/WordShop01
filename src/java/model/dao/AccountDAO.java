package model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import utilities.ConnectDB;

public class AccountDAO implements Accessible<Account> {

    private ConnectDB db;

    public AccountDAO() {
    }

    public AccountDAO(ConnectDB db) {
        this.db = db;
    }

    private Connection getConnection() throws Exception {
        if (db != null) {
            return db.getConnection();
        }
        return new ConnectDB().getConnection();
    }

    @Override
    public int insertRec(Account o) {
        String sql = "INSERT INTO accounts (account, pass, lastName, firstName, birthday, gender, phone, isUse, roleInSystem) VALUES (?,?,?,?,?,?,?,?,?)";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getAccount());
            ps.setString(2, o.getPass());
            ps.setString(3, o.getLastName());
            ps.setString(4, o.getFirstName());
            ps.setDate(5, o.getBirthday());
            ps.setBoolean(6, o.isGender());
            ps.setString(7, o.getPhone());
            ps.setBoolean(8, o.isIsUse());
            ps.setInt(9, o.getRoleInSystem());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Account login(String user, String pass) {
        String sql = "SELECT * FROM accounts WHERE account=? AND pass=? AND isUse=1";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapAccount(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Account> listAll() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM accounts";
        try (Connection con = getConnection();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next())
                list.add(mapAccount(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Account getObjectById(String id) {
        String sql = "SELECT * FROM accounts WHERE account=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next())
                return mapAccount(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public int deleteRec(Account o) {
        String sql = "DELETE FROM accounts WHERE account=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getAccount());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int updateRec(Account o) {
        String sql = "UPDATE accounts SET pass=?, lastName=?, firstName=?, birthday=?, gender=?, phone=?, isUse=?, roleInSystem=? WHERE account=?";
        try (Connection con = getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, o.getPass());
            ps.setString(2, o.getLastName());
            ps.setString(3, o.getFirstName());
            ps.setDate(4, o.getBirthday());
            ps.setBoolean(5, o.isGender());
            ps.setString(6, o.getPhone());
            ps.setBoolean(7, o.isIsUse());
            ps.setInt(8, o.getRoleInSystem());
            ps.setString(9, o.getAccount());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Account mapAccount(ResultSet rs) throws SQLException {
        return new Account(
                rs.getString("account"),
                rs.getString("pass"),
                rs.getString("lastName"),
                rs.getString("firstName"),
                rs.getDate("birthday"),
                rs.getBoolean("gender"),
                rs.getString("phone"),
                rs.getBoolean("isUse"),
                rs.getInt("roleInSystem"));
    }
}