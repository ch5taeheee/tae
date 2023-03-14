package dao;

import java.sql.SQLException;
import java.util.Map;

public interface IMemberDao {

	//로그인검증
	public String loginChk(Map<String, Object> map) throws SQLException; //요청한 위치로 예외던짐
}
