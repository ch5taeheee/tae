package kr.or.ddit.basic;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/**
 * 성능향상을 위한 보조스트림 예제2 (문자기반의 Buffered스트림 예제)
 * 
 */

public class T12BufferedIOTest {

	public static void main(String[] args) {
		FileReader fr = null; // 문자 하나하나씩 읽느다.
		BufferedReader br = null; // 문자 한줄한줄씩 읽는다.

		try {
			// 이클립스에서 만든 자바 프로그램이 실행되는 기본 위치는 해당 '프로젝트폴더'가 기본(현재) 위치가 된다. 
			fr = new FileReader("./src/kr/or/ddit/basic/T11BufferedIoTest.java"); // 자바파일도 txt 파일 파일기반 문자열 스트림 ./생략

//			int data = 0;
//			while ((data = fr.read()) != -1) {
//				System.out.print((char) data);
//			}

			br = new BufferedReader(fr); // 한번씩 읽은 것을 임시 리턴하기 위해 temp 생ㅅ어

			String temp = "";
			int cnt = 1; // 몇 째줄인가
			while ((temp = br.readLine()) != null) { // 다 읽으면 null
				System.out.printf("%4d : %s\n", cnt++, temp);
			}

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				// fr.close();
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}

}
