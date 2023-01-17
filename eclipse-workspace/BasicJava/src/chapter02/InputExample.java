package chapter02;

import java.util.Scanner;

public class InputExample {
	public static void main(String[] args) {
		// 사용자로부터 데이터를 입력받고자 할 때
		//Scanner라는 클래스를 사용
		Scanner scanner = new Scanner(System.in);
		System.out.println("첫번째 숫자를 입력하세요: ");
		int value1 = scanner.nextInt(); 
		System.out.println("두번째 숫자를 입력하세요: ");
		int value2 = scanner.nextInt();
		System.out.println("결과: " + (value1 + value2));
		
		String next = scanner.next(); // 엔터나 스페이스를 입력할 때까지
		String nextLine= scanner.nextLine(); // 엔터를 입력할 때까지
		
	}
}
