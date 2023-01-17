package study;

public class Star5 {
	public static void main(String[] args) {
		int a = 10;
		for (int i = 0; i < a; i++) {
			for (int j = 0; j < (a - 1) - i; j++) {
				System.out.print(" ");
			}
			for (int j = 0; j < 2 * i + 1; j++) {
				System.out.print("*");
			}
			if (2 * i + 1 == a) {
				for (int i = a - 1; i > 0; i--) {
					for (int j = a; j < 2 * 1 + 1; j--) {
						System.out.print("*");
					}
				}

			}
		}
	}
}
