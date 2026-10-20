
package com.dbConnection;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    private DBConnection() {
    }

    public static Connection getConnection() {

        String url = System.getenv("DB_URL");
        String username = System.getenv("DB_USERNAME");
        String password = System.getenv("DB_PASSWORD");

        try {

            // Load local configuration if environment variables are missing
            if (url == null || url.trim().isEmpty()
                    || username == null || username.trim().isEmpty()
                    || password == null || password.trim().isEmpty()) {

                Properties properties = new Properties();

                try (InputStream inputStream =
                             DBConnection.class.getClassLoader()
                                     .getResourceAsStream("db.properties")) {

                    if (inputStream == null) {
                        throw new SQLException(
                                "db.properties not found in src/main/resources"
                        );
                    }

                    properties.load(inputStream);
                }

                url = properties.getProperty("db.url");
                username = properties.getProperty("db.username");
                password = properties.getProperty("db.password");
            }

            // Validate database configuration
            if (url == null || url.trim().isEmpty()
                    || username == null || username.trim().isEmpty()
                    || password == null || password.trim().isEmpty()) {

                throw new SQLException(
                        "Database URL or credentials are missing."
                );
            }

            // Load MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish database connection
            Connection connection =
                    DriverManager.getConnection(url, username, password);

            System.out.println(
                    "MySQL connection established successfully."
            );

            return connection;

        } catch (Exception e) {

            throw new IllegalStateException(
                    "Unable to connect to MySQL. Check database credentials, "
                            + "db.properties, JDBC URL, and connectivity.",
                    e
            );
        }
    }
}
