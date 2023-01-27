package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.MemberDTO;
import util.DBConnect;

public class MemberDAO {
	public boolean insert(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;
		try { // conn 과 pstmt 는 오픈 되어있으니 닫아야 한다. 역순으로 닫아라. //stack을 이용하기 때문
			conn = DBConnect.getConnection();
			String sql = "INSERT INTO T_MEMBER(mem_id, mem_name, mem_regno1, mem_regno2, mem_hp, mem_mail)"
					+ "VALUES (?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql); // 외부로부터 넘겨오는 값을 넣는 거기 때문에 ? 쓴다. preparestatement : 가져와, statement : 직접
												// 값을 지정할 때, 문자열을 집어 넣을 때

			pstmt.setString(1, dto.getMem_id()); // 정수면 setint, setdouble ...setstring -> string 객체로 리턴
			pstmt.setString(2, dto.getMem_name());
			pstmt.setString(3, dto.getMem_regno1());
			pstmt.setString(4, dto.getMem_regno2());
			pstmt.setString(5, dto.getMem_hp());
			pstmt.setString(6, dto.getMem_mail());

			flag = pstmt.executeUpdate(); // insert 할 떄는 executeupdate, select 할 때는 executequery 1: 정상입력 0 : 입력 x

		} catch (Exception e) {
			e.printStackTrace();
		} finally { // 항상실행
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}

	}

	public boolean update(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;

		try {
			conn = DBConnect.getConnection();
			String sql = "UPDATE t_member " + "set mem_name =?, mem_regno1=?,mem_regno2=?,mem_hp=?,mem_mail=?"
					+ "WHERE mem_id = ?";

			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getMem_name());
			pstmt.setString(2, dto.getMem_regno1());
			pstmt.setString(3, dto.getMem_regno2());
			pstmt.setString(4, dto.getMem_hp());
			pstmt.setString(5, dto.getMem_mail());
			pstmt.setString(6, dto.getMem_id());

			flag = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}

	}

	public boolean delete(MemberDTO dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int flag = 0;

		try {
			conn = DBConnect.getConnection();

			String sql = "DELETE FROM t_member" + "WHERE mem_id =?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getMem_id());
			flag = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
			}
		}
		if (flag > 0) {
			return true;
		} else {
			return false;
		}

	}

	public MemberDTO selectOne(String mem_id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO dto = null;

		try {
			conn = DBConnect.getConnection();
			String sql = "SELECT mem_id, mem_name, mem_regno1, mem_rengo2, mem_hp, mem_mail" + "from t_member"
					+ "WHERE mem_id = '" + mem_id + "'";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto = new MemberDTO();
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_regno1(rs.getString("mem_regno1"));
				dto.setMem_regno2(rs.getString("mem_regno2"));
				dto.setMem_hp(rs.getString("mem_hp"));
				dto.setMem_mail(rs.getString("mem_mail"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return dto;
	}

	public List<MemberDTO> slelectAll() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		List<MemberDTO> list = new ArrayList<>();

		try {
			conn = DBConnect.getConnection();
			String sql = "SELECT mem_id, mem_name, mem_regno1, mem_rengo2, mem_hp, mem_mail" + "From t_member";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_regno1(rs.getString("mem_regno1"));
				dto.setMem_regno2(rs.getString("mem_rengo2"));
				dto.setMem_hp(rs.getString("mem_hp"));
				dto.setMem_mail(rs.getString("mem_mail"));

				list.add(dto);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
			return list;

		}
	}

