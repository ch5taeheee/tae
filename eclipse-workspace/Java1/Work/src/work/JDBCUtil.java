package work;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/*
 * JDBC 드라이버 로딩, Connection 객체 생성 및 자원반납 기능 제공 클래스 
 */

public class JDBCUtil {
	static {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		//	System.out.println("드라이버 로딩 완료");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}
	/**
	 * DB 커넥션 연결
	 * @return Connection 객체
	 */
	public static Connection getConnection() {
		
		try {
			return DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521/xe", 
					"CTH98", 
					"java");
			
		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println("DB연결실패");
			return null;
		}
	}
	/**
	 * 자원 반납
	 */
	public static void close(Connection conn, Statement stmt, PreparedStatement pstmt, ResultSet rs) {
		if(rs != null) try {rs.close();}catch(SQLException e) {}
		if(stmt != null) try {stmt.close();}catch(SQLException e) {}
		if(pstmt != null) try {pstmt.close();}catch(SQLException e) {}
		if(conn != null) try {conn.close();}catch(SQLException e) {}
	}

}
