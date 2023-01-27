package dbtest01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect { // 연결하는 것을 따로 빼낸다.
	public static Connection conn;

	public static Connection getConnection() {
		Connection connect = null;

		try {
			String user = "CTH98";
			String pwd = "java";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";

			Class.forName("oracle.jdbc.driver.OracleDriver");
			connect = DriverManager.getConnection(url, user, pwd);

		} catch (ClassNotFoundException e) {
			System.out.println("DB 드라이버 로딩 실패");

		} catch (SQLException e) {
			System.out.println("DB 접속 실패");
		} catch (Exception e) {
			System.out.println("Unknown Error");

		}
		return connect;
	}

}
