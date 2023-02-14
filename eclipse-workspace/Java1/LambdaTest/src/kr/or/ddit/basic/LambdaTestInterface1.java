package kr.or.ddit.basic;
@FunctionalInterface // 붙이는 순간 메서드 추가를 못 함. 왜냐, 함수적인터페이스는 추상메서드가 1개이기 때문이다. 
public interface LambdaTestInterface1 {
	// 반환값이 없고 매개변수도 없는 추상메서드 선언
	public void test();

}
@FunctionalInterface
interface LambdaTestInterface2 {
	// 반환값이 없고 매개변수는 있는 추상메서드 선언
	public void test(int a);
	
}
@FunctionalInterface
interface LambdaTestInterface3 {
	// 반환값이 있고, 매개변수도 있는 추상메서드 선언
	public int test(int a, int b);
	
}
