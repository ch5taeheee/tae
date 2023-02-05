package work;

import java.awt.DisplayMode;
import java.util.HashSet;
import java.util.Random;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;

public class Lotto2 {

	public static void main(String[] args) {
		new Lotto2().start();
	}

	private static Scanner scan;

	public Lotto2() {
		scan = new Scanner(System.in);
	}

	public void start() {

		System.out.println("=========================");
		System.out.println("로또 프로그램");
		System.out.println("=========================");
		System.out.println("1.ㅣOTTO 구입");
		System.out.println("프로그램 종료");
		System.out.println("=========================");
		System.out.println("메뉴 선택 : ");

		Lotto2.menu();

	}

	public static void menu() {

		int num = scan.nextInt();

		switch (num) {
		case 1:
			lottoStart();
			break;
			
		case 2:
			lottoEnd();
			return;
		default:
			System.out.println("잘못 입력했습니다. 다시 입력해주세요.");

			return;

		}
	}

	private static void lottoStart() {

		System.out.println("lotto 구입 시작");
		System.out.println("(1000원)에 로또번호 하나입니다.");
		System.out.println("금액입력 : ");
		scan.nextLine();

		String cash = scan.nextLine();
		int r = Integer.valueOf(cash) / 1000;
		Random random = new Random();

		for (int i = 0; i < r; i++) {
			Set<Integer> set_arr = new TreeSet<>();
			for (int ii = 0; ii < 6; ii++) {
				int num = random.nextInt(45) + 1;
				set_arr.add(num);

			}
			System.out.println("로또번호" + (i + 1) + ":" + set_arr);
		}
		System.out.println("받은 금액은 " + cash + "이고 거스름돈은 " + Integer.valueOf(cash) % 1000 + "입니다");

	}

	private static void lottoEnd() {

		System.out.println("감사합니다.");
	}

}
