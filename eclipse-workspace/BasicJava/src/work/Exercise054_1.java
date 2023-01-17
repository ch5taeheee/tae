package work;

import java.util.Random;

public class Exercise054_1 {
	public static void main(String[] args) {
		Random random = new Random();
		int[] dice = new int[6];
		
	
		
		for(int i = 0; i <10000; i++) {
		int d = random.nextInt(6) + 0;
		dice[d]++;
		}
		 
		System.out.println("----------------------------");
		System.out.println("면" + "\t빈도");
		System.out.println("----------------------------");
		for (int i = 0; i < dice.length; i++) {
			System.out.println((i + 1) + "\t" + dice[i]);
		
		
		
	}
}
}
