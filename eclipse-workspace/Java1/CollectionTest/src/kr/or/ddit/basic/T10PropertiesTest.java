package kr.or.ddit.basic;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

public class T10PropertiesTest {
	public static void main(String[] args) throws FileNotFoundException, IOException   {
		
	
	// 맵과 다른 점은 타입이 다 String 이어야 한다.?
	// Properties는 Map보다 축소된 기능의 객체라고 할 수 있다. 
	// Map은 모든 형태의 객체 데이터를 key와 value값으로 사용할 수 있지만, 
	// Properties는 key와 value 값으로 String만 사용할 수 있다. 
	
	Properties prop = new Properties();
	
	prop.setProperty("name", "홍길동");
	prop.setProperty("tel", "010-1111-1111");
	prop.setProperty("addr", "대전");
	
	String name = prop.getProperty("name");
	String tel = prop.getProperty("tel");
	
	System.out.println("이름: " + name);
	System.out.println("전화: " + tel);
	System.out.println("주소: " + prop.getProperty("addr"));
	
	// 데이터를 파일로 저장하기 //property파일
	prop.store(new FileOutputStream("src/kr/or/ddit/basic/test.properties"), "코멘트(Comment) 입니다.");
	
	
	
}
}