package service;

import java.util.Map;

public interface IMemberService {

	//접근제한자 반환타입 메소드명(매개변수)
	
	//로그인검증
	public String loginChk(Map<String, Object> map);
	
}
