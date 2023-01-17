package work;

import java.util.Scanner;

public class Exercise43_1 {
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
		
		
		String hh;
		if (avg >= 90) {
			 hh = "A";	
		} else if (avg >= 80) {
			 hh = "B";
		} else if (avg >= 70) {
			 hh = "C";
		} else if (avg >= 60) {
			 hh = "D";
		} else {
			 hh = "F";
		} 
		System.out.println("총점 : " + sum);
		System.out.printf("평균 : %.2f\n" ,avg);
		System.out.println("학점: " + hh);
	} 
}
