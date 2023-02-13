package kr.or.ddit.basic;

import java.io.DataInputStream;
import java.io.DataOutput;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * 기본타입 입출력 기능 보조스트림 예제
 */

public class T13DataIOStreamTest {
	public static void main(String[] args) throws IOException {
		
		FileOutputStream fos = new FileOutputStream("d:/D_Other/test.dat");
		
		// DataOutputStream은 출력용 데이터를 자료형에 맞게 출력해 준다. 
		DataOutputStream dos = new DataOutputStream(fos);
		
		dos.writeUTF("홍길동");	// 문자열 데이터 출력(변형된 UTF-8)
		dos.writeInt(17);		// 정수형으로 데이터 출력
		dos.writeFloat(3.14f);  // 실수형(float)으로 데이터 출력
		dos.writeDouble(3.14);  // 실수형(double)으로 데이터 출력
		dos.writeBoolean(true); // 논리형으로 출력
		System.out.println("출력완료");
		
		dos.close();
		
		///////////////////////////////////////////////////////////////////////////////////////////////
		
		// 출력한 자료 읽어오기
		DataInputStream dis = new DataInputStream(new FileInputStream("d:/D_Other/test.dat"));
		
		System.out.println("문자열 자료 : " + dis.readUTF());
		System.out.println("정수형 자료 : " + dis.readInt());
		System.out.println("실수형(float) 자료 : " + dis.readFloat());
		System.out.println("실수형(double) 자료 : " + dis.readDouble());
		System.out.println("논리형 자료 : " + dis.readBoolean());
		
		//읽는 순서를 바꿨다면? 중간에 끊김. 차곡차곡 저장했는데 읽는 순서를 바뀌면 다르게 끊김. 그러니 데이터가 저장된 바이트 순서대로 읽을 때도 제대로 읽어 타입으로 잘 변환이 되어야 잘 읽는다. 
		
		dis.close();
		
		
	
	
	}	
	

}
