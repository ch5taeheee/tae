package kr.or.ddit.basic;

//어노테이션을 자바 reflaction으로 접근 ,어노테이션은 다른 프로그램에게 유용한 정보를 제공함.

public class Service {
	@PrintAnnotation
	public void method1() { //기본값 - , 20
		System.out.println("메서드1에서 출력되었습니다."); 
	}

	@PrintAnnotation(value = "%") // ("%") -> value 값 하나만 세팅할 때만 이렇게 쓰는 거 가능
	public void method2() {
		System.out.println("메서드2에서 출력되었습니다.");
	}

	@PrintAnnotation(value = "#", count = 25) // ("#", count = 25) 이거는 안된다.
	public void method3() {
		System.out.println("메서드3에서 출력되었습니다.");
	}

}
