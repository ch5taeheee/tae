package service;

import java.util.List;
import java.util.Map;

import vo.BoardVO;

public interface IBoardService {

	//전체 글 갯수 조회
	public int countList();

	//목록 조회
	public List<BoardVO> boardList(Map<String, Object> map);

	//게시글 등록
	public int insertBoard(BoardVO vo);

	//게시물 상세조회
	public List<BoardVO> detailInfo(int uniqueId);

	//조회수 증가
	public void updateHit(int uniqueId);

	//게시물 삭제
	public int deleteBoard(int no);

	//게시물 수정
	public int updateBoard(BoardVO vo);
	
}
