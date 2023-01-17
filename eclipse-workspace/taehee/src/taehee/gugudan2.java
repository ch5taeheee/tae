package taehee;

import java.util.Scanner;

public class gugudan2 {
	public static void main(String[] args) {
	System.out.println("구구단 출력하기");
	Scanner scanner = new Scanner(System.in);
	System.out.print("몇 단을 출력하시겠습니까?");
	
	int i = scanner.nextInt();
	System.out.println(i+" 단을 출력합니다");
	for (int j = i; j == i; j++) {
		for (int j2 = 1; j2 <=9; j2++) {
			System.out.println(j+" X "+ j2 + " = "+(j*j2));
		}
	}
	
}
}
