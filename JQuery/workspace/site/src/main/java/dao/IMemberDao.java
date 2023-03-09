package dao;

import java.sql.SQLException;
import java.util.Map;

public interface IMemberDao {

	
	// 접근제한자 반호나타입 메소드명(매개변수)
		// 로그인 검증
		public String loginChk(Map<String,Object> map) throws SQLException;
	
	
}
