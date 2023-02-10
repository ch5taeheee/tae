package kr.or.ddit.basic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.Arrays;

public class T03ByteArrayIOTest {
	public static void main(String[] args) throws IOException {

		byte[] inSrc = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
		byte[] outSrc = null;
		
		/* 직접 복사하는 방법 
		
		outSrc = new byte[inSrc.length]; // 메모리 할당 먼저
		
		for(int i = 0; i<inSrc.length; i++) {
			outSrc[i] = inSrc[i];
		}
		*/
		
		
		/* arraycopy를 이용한 배열 복사 방법 
		outSrc = new byte[inSrc.length];
		System.arraycopy(inSrc, 0, outSrc, 0, inSrc.length);
		
		System.out.println("직접 복사 후 outSrc => " + Arrays.toString(outSrc)); // ARRAY값을 TOSTRING으로 출력 */
		
		ByteArrayInputStream bais = new ByteArrayInputStream(inSrc);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		
		int data = 0; //읽어온 데이터를 저장할 변수
		
		//read() 메서드 => byte단위로 자료를 읽어와 int형으로 반환한다. 더 이상 읽을 데이터가 없으면 -1을 반환함.  
		while((data = bais.read()) != -1) {
			baos.write(data); // 출력하기
		}
		
		// 출력된 스트림 값들을 배열로 변환해서 반환하기
		outSrc = baos.toByteArray(); 
		
		System.out.println("inSrc => " + Arrays.toString(inSrc));
		System.out.println("outSrc => " + Arrays.toString(outSrc));
		
		bais.close();
		baos.close();
	}
}
