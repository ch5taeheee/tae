package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVO;

/**
 * 컨트롤러에 의해 호출될 실제 기능을 가진 서비스 인터페이스
 */

public interface IMemberService {
	/**
	 * MemberVO에 담겨진 자료를 DB에 Insert하기 위한 메서드
	 * @param mv DB에 저장할 데이터를 가진 VO객체
	 * @return DB작업이 성공하면 1 이상의 값이 반환되고, 실패하면 0이 반환된다.
	 */
	public int registMember(MemberVO mv);
	
	/**
	 * MemberVO에 담겨진 자료를 DB에 Update하기 위한 메서드
	 * @param mv DB에 수정할 데이터를 가진 VO객체
	 * @return DB작업이 성공하면 1 이상의 값이 반환되고, 실패하면 0이 반환된다.
	 */
	public int modifyMember(MemberVO mv);
	
	
	/**
	 * 주어진 회원ID를 이용하여 해당 회원이 존재하는지 여부를 알아내기 위한 메서드
	 * @param memId 존재여부 확인하기 위한 회원ID
	 * @return 해당 회원이 존재하면 true, 존재하지 않으면 false 반환함.
	 */
	public boolean checkMember(String memId);
	
	
	/**
	 * 주어진 회원ID를 이용하여 회원정보를 삭제하기 위한 메서드
	 * @param memId 삭제할 회원의 ID정보
	 * @return 삭제작업 성공하면 1, 실패 시 0 반환됨.
	 */
	public int removeMember(String memId);
	
	
	/**
	 * 전체 회원정보를 조회하기 위한 메서드
	 * @return 전체 회원정보를 담은 리스트
	 */
	public List<MemberVO> selectAllMember();
	
	/**
	 * 검색된 회원 정보를 조회하기 위한 메서드
	 * @param mv 검색할 조건정보를 담은 VO객체
	 * @return 검색된 회원정보를 담은 리스트 객체
	 */
	public List<MemberVO> searchMember(MemberVO mv);
	
}
