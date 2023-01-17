package work;

import java.util.Scanner;

public class Exercise32 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		int capital, population,income;
		
		
		System.out.print("수도입니까?(수도: 1, 수도아님:0) ");
		capital = scanner.nextInt();
		
		System.out.print("총 인구는?(단위: 만) ");
		population = scanner.nextInt();
		
		System.out.print("연소득이 1억 이상인 인구는?(단위: 만) ");
		income = scanner.nextInt();
		
		String o =  (capital == 1 && population ==100) | income >= 50 ? "이 도시는 메트로폴리스입니다." : "이 도시는 메트로폴리스가 아닙니다.";
		System.out.println(o);
	}
}
