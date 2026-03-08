/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

/**
 *
 * @author di
 */

import java.sql.Connection;

public class TestDB {

    public static void main(String[] args) {

        try {

            ConnectDB db = new ConnectDB();

            Connection con = db.getConnection();

            if (con != null) {
                System.out.println("Connected success");
                java.sql.Statement st = con.createStatement();
                java.sql.ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM categories");
                if (rs.next()) {
                    System.out.println("Categories count: " + rs.getInt(1));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

        }

    }
}
