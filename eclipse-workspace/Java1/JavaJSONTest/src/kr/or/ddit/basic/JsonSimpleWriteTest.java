package kr.or.ddit.basic;

import java.io.FileWriter;
import java.io.IOException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class JsonSimpleWriteTest {

	/*
	 * JSON : Javascript Object Notation 자바스크립트 객체 표기법으로 작성된 텍스트이며, 데이터를 저장하거나 주고받기
	 * 위해 사용된다.
	 * 
	 * - JSON에서 값으로 사용가능한 데이터 타입 1. string 2. number 3. object (JSON object) 4.
	 * array 5. boolean 6. null
	 * 
	 */
	public static void main(String[] args) throws IOException {

		// JSON 데이터 생성하기
		JSONObject jsonObj = new JSONObject();

		jsonObj.put("name", "정재현");
		jsonObj.put("job", "미남");
		jsonObj.put("age", 26);
		jsonObj.put("addr", "서울시 광야");

		// JSONArray 데이터 생성
		JSONArray memList = new JSONArray();

		JSONObject jsonObj2 = new JSONObject();
		jsonObj2.put("name", "김준면");
		jsonObj2.put("job", "왕자");
		jsonObj2.put("age", 32);
		jsonObj2.put("addr", "대전시 중구 대덕인재개발원");
		memList.add(jsonObj2);

		jsonObj2 = new JSONObject();
		jsonObj2.put("name", "나재민");
		jsonObj2.put("job", "귀염둥이");
		jsonObj2.put("age", 23);
		jsonObj2.put("addr", "서울특별시 광야");
		memList.add(jsonObj2);

		jsonObj2 = new JSONObject();
		jsonObj2.put("name", "변백현");
		jsonObj2.put("job", "아이돌");
		jsonObj2.put("age", 31);
		jsonObj2.put("addr", "경기도 부천시");
		memList.add(jsonObj2);

		jsonObj.put("memList", memList);

		System.out.println(jsonObj);

		FileWriter fw = new FileWriter("./myJsonFile.txt");
		
		String myJsonTxt = "{\"name\": \"홍길동\", \"age\":50}";

		fw.write(jsonObj.toString());

		fw.close();

	}
}