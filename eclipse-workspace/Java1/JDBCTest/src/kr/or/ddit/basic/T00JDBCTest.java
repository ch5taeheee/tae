package kr.or.ddit.basic;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class T00JDBCTest {
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
			stmt = conn.createStatement();
			
			// 4. SQL문을 Statement 객체를 이용하여 실행하고 실행결과를 ResultSet 객체로 반환한다. 
			 String sql = "select * from lprod"; // 실행할 SQL문 준비
			
			/*
			 * select 일 경우 => executeQuery() 이용. (resultset타입)
			 * insert, update, delete 일 경우  => executeUpdate() 이용.(int타입이기 때문에)
			 */
			
			rs = stmt.executeQuery(sql); // resultset으로 반환
			
			/*
			 * rs.next() => ResultSet(Rs)객체의 데이터를 가리키는 포인터를 다음 레코드로 이동시키고 그곳에 자료가 있으면 true, 없으면 false 반환함.
			 */
			
			while(rs.next()) {
				
				/*
				 * 컬럼의 데이터를 가져오는 방법
				 * 
				 * 방법1_ rs.get자료형이름("컬럼명")
				 * 방법2_ rs.get자료형이름(컬럼번호) => 컬럼번호는 1번부터 시작
				 * 
				 */
				
				System.out.println("lprod_id : " + rs.getInt("lprod_id"));
				System.out.println("lprod_gu : " + rs.getString("lprod_gu"));
				System.out.println("lprod_nm : " + rs.getString("lprod_nm"));
				System.out.println("------------------------------------------------");
			}
			System.out.println("출력 끝...");
			
			
			
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
