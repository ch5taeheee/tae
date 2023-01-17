package chapter05;

import java.util.Random;

public class NullExample {
	public static void main(String[] args) {
		Random random = null;
		
	    random = new Random(); // 하지 않으면 에러뜸
	    
		int dice = random.nextInt(6)+1;
		System.out.println(dice);
		
		
	}
}
