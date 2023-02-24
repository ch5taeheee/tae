package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.boardVO.BoardVO;

public class BoardServiceImpl implements IBoardService {
	
	//멤버변수로 dao가 필요하다.
	
	private 

	@Override
	public int registBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int removeBoard(String boardwriter) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int modifyBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean checkBoard(String boardwriter) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BoardVO> selectAllBoard() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardVO> searchBoard(BoardVO bvo) {
		// TODO Auto-generated method stub
		return null;
	}
	

}
