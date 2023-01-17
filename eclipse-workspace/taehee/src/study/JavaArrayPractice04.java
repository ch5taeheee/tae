package study;

import java.util.Random;

public class JavaArrayPractice04 {
	public static void main(String[] args) {
		int[] money = { 500, 200, 50, 10 };
		Random random = new Random();
		int m = random.nextInt(500) * 10;

		System.out.println("거스름돈: " + m + "원");

		for (int i = 0; i < money.length; i++) {
			System.out.println(money[i] + "원 : " + m / money[i] + "개");
			m = m % money[i];
		}

	}
}
