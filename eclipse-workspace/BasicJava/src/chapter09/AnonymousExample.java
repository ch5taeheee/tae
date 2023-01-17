package chapter09;

public class AnonymousExample {
	public static void main(String[] args) {
		Anonymous anony = new Anonymous();
		anony.field.start();
		anony.method1();
		anony.method2(new Worker() {
			public void start() {
				System.out.println("테스트를 합니다.");
			}
		});
	}
}
