package service;

import java.util.List;

import vo.BoardVO;

/**
 * 컨트롤러에 의해 호출될 실제 기능을 가진 서비스 인터페이스
 */

public interface BoardService {
	
	public int registBoard(BoardVO bb);


	public int modifyBoard(BoardVO bb);

	
	public boolean checkBoard (String writer);

	
	public int removeBoard(String writer);


	public List<BoardVO> selectAllBoard();

	
	public List<BoardVO> searchBoard(BoardVO bb);


	


	

}
