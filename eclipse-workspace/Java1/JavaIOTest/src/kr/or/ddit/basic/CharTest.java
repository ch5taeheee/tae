package kr.or.ddit.basic;

public class CharTest {
	public static void main(String[] args) {
		
		char c1 = 'A'; // 문자를 직접 저장
		char c2 = 65; //10진수로 저장
		char c3 = '\u0041'; //16진수로 저장
		
		char c4 = '가';
		char c5 = '\uAC00';
		char c6 = 44032;
		
		int uniCode = c1; // 유니코드값
		
		System.out.println(c1);
		System.out.println(c2);
		System.out.println(c3);
		System.out.println(c4);
		System.out.println(c5);
		System.out.println(c6);
		System.out.println(uniCode);
	
	}

}
