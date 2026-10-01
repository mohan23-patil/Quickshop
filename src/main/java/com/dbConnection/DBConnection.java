package com.dbConnection;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection
{
    private static Connection con = null;

    private DBConnection(){}

    public static Connection getConnection()
    {
        try
        {
            if (con == null)
            {
                Class.forName("com.mysql.cj.jdbc.Driver");

                Properties properties = new Properties();

                InputStream inputStream =
                        DBConnection.class.getClassLoader().getResourceAsStream("db.properties");

                String url;
                String username;
                String password;

                if (inputStream != null)
                {
                    properties.load(inputStream);

                    url = properties.getProperty("db.url");
                    username = properties.getProperty("db.username");
                    password = properties.getProperty("db.password");
                }
                else
                {
                    url = System.getenv("DB_URL");
                    username = System.getenv("DB_USERNAME");
                    password = System.getenv("DB_PASSWORD");
                }

                con = DriverManager.getConnection(url, username, password);

                System.out.println("Aiven MySQL Connection established Successfully");
            }
            else
            {
                return con;
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return con;
    }
}