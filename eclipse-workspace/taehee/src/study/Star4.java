package study;

public class Star4 {
	public static void main(String[] args) {
		int a = 10;
		for (int i = 0; i < a; i++) {
			for (int j = 0; j < (a - 1) - i; j++) {
				System.out.print(" ");
			}
			for (int j = 0; j < 2 * i + 1; j++) {
				System.out.print("*");
			}
			 System.out.println();
		}
	}
}
