package kr.or.ddit.basic;

import java.io.File;
import java.io.IOException;

public class T01FileTest {
	public static void main(String[] args) throws IOException {
		
		// File 객체 만들기 연습
		
		// 1. new File(String 파일 또는 경로명)
		// => 디렉토리와 디렉토리 사이 또는 디렉토리와 파일명 사이의 구분문자는 '\'를 사용하거나 '/'를 사용할 수 있다.
		
		File file = new File("d:/D_Other/test.txt");
		
		System.out.println("파일명 : " + file.getName());
		System.out.println("파일여부 : " + file.isFile());
		System.out.println("디렉토리(폴더) 여부 : " + file.isDirectory());
		System.out.println("=========================================");
		
		File file2 = new File("d:/D_Other");
		System.out.println(file2.getName()+ "은 ");
		if(file.isFile()) {
			System.out.println("파일");
		}else if(file2.isDirectory()) {
			System.out.println("디렉토리(폴더)");
		}
		System.out.println("=========================================");
		
		// 2. new File(File parent, String child)
		// => 'parant' 디렉토리 안에 있는 'child' 파일 또는 디렉토리를 의미함.
		
		File file3 = new File(file2, "text.txt");
		System.out.println(file3.getName() + " 의 용량 크기 : " + file3.length() + "(bytes)" );
		
		
		
		// 3. new File( String parent, String child)
		
		File file4 = new File(".\\D_Other\\test\\..","test.txt"); // (상대)경로//내 위치에 따라 상대방의 위치가 달라질 수 있다. // START가 .(현재경로(위치))이나 ..으로 시작
		System.out.println("절대 경로 : " + file4.getAbsolutePath());// 절대경로 //리눅스?는\부터 시작, 윈도우는 드라이브 문자로 시작(c:,D:)
		System.out.println("경로 : " + file4.getPath());//생성자에 설정해준 경로 // 입력한 그대로
		System.out.println("표준 경로 : " + file4.getCanonicalPath());//.이 안들어감 최종 계산된 경로, 의미있는 것만 남는 실제 경로
		System.out.println("=========================================");
		
		
	}

}
