package chapter11;

public class StringExample {
	public static void main(String[] args) {
		String value = "자바 프로그래밍, 자바는 쉽다.";
		String newValue = value.replace("자바", "쉽다");
		System.out.println(newValue);
		// Regular expression(정규 표현식, 정규식), 문자열을 기준으로 패턴을 찾아서 원하는 형태로 바꾸는 도구 -- 데이터베이스의 정규화(중복방지)와는 다름.
		// 정규표현식은 전부 다 암기! 표현식 외워야 함!
		int value1=45;
		int value2=45;
		int value3=45;
		int value4=45;
		int size = 0;
		
		//string result1 = (size==0) ? "0" : Math.round(value1/size) + ""; 이렇게 되어야 한다.
		String result1 = Math.round(value1/size) + "";
		String result2 = Math.round(value2/size) + "";
		String result3 = Math.round(value3/size) + "";
		String result4 = Math.round(value4/size) + "";
		System.out.println(result1);
		System.out.println(result2);
		System.out.println(result3);
		System.out.println(result4);
		52
		
		
	}
}
