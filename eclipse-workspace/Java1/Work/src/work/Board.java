package work;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Scanner;

import org.omg.CORBA.Current;

/**
 * 게시판 관리하는 프로그램
 */
public class Board {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	private Scanner scan = new Scanner(System.in);

	/**
	 * 메뉴를 출력하는 메서드
	 */

	public void displayMenu() {
		System.out.println();
		System.out.println("-------------------------------");
		System.out.println("===메 뉴 선 택===");
		System.out.println("1.전체 목록 출력");
		System.out.println("2. 새 글 작성");
		System.out.println("3. 글 수정");
		System.out.println("4. 글 삭제");
		System.out.println("5. 글 검색");
		System.out.println("6. 종료");

		System.out.println("-------------------------------");
		System.out.println("원하는 작업 선택 >>> ");

	}

	public void start() {
		int choice;
		do {
			displayMenu();
			choice = scan.nextInt();

			switch (choice) {
			case 1:
				print();
				break;

			case 2:
				insert();
				break;

			case 3:
				update();
				break;

			case 4:
				delete();
				break;

			case 5:
				search();
				break;

			default:
				System.out.println("번호를 잘못 입력했습니다. 다시 입력하세요");

			}
		} while (choice != 6);
	}

	private void print() {
		// TODO Auto-generated method stub

	}

	private void insert() {
		String content = "";
		String writer = "";
		String title = "";

		String currentDate = new SimpleDateFormat("yyMMdd").format(new java.util.Date());

		System.out.println("제목을 입력하세요.");
		title = scan.nextLine();
		System.out.println("작성자를 입력하세요.");
		writer = scan.nextLine();
		System.out.println(currentDate);
		System.out.println("새 글을 작성하세요.");
		content = scan.nextLine();

		try {
			conn = JDBCUtil.getConnection();
			String sql = " insert into JDBC_BOARD (board_no,board_title,board_writer,board_date,board_content)"
					+ " values (board_seq.nextVal,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, title);
			pstmt.setString(2, writer);
			pstmt.setString(3, currentDate);
			pstmt.setString(4, content);

			int cnt = pstmt.executeQuery();

			if (cnt > 0) {
				System.out.println("글 작성 완료");
			} else {
				System.out.println("글 작성 실패");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}

	}

/**
 * 글 수정 
 */
	private void update() {
		boolean isExist = false;
		String board_writer ="";
		
		do {
			System.out.println();
			System.out.println("작성자를 입력하세요.");
			System.out.println("작성자 >> ");
			board_writer = scan.nextLine();
			
			isExist=
		}
		

	private void delete() {
		// TODO Auto-generated method stub
		
	}

	private void search() {
		// TODO Auto-generated method stub
		
	}
	
	/**
	 * 글 작성자가 존재하는지 확인하기 위한 메서드
	 */
	private boolean checkMember(String board_writer) {
		boolean isExist = false;
		
		try {
			conn= JDBCUtil.getConnection();
			String sql = "select count(*) as cnt from jdbc_board where board_writer = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, board_writer);
			
		
		rs = pstmt.executeQuery();
		
		int cnt = 0;
		while(rs.next()) {
			cnt = rs.getInt("cnt");
		}
		if(cnt > 0) {
			isExist = true;
		}
			
		} catch (SQLException e) {
		 e.printStackTrace();
		}finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
			
		}
		return isExist;
	}
	public static void main(String[] args) {
		Board board = new Board();
		board.displayMenu();
	}

}

