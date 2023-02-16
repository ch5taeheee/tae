package kr.or.ddit.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

import kr.or.ddit.util.JDBCUtil3;

public class MemberMain {



	private Scanner scan = new Scanner(System.in);

	/**
	 * 메뉴를 출력하는 메서드
	 */
	public void displayMenu() {
		System.out.println();
		System.out.println("------------------------------------------");
		System.out.println("  === 작 업 선 택 ===");
		System.out.println("  1. 자료 입력");
		System.out.println("  2. 자료 삭제");
		System.out.println("  3. 자료 수정");
		System.out.println("  4. 전체 자료 출력");
		System.out.println("  5. 작업 끝.");
		System.out.println("------------------------------------------");
		System.out.print("원하는 작업 선택 >> ");
	}

	/**
	 * 프로그램 시작메서드
	 */
	public void start() {
		int choice;
		do {
			displayMenu(); // 메뉴 출력
			choice = scan.nextInt(); // 메뉴번호 입력받기
			switch (choice) {
			case 1: // 자료 입력
				insertMember();
				break;
			case 2: // 자료 삭제
				deleteMember();
				break;
			case 3: // 자료 수정
				updateMember();
				break;
			case 4: // 전체 자료 출력
				displayAllMember();
				break;
			case 5: // 작업 끝
				System.out.println("작업을 마칩니다.");
				break;
			default:
				System.out.println("번호를 잘못 입력했습니다. 다시입력하세요");
			}
		} while (choice != 5);

	}
	/**
	 * 전체 회원 정보를 출력하기 위한 메서드
	 */
	private void displayAllMember() {
		System.out.println();
		System.out.println("------------------------------------------");
		System.out.println("ID\t이름\t전화번호\t주 소");
		System.out.println("------------------------------------------");
		
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select * from mymember";
			
			stmt = conn.createStatement();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				String memId = rs.getString("mem_id");
				String memName = rs.getString("mem_name");
				String memTel = rs.getString("mem_tel");
				String memAddr = rs.getString("mem_addr");
				
				System.out.println(memId + "\t" + memName + "\t" + memTel + "\t" + memAddr);
				System.out.println("------------------------------------------");
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
			
		}
		
		
		
		
		
		
		
		
		System.out.println("출력 작업 끝.");
	}

	/**
	 * 회원정보를 삭제하기 위한 메서드
	 */
	private void deleteMember() {
		
		System.out.println();
		System.out.println("삭제할 회원정보를 입력하세요");
		System.out.print("회원ID >> ");
		String memId = scan.next();
		
		
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "delete from mymember where mem_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, memId);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) {
				System.out.println(memId + "회원 정보 삭제 작업 성공");
			} else {
				System.out.println(memId + "회원 정보 삭제 작업 실패");
			}
			
		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		
	}

	////////////////////////////////////////////////////////////////////////////////////////////
/**
 * 회원정보를 수정하는 메서드
 */
	private void updateMember() {
		boolean isExist = false;
		String memId = "";

		do {

			System.out.println();
			System.out.println("수정할 회원정보를 입력하세요");
			System.out.print("회원ID >> ");
			memId = scan.next();

			isExist = checkMember(memId);

			if (!isExist) {
				System.out.println("회원ID가 " + memId + "인 회원이 존재하지 않습니다.");
				System.out.println("다시 입력해 주세요");

			}

		} while (!isExist);

		System.out.print("회원이름 >> ");
		String memName = scan.next();

		System.out.print("회원전화번호 >> ");
		String memTel = scan.next();

		scan.nextLine(); // 버퍼 비우기

		System.out.print("회원주소>> ");
		String memAddr = scan.nextLine();
		
		try {
			conn = JDBCUtil3.getConnection();
			
			String sql = " update mymember" 
			+ " set mem_name =?," 
					+ " mem_tel = ?," 
			+ " mem_addr = ?" 
					+ " where mem_id = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memName);
			pstmt.setString(2,memTel);
			pstmt.setString(3,memAddr);
			pstmt.setString(4,memId);
			
			int cnt = pstmt.executeUpdate();
			
			if(cnt>0) {
				System.out.println(memId + "회원 정보 수정 성공");
			}else {
				System.out.println(memId + "회원 정보 수정 실패");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
	}
	//////////////////////////////////////////////////////////////////////////////////////////

	/**
	 * 회원정보를 추가하기 위한 메서드
	 */
	private void insertMember() {

		boolean isExist = false;
		String memId = "";

		do {

			System.out.println();
			System.out.println("새롭게 등록할 회원정보를 입력하세요");
			System.out.print("회원ID >> ");
			memId = scan.next();

			isExist = checkMember(memId);

			if (isExist) {
				System.out.println("회원ID가 " + memId + "인 회원이 이미 존재합니다.");
				System.out.println("다시 입력해 주세요");

			}

		} while (isExist);

		System.out.print("회원이름 >> ");
		String memName = scan.next();

		System.out.print("회원전화번호 >> ");
		String memTel = scan.next();

		scan.nextLine(); // 버퍼 비우기

		System.out.print("회원주소>> ");
		String memAddr = scan.nextLine();

		try {

			conn = JDBCUtil3.getConnection();

//			// 1. 드라이버 로딩(옵션)
//			Class.forName("oracle.jdbc.driver.OracleDriver");
//						
//			// 2. DB에 접속하기(Connection 객체 생성)
//			String url = "jdbc:oracle:thin:@localhost:1521/xe";
//			String userId = "CTH98";
//			String password = "java";
//						
//			conn = DriverManager.getConnection(url, userId, password);

			String sql = "insert into mymember (mem_Id, mem_Name, mem_Tel, mem_Addr) " + 
		               " values (?, ?, ?, ?)";
	         

			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			pstmt.setString(2, memName);
			pstmt.setString(3, memTel);
			pstmt.setString(4, memAddr);

			int cnt = pstmt.executeUpdate();

			if (cnt > 0) {
				System.out.println(memId + " 회원 추가 작업 성공");
			} else {
				System.out.println("회원 추가 작업 실패");
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {

			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}

	}

	/**
	 * 회원정보가 존재하는지 확인하기 위한 메서드
	 * 
	 * @param memId 회원정보를 체크할 회원 아이디
	 * @return 회원이 존재하면 true, 존재하지 않으면 false 반환함.
	 */
	private boolean checkMember(String memId) {
		
		boolean isExist = false;

		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select count(*)as cnt from mymember where mem_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);
			
			rs = pstmt.executeQuery();
			
			
			int cnt = 0;
			while(rs.next()) {
			cnt = rs.getInt("cnt");
			}
			
			if(cnt > 0) {
				isExist = true;
				
			}

		} catch (SQLException ex) {
			ex.printStackTrace();
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return isExist;
	}

	public static void main(String[] args) {
		MemberMain memObj = new MemberMain();
		memObj.start();
	}

}
