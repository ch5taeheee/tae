package study;

import java.util.Arrays;
import java.util.Random;

public class JavaArrayPractice05 {
	public static void main(String[] args) {
		Random ran = new Random();

		int[] ranNum = new int[10];
		int count = 0;

		for (int i = 0; i < ranNum.length; i++) {
			ranNum[i] = ran.nextInt(5) + 1;
		}
		System.out.println(Arrays.toString(ranNum));

		int[] temp = new int[5];

		for (int i = 0; i < ranNum.length; i++) {
			temp[count++] = ranNum[i];
			for (int j = 0; j < i; j++) {
				if (ranNum[i] == ranNum[j]) {
					
					break;
				}
			}
		}
		System.out.println(Arrays.toString(temp));

	}

}
