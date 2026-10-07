package com.dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;

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

                String url =
                        System.getenv("DB_URL");

                String username =
                        System.getenv("DB_USERNAME");

                String password =
                        System.getenv("DB_PASSWORD");

                if (url == null || username == null || password == null)
                {
                    throw new RuntimeException(
                            "Database environment variables are missing!"
                    );
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