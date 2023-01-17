package chapter03;

import java.util.Scanner;

public class Ponetwonine {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		System.out.print("첫 번째 수: ");
		Double first = scanner.nextDouble();
		
		
		System.out.print("두 번째 수: ");
		Double second = scanner.nextDouble();
		
		
		System.out.println("--------------------");
		
		Double result = first / second ;
		
		if ( (second == 0) | (second == 0.0)) {
			System.out.print("결과: 무한대" );
		} else {
			System.out.print("결과: " + result);
		}
		
		
		
		
	
		
		
		

	
		
	}
}
