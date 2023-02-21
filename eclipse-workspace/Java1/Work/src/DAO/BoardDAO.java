package DAO;

import java.util.List;

import vo.BoardVO;

public interface BoardDAO {
	
	public int insertBoard(BoardVO bb);
	public int updateBoard(BoardVO bb);
	public int deleteBoard(String writer);
	public boolean checkBoard(String writer);
	public List<BoardVO> selectAllBoard();
	public List<BoardVO> searchBoard(BoardVO bb);
	
	
}
