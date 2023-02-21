package service;

import java.util.List;

import DAO.BoardDAOImpl;
import DAO.BoardDAO;
import vo.BoardVO;

public class BoardServiceImpl implements BoardService {
	
	private BoardDAO boarddao;
	
	public BoardServiceImpl() {
		boarddao = new BoardDAOImpl();
	}

	@Override
	public int registBoard(BoardVO bb) {
		int cnt = boarddao.insertBoard(bb);
		
		if(cnt >0) {
			
		}
		return cnt;
	}

	@Override
	public int modifyBoard(BoardVO bb) {
		return boarddao.updateBoard(bb);
	}

	@Override
	public boolean checkBoard(String writer) {
		return boarddao.checkBoard(writer);
	}

	@Override
	public int removeBoard(String writer) {
		return boarddao.deleteBoard(writer);
	}

	@Override
	public List<BoardVO> selectAllBoard() {
	return boarddao.selectAllBoard();
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bb) {
		return boarddao.searchBoard(bb);
	}

	


	

}
