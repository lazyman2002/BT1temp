package org.app;

public class ENV {
    public static final int MAX_POOL_SIZE = 20;
    public static final int MIN_POOL_SIZE = 5;
    public static final int INIT_POOL_SIZE = 10;
    public static final String DB_PORT = "3306";
    public static final String DB_NAME = "employees";
    public static final String USERNAME = "root";
    public static final String PASSWORD = "root";
    public static final String URL =  "jdbc:mysql://localhost:" + DB_PORT + "/" + DB_NAME;
    private ENV() {
        super();
    }
}