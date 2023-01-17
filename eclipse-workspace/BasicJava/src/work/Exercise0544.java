package work;

import java.util.Arrays;
import java.util.Random;

public class Exercise0544 {
	public static void main(String[] args) {
		int[] counts = new int[6];
		Random random = new Random();
		for (int i = 0; i < 10000; i++) {
			int ranNum = random.nextInt(6);
			counts[ranNum]++;
		}
//		System.out.println(Arrays.toString(counts));
		
		System.out.println("-------------");
		System.out.println("면" + "\t빈도");
		System.out.println("-------------");

		for (int i = 0; i < counts.length; i++) {
			System.out.println((i + 1) + "\t" + counts[i]);
		} System.out.println("-------------");
	}
}