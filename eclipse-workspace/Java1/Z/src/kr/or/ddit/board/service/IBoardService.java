package kr.or.ddit.board.service;

import java.util.List;

import kr.or.ddit.boardVO.BoardVO;

public interface IBoardService {

	public int registBoard(BoardVO bvo);

	public int removeBoard(String boardwriter);

	public int modifyBoard(BoardVO bvo);

	public boolean checkBoard(String boardwriter);
	
	public List<BoardVO> selectAllBoard();
	
	public List<BoardVO> searchBoard(BoardVO bvo);

}
