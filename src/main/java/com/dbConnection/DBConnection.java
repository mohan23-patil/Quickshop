package com.dbConnection;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection
{
    private static Connection con = null;

    private DBConnection(){}

    public static Connection getConnection() {
        try
        {
//            if (con == null)
//            {
////                Class.forName("oracle.jdbc.OracleDriver");
////                con = DriverManager.getConnection(
////                        "jdbc:oracle:thin:@host.docker.internal:1521:xe",
////                        "system",
////                        "1234"
////                );
////                System.out.println("Connection established SuccessFully");
//
//            }
//            else
//            {
//                return con;
//            }
            if (con == null)
            {
                Class.forName("com.mysql.cj.jdbc.Driver");

                Properties properties = new Properties();

                InputStream inputStream =
                        DBConnection.class.getClassLoader().getResourceAsStream("db.properties");

                properties.load(inputStream);

                String url = properties.getProperty("db.url");
                String username = properties.getProperty("db.username");
                String password = properties.getProperty("db.password");

                con = DriverManager.getConnection(url, username, password);

                System.out.println("Aiven MySQL Connection established Successfully");
            }
            else
            {
                return con;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
