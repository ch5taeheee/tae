package work;

import java.util.Scanner;

public class Exercise41 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		System.out.print("삼각형의 첫번째 변의 길이를 입력하세요: ");
		int one = scanner.nextInt();
		System.out.print("삼각형의 두번째 변의 길이를 입력하세요: ");	
		int two = scanner.nextInt();
		System.out.print("삼각형의 세번째 변의 길이를 입력하세요: ");
		int thr = scanner.nextInt();
		
		if( one+two > thr && one + thr > two && two + thr > one) {
		 System.out.println("삼각형을 만들 수 있습니다.");
		} else { 
			System.out.println("삼각형을 만들 수 없습니다.");
		}
		
	}	
}
