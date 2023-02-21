package kr.or.ddit.member.dao;

import java.util.List;

import kr.or.ddit.comm.dao.MyBatisDao;
import kr.or.ddit.member.vo.MemberVO;

public class MemberDaoImpl extends MyBatisDao implements IMemberDao{
	
	private static IMemberDao memDao;
	
	private MemberDaoImpl() {
		
	}

	public static IMemberDao getInstance() {
		if(memDao == null) {
			memDao = new MemberDaoImpl();
		}
		return memDao;
	}
	
	@Override
	public int insertMember(MemberVO mv) {
		int cnt = insert("member.insertMember",mv); //마이바티스 선언한 insert 호출 마이바티스버전 (아이디, 변수)
		return cnt;
	}

	@Override
	public int updateMember(MemberVO mv) {
		int cnt = update("member.updateMember",mv);
		return cnt;
	}

	@Override
	public boolean checkMember(String memId) {
		boolean isExist = false;
		
		int cnt = selectOne("member.checkMember", memId);
		if(cnt>0) {
			isExist = true;
		}
		return isExist;
	}

	@Override
	public int deleteMember(String memId) {
		int cnt = delete("member.deleteMember",memId);
		return cnt;
	}

	@Override
	public List<MemberVO> selectAllMember() {
		List<MemberVO> memList = selectList("member.selectAllMember");
		return memList;
	}

	@Override
	public List<MemberVO> searchMember(MemberVO mv) {
		List<MemberVO> memList = selectList("member.searchMember",mv);
		return memList;
	}

}
