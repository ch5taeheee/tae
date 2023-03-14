package service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import dao.BoardDaoImpl;
import dao.IBoardDao;
import vo.BoardVO;

public class BoardServiceImpl implements IBoardService {

	private IBoardDao dao;
	private static IBoardService service;
	//1
	private BoardServiceImpl() {
		dao = BoardDaoImpl.getInstance();
	}
	//2
	public static IBoardService getInstance() {
		if(service == null) service = new BoardServiceImpl();
		return service;
	}
	
	@Override
	public int countList() {
		int count = 0;
		try {
			count = dao.countList();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count; 
	}
	
	
	@Override
	public List<BoardVO> boardList(Map<String, Object> map) {
		List<BoardVO> list = null;
		try {
			list = dao.boardList(map);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public int insertBoard(BoardVO vo) {

		int result = 0;
		try {
			result = dao.insertBoard(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	@Override
	public List<BoardVO> detailInfo(int uniqueId) {
		List<BoardVO> list = null;
		try {
			list = dao.detailInfo(uniqueId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	@Override
	public void updateHit(int uniqueId) {
		try {
			dao.updateHit(uniqueId);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	@Override
	public int deleteBoard(int no) {
		int rst = 0;
		
		try {
			rst = dao.deleteBoard(no);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return rst;
	}
	@Override
	public int updateBoard(BoardVO vo) {
		int rst = 0;
		try {
			rst = dao.updateBoard(vo);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rst;
	}

}
