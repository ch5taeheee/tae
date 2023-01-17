package chapter02;

import java.util.Scanner;

public class ninenine {
	public static void main(String[] args) {
	Scanner scanner = new Scanner(System.in);
	System.out.println("[필수정보입력]");
    
	System.out.print("1. 이름: ");
	String name = scanner.nextLine();
	
	System.out.print("2. 주민번호 앞 6자리: ");
	String first = scanner.nextLine();
	
	System.out.print("3. 전화번호: ");
	String tell = scanner.nextLine();
	
	System.out.println("[입력한 내용]");
	
	System.out.println(name);
	System.out.println(first);
	System.out.println(tell);
	
		
	}
	
}
