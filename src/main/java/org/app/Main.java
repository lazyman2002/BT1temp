package org.app;

import com.zaxxer.hikari.HikariDataSource;

import java.sql.*;

//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
//        code2_1();
//        code2_2();
        code2_3();
    }

    private static void code2_1() {
        HikariDataSource dataSource = HKRconfig.getDataSource();
        try (Connection connection = dataSource.getConnection()) {
            connection.setAutoCommit(false);
            Savepoint savepoint = connection.setSavepoint("BeforeUpdate");
            String query1 = "update `titles`\n set `titles`.`to_date` = date(now())\n where `titles`.`emp_no` = 10002\n and `titles`.`to_date` = '9999-01-01';";
            String query2 = "insert into `titles` (`emp_no`, `title`, `from_date`, `to_date`) values (10002, 'Senior Staff', date(now()), date('9999-01-01'));";

            try{
                PreparedStatement statement = connection.prepareStatement(query1);
                int rowsAffected = statement.executeUpdate();
//                ResultSet resultSet = statement.executeQuery();
                if (rowsAffected > 0) {
                    try {
                        statement = connection.prepareStatement(query2);
                        rowsAffected = statement.executeUpdate();
                        if(rowsAffected > 0 ){
                            connection.commit();
                        }
                        else{
                            connection.rollback(savepoint);
                        }
                    }
                    catch (Exception e){
                        connection.rollback(savepoint);
                        e.printStackTrace();
                    }
                } else {
                    connection.rollback(savepoint);
                }
            } catch (Exception e) {
                connection.rollback(savepoint);
                e.printStackTrace();
            }

        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
    private static void code2_2(){
        HikariDataSource dataSource = HKRconfig.getDataSource();
        Connection connection = null;
        Savepoint sv1 = null;
        try {
            connection = dataSource.getConnection();
            connection.setAutoCommit(false);
            sv1 = connection.setSavepoint("first save");
            String query = "select * from `departments` where `departments`.`dept_name` = 'Production';";
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            resultSet.next();
            if(resultSet.getRow() !=1){
                throw new Exception("not found Production dept_no");
            }
            String dept_no = resultSet.getString("dept_no");
            int rowsAffected;

//            Xóa salaries của những ai chỉ làm ở phòng d004
            query = "delete from `salaries` where `salaries`.`emp_no` not in(select `emp_no` from `dept_emp` where `dept_emp`.`dept_no` not like ?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

//            Xóa titles của những ai chỉ làm ở phòng d004
            query  = "delete from `titles` where `titles`.`emp_no` not in(select `emp_no` from `dept_emp` where `dept_emp`.`dept_no` not like ?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

//            Xóa employees của những ai chỉ làm ở phòng d004
            query = "delete from `employees` where `employees`.`emp_no` not in(select `emp_no` from `dept_emp` where `dept_emp`.`dept_no` not like ?);";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

//            Xóa dept_manager phòng d004
            query = "delete from `dept_manager` where `dept_no` = ?;";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

//            Xóa dept_emp phòng d004
            query = "delete from `dept_emp` where `dept_no` = ?;";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

//            Xóa department phòng d004
            query = "delete from `departments` where `dept_no` = ?;";
            statement = connection.prepareStatement(query);
            statement.setString(1, dept_no);
            rowsAffected = statement.executeUpdate();

            connection.commit();
        }
        catch (Exception e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }
        finally {
            try {
                connection.close();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }

    }
    private static void code2_3(){
        HikariDataSource dataSource = HKRconfig.getDataSource();
        Connection connection = null;
        Savepoint sv1 = null;
        String query = null;
        PreparedStatement statement = null;
        int rowsAffected;
        try {
            connection = dataSource.getConnection();
            connection.setAutoCommit(false);
            sv1 = connection.setSavepoint("first save");

            query1(connection);

            query2(connection);

            query3(connection);
            connection.commit();
        } catch (Exception e) {
            try {
                connection.rollback();
            } catch (SQLException ex) {
                throw new RuntimeException(ex);
            }
            throw new RuntimeException(e);
        }
    }

    private static void query3(Connection connection) throws Exception {
        String query;
        int rowsAffected;
        PreparedStatement statement;
        query = "insert into `titles`(`emp_no`, `title`, `from_date`, `to_date`) values(10173, 'Manager', date(now()), date('9999-01-01'));";
        statement = connection.prepareStatement(query);
        rowsAffected = statement.executeUpdate();
        if(rowsAffected <=0 ){
            throw new Exception("not update end title");
        }
    }

    private static void query2(Connection connection) throws Exception {
        int rowsAffected;
        String query;
        PreparedStatement statement;
        //            Kết thúc chức vụ cũ
        query = "update `titles`\n set `titles`.`to_date` = date(now())\n where `titles`.`emp_no` = 10173\n and `titles`.`to_date` = '9999-01-01';";
        statement = connection.prepareStatement(query);
        rowsAffected = statement.executeUpdate();
        if(rowsAffected <0 ){
            throw new Exception("not update end title");
        }
    }

    private static void query1(Connection connection) throws Exception {
        String query;
        PreparedStatement statement;
        int rowsAffected;
        query = "insert into `departments`(`dept_no`, `dept_name`) values('d010', 'Bigdata & ML');";
        statement = connection.prepareStatement(query);
        rowsAffected = statement.executeUpdate();
        if(rowsAffected <=0 ){
            throw new Exception("not inserted new dept");
        }
    }
}
