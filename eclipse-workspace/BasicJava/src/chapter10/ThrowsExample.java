package chapter10;

public class ThrowsExample {
	public static void main(String[] args) throws ClassNotFoundException { //try-catch를 하거나 이렇게 하거나 둘 중 하나 선택, 가독성은 throws
		findClass();
	}
	//throw new Exception();

	private static void findClass() throws ClassNotFoundException {
		Class.forName("java.lang.String2");
	}
}
