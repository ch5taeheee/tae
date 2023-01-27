package dbtest01;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Example01 {
	public static void main(String[] args) {
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
//		PreparedStatement pstmt = null;

		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "CTH98";
		String pw = "java";

		try {
			Class.forName("oracle.jdbc.driver.OracleDriver"); 

			con = DriverManager.getConnection(url, id, pw);
			String sql = "select * from lprod";
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				int lno = rs.getInt("lprod_id");
				String lgu = rs.getString("lprod_gu");
				String lname = rs.getString(3); // 오라클은 0번이 없기 때문에 1부터 시작 

				System.out.println(lno + "\t" + lgu + "\t" + lname);

			}
		} catch (Exception e) {
			System.out.println("DB접속실패");
			e.printStackTrace();
		} finally {
			try { // 반드시 역순으로 close 시켜야 한다. finally에!
				if (rs != null) {
					rs.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {

			}

		}
	}
}
