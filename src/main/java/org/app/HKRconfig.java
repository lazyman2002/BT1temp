package org.app;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.SQLException;

public class HKRconfig {
    private static HikariConfig config = new HikariConfig();
    private static HikariDataSource ds;

    static {
        config.setJdbcUrl(ENV.URL);
        config.setUsername(ENV.USERNAME);
        config.setPassword(ENV.PASSWORD);
        config.setMaximumPoolSize(ENV.MAX_POOL_SIZE);
        config.setMinimumIdle(ENV.MIN_POOL_SIZE);
        config.setConnectionTimeout(30000);
        config.setIdleTimeout(60000);
        config.setPoolName("HikariConnPool");
        ds = new HikariDataSource( config );
    }

    private HKRconfig() {}

    public static Connection getConnection(){
        try {
            return ds.getConnection();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static HikariDataSource getDataSource() {
        return ds;
    }
}
