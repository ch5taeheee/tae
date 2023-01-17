package taehee;

import java.util.Scanner;

public class gugudan {
	public static void main(String[] args) {
		System.out.println("구구단 출력하기");
		
		Scanner scanner = new Scanner(System.in);
		System.out.print("몇 단을 출력하시겠습니까? (0을 입력하면 전체 구구단이 출력됩니다.) :");
		int i = scanner.nextInt();
		
		if (i != 0) {
		for (int m=i; m<=9; m++) {
			System.out.println(m+ "단"); 
			for (int n=1; n<=9; n++) {
				System.out.println(m + " * " + n + "= " + m*n);
			} else {
				for (int m=1; m<=9; m++) {
					System.out.println(m+ "단"); 
					for (int n=1; n<=9; n++) {
						System.out.println(m + " * " + n + "= " + m*n);
			}	
			}
		}
		
	}
		}
	}
}
		

