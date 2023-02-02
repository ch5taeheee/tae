package Work;

import java.util.Random;
import java.util.Scanner;
import java.util.TreeSet;

public class Lotto1 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		Random random = new Random();

		int menu;
		int end;

		System.out.println("===========================");
		System.out.println("Lotto 프로그램");
		System.out.println("---------------------------");
		System.out.println("1. Lotto 구입");
		System.out.println("2. 프로그램 종료");
		System.out.println("===========================");
		System.out.print("메뉴 선택 : ");
		menu = scanner.nextInt();
		System.out.println();

		switch (menu) {

		case 1:
			System.out.println("Lotto 구입 시작");
			System.out.println();
			System.out.println("1000원에 로또번호 하나입니다.");
			System.out.print("금액입력: ");
			int cash = scanner.nextInt();
			System.out.println();
			System.out.println("행운의 로또번호는 아래와 같습니다.");

			int r = cash / 1000;
			int rr = cash % 1000;

			for (int i = 0; i < r; i++) {
				TreeSet lotto = new TreeSet();

				while (lotto.size() < 6) {
					int num = random.nextInt(45) + 1;

					lotto.add(num);
				}

				System.out.println("로또번호" + (i + 1) + " : " + lotto);
			}

			System.out.println("받은 금액은 " + cash + "원 이고 거스름돈은 " + rr + "원 입니다.");

			break;

		case 2:
			System.out.println();
			System.out.println("감사합니다.");
			break;
		}

	}
}
