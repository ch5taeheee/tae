package kr.or.ddit.basic;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 입출력 성능향상을 위한 보조스트림 예제1
 */

public class T11BufferedIOTest {
	public static void main(String[] args) {

		FileOutputStream fos = null; //일반스트림
		BufferedOutputStream bos = null; //보조스트림

		try {
			fos = new FileOutputStream("d:/D_Other/bufferTest.txt");
			
			//버퍼의 크기를 지정하지 않으면 기본적으로 버퍼의 크기가 8192byte(8kb)로 설정된다. 
			// 버퍼를 크게 잡으면 메모리를 잡아 먹는다. 
			
			//버퍼의 크기가 5인 스트림 객체 생성
			
			bos = new BufferedOutputStream(fos,5);
			
			for(char ch ='1'; ch<='9';ch++) {
				System.out.println("쓰기작업"); // 5번째까지는 버퍼에 차곡차곡 정리 꼬ㅏㄱ 차면 비운다음에 나머지 4개가 채워지고.. 비우고 .. 총 write는 2번?
				bos.write(ch);
				
			}
			bos.flush(); // 작업을 종료하기 전에 버퍼에 남아있는 데이터를 모두 출력시킨다.
						 // close 시 자동으로 호출됨.
			
			System.out.println("작업 끝");
			
			
			

		} catch (IOException ex) {
			ex.printStackTrace();
		}finally {
			try {
				bos.close();
			} catch (IOException  e) {
				e.printStackTrace();
			}
		}

	}

}
