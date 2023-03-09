package dao;

import java.sql.SQLException;
import java.util.Map;

import common.MyBatisDao;

public class MemberDaoImpl extends MyBatisDao implements IMemberDao {
	
	private static IMemberDao dao;
	//싱글톤(한번만 생성 후 다같이 사용하는) 방식으로 객체 생성
	// 1. private constructor >> 외부에서 생성자로 객체 생성하지 못하게 만듦
		private MemberDaoImpl() {}
	// 2. static method >> 정적 메모리에 객체를 한번만 생성 후 공유하는 방식 사용
		public static IMemberDao getInstance() {
			if(dao == null) dao = new 	MemberDaoImpl();
			return dao;
			
			
		}
	
	
	
	

	@Override
	public String loginChk(Map<String, Object> map) throws SQLException {
		// TODO Auto-generated method stub
		return selectOne("mem.loginChk",map);
	}

}
