package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

class util2 {
	public static <T extends Number> int compare(T t1, T t2) { //extends 를 이용해 타입의 제한을 걸 수 있다.
		double v1 = t1.doubleValue();
		double v2 = t2.doubleValue();
		
		return Double.compare(v1, v2);
		
	}
	
}
public class T04GenericMethodTest {
	public static void main(String[] args) {
		
		int result = util2.compare(10, 20);
		System.out.println(result);
		
		int result2 = util2.compare(3.14, 3);
		System.out.println(result2);
		
//		util2.compare("C", "JAVA");
		
		List<?> list = new ArrayList<String>(); // <?> 
		// List<?> list = new ArrayList<Integer, Number.. >(); 가능
		// <?> : 와일드 카드, 임의의 타입의 객체가 온다고 표현하고 싶을 때 사용 / 타입을 제너릭하게 만들다 보니 와일드카드가 필요
		
	}

		
	
}
