package kr.or.ddit.basic;

import java.io.FileInputStream;
import java.io.IOException;

/**
 * 파일 읽기 예제
 */

public class T05FileStreamTest {
	public static void main(String[] args) {

		FileInputStream fis = null;

		try {
			fis = new FileInputStream("d:/D_Other/test.txt"); // 파일객체나, 스트림 사용 가능
			
			int data = 0;
			
			while((data = fis.read()) != -1) {
				// 읽은 데이터 출력하기
				System.out.print((char)data);
			}

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				fis.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

}
