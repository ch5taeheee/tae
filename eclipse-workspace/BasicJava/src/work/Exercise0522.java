package work;

import java.util.Arrays;
import java.util.Random;

public class Exercise0522 {
	public static void main(String[] args) {
		// 1qnxj 45까지 배열에 저장
		int[] array = new int[45];
		for (int i = 0; i < array.length; i++) {
			array[i] = i + 1;
		}
		Random random = new Random();
		// array[i]와 array[랜덤] 바꾸기
		for (int i = 0; i < array.length; i++) {
			int ranNum = random.nextInt(45);
			int temp = array[i];
			array[i] = array[ranNum];
			array[ranNum] = temp;

		}
		int[] lotto = new int[6];
		for (int i = 0; i < lotto.length; i++) {
			lotto[i] = array[i];

		}
		System.out.println(Arrays.toString(lotto));
	}

//		Random random = new Random();
//
//		int[] lotto = new int[6];
//		int x;
//
//		int[] lotto2 = new int[45];
//		for (int i = 0; i < lotto.length; i++) {
//			lotto[i] = i+1;
//
//		}
//		
//		for (int i = 0; i < lotto.length; i++) {
//			int j = random.nextInt(45) + 0;
//			
//				x = lotto2[i];
//				lotto2[i] = lotto2[j];
//				lotto2[j] = x;
//
//		for (int i = 0; i < lotto.length; i++) {
//			for (int j = 0; j < lotto.length; j++) {
//				lotto[j] = random.nextInt(45) + 1;
//				if (lotto[j] == lotto[i]) {
//
//					x = lotto[i];
//					lotto[i] = lotto[j];
//					lotto[j] = x;
//
//			}
//		}
//
//		for (int i = 0; i < lotto.length; i++) {
//			System.out.print(lotto[i] + " ");
//		}
//	}
}
