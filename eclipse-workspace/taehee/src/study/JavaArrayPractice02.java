package study;

public class JavaArrayPractice02 {
	public static void main(String[] args) {
		int[] arr = { 40, 50, 80, 60, 100, 90 };

		for (int i = 0; i < arr.length; i++) {
			if (arr[i] == 60) {
				System.out.println(i);
			}
		}
	}
}
