package chapter04;

import java.util.Random;

public class RandomGeneratorExample {
	public static void main(String[] args) {
		// 랜덤을 생성하고자 할 때 사용할 코드
		Random random = new Random();
		int one = random.nextInt(6) + 1 ;
		int two = random.nextInt(6) + 1;
	}
}
