package kr.or.ddit.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class T00JDBCTest2 {
	public static void main(String[] args) {
		
	/*
	 * JDBC를 이용한 데이터베이스 처리 순서
	 * 
	 *  순서 : JDBC드라이버 로딩 => 해당 DB에 접속 => 질의(SQL 명령을 수행) => 질의 결과를 받아서 처리 =>종료(자원반납)
	 * 
	 * 	1. JDBC 드라이버 로딩(오라클 기준)
	 * 	 	=> JDBC 드라이버는 DB를 만든 회사에서 제공한다. 
	 *  	Class.forName("oracle.jdbc.driver.OracleDriver");
	 *  
	 *	2. 접속하기 : 접속이 성공하면 Connection 객체가 생성된다.
	 *  	DriverManager.getConnection() 메서드 이용한다.
	 *  
	 * 	3. 질의  : Statement 객체 또는 PreparedStatement 객체를 이용하여 SQL 문장을 실행한다.
	 * 
	 * 	4. 결과 : 
	 *  	1) SQL 문이 select 일 경우 => ResultSet 객체가 반환된다.
	 *   	   ResultSet 객체를 통해 Select 결과를 가져올 수 있다.
	 *      2) SQL문이 insert, update, delete 일 경우 => 정수값을 반환한다.
	 *        (정수값은 보통 실행에 성공한 레코드 수를 의미한다.)
	 *  
	 */
	
	
	//JDBC 에 사용할 객체변수 선언
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			// 1. 드라이버 로딩(옵션)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2. DB에 접속하기(Connection 객체 생성)
			String url = "jdbc:oracle:thin:@localhost:1521/xe";
			String userId = "CTH98";
			String password = "java";
			
			conn = DriverManager.getConnection(url, userId, password);
			
			// 3. Statement 객체 생성 => Connection 객체 이용 (쿼리를 날리기 위한?)
			// stmt = conn.createStatement();
			
			
			// 4. SQL문을 Statement 객체를 이용하여 실행하고 실행결과를 ResultSet 객체로 반환한다. 
			// String sql = "INSERT INTO lprod (lprod_id,lprod_gu,lprod_nm)" +
			//		 			" VALUES (100,'M101','커피류')" ;
					
			//  String sql = "INSERT INTO lprod (lprod_id,lprod_gu,lprod_nm)" +
			//		 " VALUES (?,?,?)" ; (pstmt 사용시 실행하는 시점에 ? 안에 값을 넣어주면 된다.)
			 
			 String sql = "INSERT INTO lprod (lprod_id,lprod_gu,lprod_nm)" +
			 			" VALUES (?,?,?)" ; 	 
			 pstmt = conn.prepareStatement(sql); 
			 pstmt.setInt(1, 200); //파라미터는 물음표 위치
			 pstmt.setString(2,"Z100" ); 
			 pstmt.setString(3,"고기류"); 
			
			/*
			 * select 일 경우 => executeQuery() 이용. (resultset타입)
			 * insert, update,delete 일 경우  => executeUpdate() 이용.(int타입이기 때문에)
			 */
			 
			 // int cnt = stmt.executeUpdate(sql);
			 
			int cnt =  pstmt.executeUpdate();
			 
			 
			 
			 if(cnt > 0) {
				 System.out.println("등록 작업 성공");
			 } else {
				 System.out.println("등록 작업 실패");
			 }
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			
			// 6. 종료(사용했던 자원을 모두 반납한다.)
			if(rs != null) try {rs.close();}catch(SQLException e) {}
			if(stmt != null) try {stmt.close();}catch(SQLException e) {}
			if(pstmt != null) try {pstmt.close();}catch(SQLException e) {}
			if(conn != null) try {conn.close();}catch(SQLException e) {}
			
		}
	

	}
}
