package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import common.MyBatisDao;
import vo.BoardVO;

public class BoardDaoImpl extends MyBatisDao implements IBoardDao {

	private static IBoardDao dao;
	//싱글톤 방식
	//1 private constructor
	private BoardDaoImpl() {}
	
	//2 static method
	public static IBoardDao getInstance() {
		if(dao == null) dao = new BoardDaoImpl();
		return dao;
	}
	
	@Override
	public int countList() throws SQLException {
		return selectOne("brd.countList");
	}

	@Override
	public List<BoardVO> boardList(Map<String, Object> map) throws SQLException {
		return selectList("brd.boardList", map);
	}

	@Override
	public int insertBoard(BoardVO vo) throws SQLException {
		return insert("brd.insertBoard", vo);
	}

	@Override
	public List<BoardVO> detailInfo(int uniqueId) throws SQLException {
		return selectList("brd.detailInfo", uniqueId);
	}

	@Override
	public void updateHit(int uniqueId) throws SQLException {
		update("brd.updateHit", uniqueId);
	}

	@Override
	public int deleteBoard(int no) throws SQLException {
		return delete("brd.deleteBoard", no);
	}

	@Override
	public int updateBoard(BoardVO vo) throws SQLException {
		return update("brd.updateBoard", vo);
	}

}
