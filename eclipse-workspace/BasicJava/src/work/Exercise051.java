package work;

public class Exercise051 {
	public static void main(String[] args) {
		int[] array = { 38, 94, 16, 3, 76, 94, 82, 47, 59, 8 };

		int min = 0;
		int max = 0;

		for (int i = 0; i < array.length; i++) {
			if (max < array[i]) {
				max = array[i];
			}
			for (int j = 0; j < i; j++) {
				if (array[j] > array[i]) {
					min = array[i];
				}

			}
		}
		System.out.println("최댓값: " + max);
		System.out.println("최솟값: " + min);

	}
}
