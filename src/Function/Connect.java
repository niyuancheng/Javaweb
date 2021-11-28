package Function;

import java.sql.*;
public class Connect {
	public static String username = "root";
	public static String password = "nyc757791";
	public static void getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("驱动注册成功");
		} catch (ClassNotFoundException e) {
			System.out.println("驱动注册失败");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
	}
	public  Connection buildConnection() throws SQLException { //返回一个数据库的句柄
		Connect.getConnection();
		Connection coon = DriverManager.getConnection("jdbc:mysql://localhost:3306/word?serverTimezone=UTC ",username,password);
		return coon;
	}
	
	public void closeConnection(Connection coon) throws SQLException {
		coon.close();
	}
}
