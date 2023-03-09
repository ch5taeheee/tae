package service;

import java.util.Map;

import dao.IMemberDao;
import dao.MemberDaoImpl;

public class MemberServiceImpl implements IMemberService{
	//1
	private IMemberDao dao;
	private static IMemberService service;
	
	private MemberServiceImpl() {
		dao = MemberDaoImpl.getInstance();
	}
	//2
	public static IMemberService getInstance() {
		if(service == null) service = new MemberServiceImpl();
		return service;
	}
	@Override
	public String loginChk(Map<String,Object> map) {
		
		//dao 객체로 접근해서 메소드를 통해 값을 받아와야 함.
		dao.loginChk(map);
		
		return null;
	}

	
}
