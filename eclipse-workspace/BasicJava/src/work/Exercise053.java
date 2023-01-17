package work;

import java.util.Random;
import java.util.Scanner;

public class Exercise053 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		Random random = new Random();

		String[] com = { "가위", "바위", "보" };

		System.out.print("가위 바위 보를 입력하세요: ");
		String me = scanner.nextLine();
		System.out.println("게이머 : " + me);
		
		int i = random.nextInt(3) + 0;
		
		System.out.println("인공지능 컴퓨터: " + com[i]);

		String result;
		
		if (me.equals(com[i])) {
			result = "무승부";
			
		} else if (me.equals("가위") && com[i].equals("보") || me.equals("보") && com[i].equals("바위")
				|| me.equals("바위") && com[i].equals("가위")) {
			result = "게이머 승리!";
		} else {
			result = "컴퓨터 승리!";
		}
		
		System.out.println("결과: " + result);

	}
}
