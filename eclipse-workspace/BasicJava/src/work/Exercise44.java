package work;

import java.util.Scanner;

public class Exercise44 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.println("가위 바위 보 게임");
		System.out.print("철수: ");
		String su = scanner.nextLine();
		System.out.print("영희: ");
		String zero = scanner.nextLine();
		
		String score , rock, sci, pap;
		rock = "바위";
		sci = "가위";
		pap = "보";
		
		if(su.equals(zero)) {
		 score = "무승부 다시 하세요!!!" ;
		} else if(su.equals(rock) && zero.equals(sci)||su.equals(sci) && zero.equals(pap)||su.equals(pap) && zero.equals(rock)) {
			score = "철수 승리!!!" ;
		} else {
			score = "영희 승리!!!";
		}
		
		System.out.println("결과 : " + score);
	}
}
