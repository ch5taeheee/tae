package kr.or.ddit.member.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
//dao : jdbc 코딩 관련
import java.util.List;

import kr.or.ddit.member.vo.MemberVO;
import kr.or.ddit.util.JDBCUtil3;

public class MemberDaoImpl implements IMemberDao {

	private Connection conn;
	private Statement stmt;
	private PreparedStatement pstmt;
	private ResultSet rs;

	@Override
	public int insertMember(MemberVO mv) {
		int cnt = 0;
		try {

			conn = JDBCUtil3.getConnection();

			String sql = "insert into mymember (mem_Id, mem_Name, mem_Tel, mem_Addr) " + " values (?, ?, ?, ?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mv.getMemId());
			pstmt.setString(2, mv.getMemName());
			pstmt.setString(3, mv.getMemTel());
			pstmt.setString(4, mv.getMemAddr());

			cnt = pstmt.executeUpdate();

		} catch (SQLException ex) {
			throw new RuntimeException("회원정보 입력 중 예외발생!", ex); // runtime 예외 던지는 이유는 unchecked 예외 -> 강제화하지 않는다. / throw
																// 던 질 필요가 없다. 강제화 하지 않기 때문에 .
		} finally {

			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}

		return cnt;
	}

	@Override
	public int updateMember(MemberVO mv) {
		int cnt = 0;
		try {
			conn = JDBCUtil3.getConnection();

			String sql = " update mymember" + " set mem_name =?," + " mem_tel = ?," + " mem_addr = ?"
					+ " where mem_id = ? ";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mv.getMemName());
			pstmt.setString(2, mv.getMemTel());
			pstmt.setString(3, mv.getMemAddr());
			pstmt.setString(4, mv.getMemId());

			cnt = pstmt.executeUpdate();

		} catch (SQLException ex) {
			throw new RuntimeException("회원정보 수정 중 예외발생", ex);
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public boolean checkMember(String memId) {
		boolean isExist = false;

		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select count(*)as cnt from mymember where mem_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memId);

			rs = pstmt.executeQuery();

			int cnt = 0;
			while (rs.next()) {
				cnt = rs.getInt("cnt");
			}

			if (cnt > 0) {
				isExist = true;

			}

		} catch (SQLException ex) {
			throw new RuntimeException("회원정보 존재여부 체크 중 예외 발생", ex);
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return isExist;
	}

	@Override
	public int deleteMember(String memId) {
		int cnt = 0;
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "delete from mymember where mem_id = ? ";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, memId);

			cnt = pstmt.executeUpdate();

		} catch (SQLException ex) {
			throw new RuntimeException();
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);
		}
		return cnt;
	}

	@Override
	public List<MemberVO> selectAllMember() {
		List<MemberVO> memList = new ArrayList<>();
		try {
			conn = JDBCUtil3.getConnection();
			String sql = "select * from mymember";

			stmt = conn.createStatement();

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				String memId = rs.getString("mem_id");
				String memName = rs.getString("mem_name");
				String memTel = rs.getString("mem_tel");
				String memAddr = rs.getString("mem_addr");
				
				MemberVO mv = new MemberVO();
				mv.setMemId(memId);
				mv.setMemName(memName);
				mv.setMemTel(memTel);
				mv.setMemAddr(memAddr);
				
				memList.add(mv);

			}

		} catch (SQLException e) {
			throw new RuntimeException("전체 회원정보 조회 중 예외발생!",e);
		} finally {
			JDBCUtil3.close(conn, stmt, pstmt, rs);

		}
		return memList;
	}

}
