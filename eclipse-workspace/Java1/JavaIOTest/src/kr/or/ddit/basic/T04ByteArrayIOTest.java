package kr.or.ddit.basic;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.Arrays;

public class T04ByteArrayIOTest {
	public static void main(String[] args) throws IOException {

		byte[] inSrc = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
		byte[] outSrc = null;

		byte[] temp = new byte[4]; // 자료를 읽을 떄 사용할 배열(버퍼용)

		ByteArrayInputStream bais = new ByteArrayInputStream(inSrc);
		ByteArrayOutputStream baos = new ByteArrayOutputStream();

		int readBytes= 0; // 읽은 바이트 수

		// read() 메서드 => byte단위로 자료를 읽어와 int형으로 반환한다. 더 이상 읽을 데이터가 없으면 -1을 반환함.
		while ((readBytes = bais.read(temp)) != -1) { // 괄호 안에 아무것도 없으면 1바이트씩 처리한다 // readBytes는 읽은 바이트 수가 된다. 
			
			System.out.println("temp => " + Arrays.toString(temp));
			baos.write(temp,0,readBytes); // 출력하기
		}

		// 출력된 스트림 값들을 배열로 변환해서 반환하기
		outSrc = baos.toByteArray();

		System.out.println("inSrc => " + Arrays.toString(inSrc));
		System.out.println("outSrc => " + Arrays.toString(outSrc));

		bais.close();
		baos.close();
	}
}
