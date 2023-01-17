package work;

import java.util.Scanner;

public class Exercise24 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.print("원기둥 밑변의 반지름을 입력하시오.(단위: cm):");
		double var1 = scanner.nextDouble();
		
		System.out.print("원기둥 높이를 입력하시오.(단위: cm):");
		double var2 = scanner.nextDouble();
		
		double var3 = var1 * var1 * Math.PI ;
		double var4 = var3 *var2 ;
		System.out.println("원기둥 밑변의 넓이는 "+ var3 +"이고, 원기둥의 부피는 " + var4+ "이다.");
				
		
	}
}
