package work;

import java.util.Random;

public class Exercise054 {
	public static void main(String[] args) {
		Random random = new Random();

		int[] dice = new int[6];

		for (int i = 0; i < 10000; i++) {
			int d = random.nextInt(6);
			if (dice[d] == dice[0]) {
				dice[0]++;
			} else if (dice[d] == dice[1]) {
				dice[1]++;
			} else if (dice[d] == dice[2]) {
				dice[2]++;
			} else if (dice[d] == dice[3]) {
				dice[3]++;
			} else if (dice[d] == dice[4]) {
				dice[4]++;
			} else {
				dice[5]++;
			}
		}
		System.out.println("----------------------------");
		System.out.println("면" + "\t빈도");
		System.out.println("----------------------------");

		for (int i = 0; i < dice.length; i++) {
			System.out.println((i + 1) + "\t" + dice[i]);
		}

	}
}
