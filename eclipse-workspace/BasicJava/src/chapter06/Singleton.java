package chapter06;

public class Singleton {
//	String name; 이런건 싱글톤x
//	int age; 
//	private Singleton() { //new를 못 만듬 외부에서, 내부에서는 생성 가능
//		
//	}
	private static Singleton instance = new Singleton(); // 메소드영역 힙에 만들어짐.

	private Singleton() {

	}

	public static Singleton getInstance() {
		return instance;
	}
//	public static Singleton getInstance() { // 이런식으로 써도 됨. 자바 싱글톤 코드 검색
//		if(instance==null) {
//			instance = new Singleton();
//		}
//		return instance;

	void run() { // 메소드영역에 필요할때만 런 호출 . 여러개 만들 필요x
		System.out.println("실행됨");
	}
}
