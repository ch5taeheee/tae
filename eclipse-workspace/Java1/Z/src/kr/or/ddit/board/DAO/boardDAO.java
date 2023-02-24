package kr.or.ddit.board.DAO;

import java.util.List;

import kr.or.ddit.boardVO.BoardVO;

/**
 * 실제 db와 연결해서 sql문을 수행하여 결과를 받아와 서비스에 전달해 주기 위한 dao의 인터페이스
 *
 */

public interface boardDAO {
	public int insertBoard(BoardVO bvo);
	public int updateBoard(BoardVO bvo);
	public int deleteBoard(String boardWriter);
	public boolean checkBoard(BoardVO bvo);
	public List<BoardVO> selectAllBoard();
	public List<BoardVO> searchBoard(BoardVO bvo);
	
	
	

}
