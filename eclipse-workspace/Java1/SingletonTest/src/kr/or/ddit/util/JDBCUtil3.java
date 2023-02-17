package kr.or.ddit.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;
import java.util.ResourceBundle;

/*
 * JDBC 드라이버 로딩, Connection 객체 생성 및 자원반납 기능 제공 클래스 
 */

public class JDBCUtil3 {
	
/*
 * 	db.properties 파일의 내용으로 DB정보를 설정하는 방법
 *  방법 2) ResourceBundle 객체 이용하기
 */
	static ResourceBundle bundle; 
	
	static { // 클래스 로딩할 때 한번만 실행된다
		bundle = ResourceBundle.getBundle("db");
		
		try {
			Class.forName(bundle.getString("driver"));
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
					bundle.getString("url"), 
					bundle.getString("user"), 
					bundle.getString("password"));
			
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
