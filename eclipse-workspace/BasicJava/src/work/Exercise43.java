package work;

import java.util.Scanner;

public class Exercise43 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.println("점수를 입력하세요.");
		System.out.print("프로그래밍 기초: ");
		int pro = scanner.nextInt();
		System.out.print("데이터베이스: ");
		int db = scanner.nextInt();
		System.out.print("화면구현: ");
		int ui = scanner.nextInt();
		System.out.print("애플리케이션 구현: ");
		int app = scanner.nextInt();
		System.out.print("머신러닝: ");
		int machine = scanner.nextInt();

		int sum = pro + db + ui + app + machine;
		double avg = ((double) pro + db + ui + app + machine) / 5;
		System.out.println("총점 : " + sum);
		System.out.printf("평균 : %.2f\n" ,avg);
	
		if (avg >= 90) {
			String hh = "A";
			System.out.println("학점: " + hh);
		} else if (avg >= 80 && avg < 90) {
			String hh = "B";
			System.out.println("학점: " + hh);
		} else if (avg >= 70 && avg < 80) {
			String hh = "C";
			System.out.println("학점: " + hh);
		} else if (avg >= 60 && avg < 70) {
			String hh = "D";
			System.out.println("학점: " + hh);
		} else {
			String hh = "F";
			System.out.println("학점: " + hh);
		} 
	} 
}
