package chapter13;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Users {
	public static void main(String[] args) {
		//https://amogg.tistory.com/10
		//https://sujl95.tistory.com/59
		//https://velog.io/@la_sta/%EB%AA%A8%EB%93%A0-%EC%BB%A8%ED%85%90%EC%B8%A0%EC%97%90-%ED%99%9C%EC%9A%A9%ED%95%98%EA%B8%B0-%EC%A2%8B%EC%9D%80-.json-%EC%83%98%ED%94%8C
		// JSON(JavaScript Object Notation)
		/*
		 *  기호  : '{}','[]',':',','
		 *  {} -> 객체
		 *  [] -> 배열
		 *  : -> Key와 Value를 구분하기 위한 기호
		 *  , -> entry를 구분하기 위한 기호
		 */
//		private List<Map<String, Object>> users;
//		private List<user> 
		
		Map<String, List<User>> map = new HashMap<>();
		map.put("users", Arrays.asList(1,"AAAAA","as23","123456","AAAAA@test.com","https://amogg.tistory.com/1"));
		
		
	}
}
