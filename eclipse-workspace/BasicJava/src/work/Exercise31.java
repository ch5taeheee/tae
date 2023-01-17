package work;

import java.util.Scanner;

public class Exercise31 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		
		int first, second, big, small;
		
		System.out.print("첫 번째 숫자를 입력하세요: ");
		first = scanner.nextInt();
		
		System.out.print("두 번째 숫자를 입력하세요: ");
		second = scanner.nextInt();
		
		big = ((first+second) + Math.abs(first - second))/2;
		small = ((first+second) - Math.abs(first - second))/2;
		
		
		System.out.print("큰 수를 작은 수로 나눈 몫은 " + big/small + "이고, 나머지는 " +big%small + "이다.");
		
		
	}
}
