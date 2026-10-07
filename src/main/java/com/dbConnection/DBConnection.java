package com.dbConnection;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection
{
    private static Connection con = null;

    private DBConnection() {}

    public static Connection getConnection()
    {
        try
        {
            if (con == null || con.isClosed())
            {
                Class.forName("com.mysql.cj.jdbc.Driver");

                String url = System.getenv("DB_URL");
                String username = System.getenv("DB_USERNAME");
                String password = System.getenv("DB_PASSWORD");

                // Local system
                if (url == null || username == null || password == null)
                {
                    Properties properties = new Properties();

                    InputStream inputStream =
                            DBConnection.class
                                    .getClassLoader()
                                    .getResourceAsStream("db.properties");

                    if (inputStream == null)
                    {
                        throw new RuntimeException(
                                "db.properties file not found!"
                        );
                    }

                    properties.load(inputStream);

                    url = properties.getProperty("db.url");
                    username = properties.getProperty("db.username");
                    password = properties.getProperty("db.password");

                    inputStream.close();
                }

                con = DriverManager.getConnection(
                        url,
                        username,
                        password
                );

                System.out.println(
                        "MySQL Connection established Successfully"
                );
            }

            return con;
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }

        return null;
    }
}