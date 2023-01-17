package work;

import java.util.Scanner;

public class Exercise25 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.print("500원짜리 동전의 갯수: ");
		int var1 = scanner.nextInt();
		
		System.out.print("100원짜리 동전의 갯수: ");
		int var2= scanner.nextInt();
		
		System.out.print("50원짜리 동전의 갯수: ");
		int var3= scanner.nextInt();
		
		System.out.print("10원짜리 동전의 갯수: ");
		int var4= scanner.nextInt();
		
		System.out.print("저금통 안의 동전의 총 액수: " + ((500*var1)+(100*var2)+(50*var3)+(10*var4)));
		
	}
}
