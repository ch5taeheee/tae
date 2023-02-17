package kr.or.ddit.member.service;

import java.util.List;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVO;

public class MemberServiceImpl implements IMemberService {
// 멤버변수로 dao가 필요

	private IMemberDao memDao;

	private static IMemberService memService; 

	private MemberServiceImpl() {

		memDao = MemberDaoImpl.getInstance();
	}
	
	public static IMemberService getInstance() {
		if(memService == null) {
			memService = new MemberServiceImpl();
		}
		return memService;
	}
	

	@Override
	public int registMember(MemberVO mv) {
		int cnt = memDao.insertMember(mv);
		
		if(cnt > 0) {
			//메일 발송 서비스 호출
		}
		return cnt;
	}

	@Override
	public int modifyMember(MemberVO mv) {
		
		return memDao.updateMember(mv);
	}

	@Override
	public boolean checkMember(String memId) {
		
		return  memDao.checkMember(memId);
	}

	@Override
	public int removeMember(String memId) {
		
		return memDao.deleteMember(memId);
	}

	@Override
	public List<MemberVO> selectAllMember() {
		return memDao.selectAllMember();
	}

	@Override
	public List<MemberVO> searchMember(MemberVO mv) {
		return memDao.searchMember(mv);
	}

}
