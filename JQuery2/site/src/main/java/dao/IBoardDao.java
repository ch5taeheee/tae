package dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import vo.BoardVO;

public interface IBoardDao {

	//전체 글 갯수 조회
	public int countList() throws SQLException;
	
	//목록 조회
	public List<BoardVO> boardList(Map<String, Object> map) throws SQLException;
	
	//게시글 등록
	public int insertBoard(BoardVO vo) throws SQLException;
	
	//게시물 상세조회
	public List<BoardVO> detailInfo(int uniqueId) throws SQLException;
	
	//조회수 증가
	public void updateHit(int uniqueId) throws SQLException;
	
	//게시물 삭제
	public int deleteBoard(int no) throws SQLException;
	
	//게시물 수정
	public int updateBoard(BoardVO vo) throws SQLException;
}
