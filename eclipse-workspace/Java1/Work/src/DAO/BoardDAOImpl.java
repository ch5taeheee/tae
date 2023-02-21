package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import util.JDBCUtil;
import vo.BoardVO;

public class BoardDAOImpl implements BoardDAO {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	@Override
	public int insertBoard(BoardVO bb) {

		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			String sql = "insert into jdbc_board (board_no , board_title , board_writer , board_date , board_content ) "
					+ " values (board_seq.nextVal , ? , ? , sysdate , ? )";

			pstmt.setString(1, bb.getTitle());
			pstmt.setString(2, bb.getWriter());
			pstmt.setString(3, bb.getContent());

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new RuntimeException("글 작성 중 예외 발생", e);
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public int updateBoard(BoardVO bb) {
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			String sql = "update jdbc_board " + "set board_title = ?," + "board_date = sysdate, " + "board_content =? "
					+ " where board_writer =?";

			pstmt.setString(1, bb.getTitle());
			
			pstmt.setString(2, bb.getContent());
			pstmt.setString(3, bb.getWriter());

			cnt = pstmt.executeUpdate();

		} catch (SQLException e) {
			throw new RuntimeException("글 수정 중 예외 발생", e);
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public int deleteBoard(String writer) {
		int cnt = 0;
		try {
			conn = JDBCUtil.getConnection();
			String sql = "delete from jdbc_board where board_writer= ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, writer);

			cnt = pstmt.executeUpdate();

		} catch (SQLException ex) {
			throw new RuntimeException();
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public boolean checkBoard(String writer) {
		boolean isExist = false;
		try {
			conn = JDBCUtil.getConnection();
			String sql = "select count(*) as cnt from jdbc_board where board_writer =?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, writer);

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}
			if (cnt > 0) {
				isExist = true;
			}

		} catch (SQLException e) {
			throw new RuntimeException("글 작성 중 예외 발생", e);
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return isExist;
	}

	@Override
	public List<BoardVO> selectAllBoard() {
		List<BoardVO> boardList = new ArrayList<>();
		try {
			conn = JDBCUtil.getConnection();
			String sql = "select * from jdbc_board";

			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
			//	String no = rs.getString("board_no");
				String title = rs.getString("board_title");
				String writer = rs.getString("board_writer");
			//	String date = rs.getString("board_date");
				String content = rs.getString("board_content");

				BoardVO bb = new BoardVO();
			//	bb.setNo(no);
				bb.setTitle(title);
				bb.setWriter(writer);
			//	bb.setDate(date);
				bb.setContent(content);

				boardList.add(bb);

			}

		} catch (SQLException e) {
			throw new RuntimeException("전체 회원정보 조회 중 예외발생!", e);
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);

		}
		return boardList;
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bb) {
		List<BoardVO> boardList = new ArrayList<>();
		try {
			conn = JDBCUtil.getConnection();

			String sql = "select *from jdbc_board where 1=1"; 

//			if (bb.getNo() != null && !bb.getNo().equals("")) {
//				sql += " and mem_id = ?";
//			}
			if (bb.getTitle() != null && !bb.getTitle().equals("")) {
				sql += " and board_title= ?";
			}
			if (bb.getWriter() != null && !bb.getWriter().equals("")) {
				sql += " and board_writer = ?";
			}
//			if (bb.getDate() != null && !bb.getDate().equals("")) {
//				sql += " and board_d like '%'|| ? || '%'";
//			}

			pstmt = conn.prepareStatement(sql); 

			

			int index = 1;

//			if (bb.getNo() != null && !bb.getNo().equals("")) {
//				pstmt.setString(index++, bb.getNo());
//			}
			if (bb.getTitle() != null && !bb.getTitle().equals("")) {
				pstmt.setString(index++, bb.getTitle());
			}
			if (bb.getWriter() != null && !bb.getWriter().equals("")) {
				pstmt.setString(index++, bb.getWriter());

			}
//			if (bb.getDate() != null && !bb.getDate().equals("")) {
//				pstmt.setString(index++, bb.getDate());
//
//			}
			rs = pstmt.executeQuery();
			if (bb.getContent() != null && !bb.getContent().equals("")) {
				pstmt.setString(index++, bb.getContent());

			}
			rs = pstmt.executeQuery();

			while (rs.next()) {
				//String no = rs.getString("board_no");
				String title = rs.getString("board_title");
				String writer = rs.getString("board_writer");
				//String date = rs.getString("board_date");
				String content = rs.getString("board_content");

				BoardVO bb2 = new BoardVO();
			//	bb2.setNo(no);
				bb2.setTitle(title);
				bb2.setWriter(writer);
			//	bb2.setDate(date);
				bb2.setContent(content);

				boardList.add(bb2);

			}

		} catch (SQLException e) {
			throw new RuntimeException("회원정보 검색 중 예외발생!", e);
		} finally {
			JDBCUtil.close(conn, stmt, pstmt, rs);
		}
		return boardList;
	}

	

}
