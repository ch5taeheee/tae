package work;

import java.util.Scanner;

public class Exercise44_1 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.println("가위 바위 보 게임");
		System.out.print("철수: ");
		String su = scanner.nextLine();
		System.out.print("영희: ");
		String zero = scanner.nextLine();
		String result ;
		
		
		if (su.equals(zero)) {
			result = "무승부";
		} else if (su.equals("가위") && zero.equals("보") || su.equals("보") && zero.equals("주먹")
				|| su.equals("주먹") && zero.equals("가위")) {
			result = "철수 이김";
		} else {
			 result = "영희 이김";
		}

		System.out.println("결과 : " + result);
	}
}
