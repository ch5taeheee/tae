package kr.or.ddit.basic;

import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;

/**
 * FileWriter(문자기반스트림) 예제
 */
public class T07FileWriterTest {
	public static void main(String[] args) {
		// 사용자가 입력한 내용을 그대로 파일로 저장하기

		// 콘솔(표준 입출력장치)과 연결된 입력용 문자 스트림 생성
		// InputStreamReader => 바이트 기반 스트림을 문자 기반 스트림으로 변환해 주는 보조 스트림 클래스(일반 스트림 보조)

		InputStreamReader isr = new InputStreamReader(System.in);
		
		FileWriter fw = null;

		try {
			System.out.println("아무거나 입력하세요.");
			fw = new FileWriter("d:/D_Other/testChar.txt"); 
			int data = 0;

			// 콘솔로 입력한 내용을 파일로 저장하기(입력의 끝 표시는 Ctrl + z 키를 누르면 된다.)
			while ((data = isr.read()) != -1) {
				fw.write(data);
			}

			System.out.println("입력 끝..");
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				fw.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
