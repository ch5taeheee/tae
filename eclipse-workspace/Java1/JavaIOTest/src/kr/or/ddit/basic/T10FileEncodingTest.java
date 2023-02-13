package kr.or.ddit.basic;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;

public class T10FileEncodingTest {
	
	/*
	 * 키보드로 입력한 내용을 파일로 저장하는데
	 * out_utf8.txt 파일은 'utf-8' 인코딩 방식으로
	 * out_ansi.txt 파일은 'ms949' 인코딩 방식으로 저장한다. 
	 * 
	 */
	
	public static void main(String[] args) throws IOException {
		
		/*
		 * OutPutStreamWriter => OutPutStream(바이트기반 스트림)을 Writer(문자 기반 스트림)로 변환해 주는 보조 스트림
		 * 						 이 객체도 출력할 때 '인코딩 방식'을 지정해서 출력할 수 있다. 
		 */
		
		//파일 출력용
		FileOutputStream fos1 = new FileOutputStream("d:/D_Other/out_utf8.txt");
		FileOutputStream fos2 = new FileOutputStream("d:/D_Other/out_ansi.txt");
		
		OutputStreamWriter osw1 = new OutputStreamWriter(fos1,"utf-8");
		OutputStreamWriter osw2 = new OutputStreamWriter(fos2,"cp949");
		
		System.out.println("아무거나 입력하세요.");
		
		InputStreamReader isr = new InputStreamReader(System.in);
		
		int data = 0;
		while((data = isr.read()) != -1) { 
			osw1.write(data);
			osw2.write(data);
		}
		
		System.out.println("작업 완료...");
		osw2.close();
		osw1.close();
	}

}
