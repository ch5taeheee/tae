package kr.or.ddit.basic;

import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 파일 출력 예제
 */
public class T06FileStreamTest {
	public static void main(String[] args) {
		FileOutputStream fos = null;

		try {
			fos = new FileOutputStream("d:/D_Other/out.txt");
			for (char ch = 'a'; ch <= 'z'; ch++) {
				fos.write(ch);
			}
			System.out.println("파일에 쓰기 작업 완료...");
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				fos.close();
			} catch (IOException e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
	}

}
