package utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectDB {
    private String hostName;
    private String instance;
    private String port;
    private String dbName;
    private String user;
    private String pass;

    // default constructor for general use
    public ConnectDB() {
        this.hostName = "localhost";
        this.instance = "";
        this.port = "1433";
        this.dbName = "ProductIntro";
        this.user = "sa";
        this.pass = "123456Aa@";
    }

    // constructor to receive parameters directly
    public ConnectDB(String host, String inst, String db, String port, String user, String pass) {
        this.hostName = host;
        this.instance = inst;
        this.dbName = db;
        this.port = port;
        this.user = user;
        this.pass = pass;
    }

    public String getURLString() {
        String fmt = "jdbc:sqlserver://%s%s:%s;databaseName=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=true;";
        String inst = (instance == null || instance.trim().isEmpty()) ? "" : "\\" + instance.trim();
        return String.format(fmt, this.hostName, inst, this.port, this.dbName, this.user, this.pass);
    }

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        return DriverManager.getConnection(getURLString());
    }
}