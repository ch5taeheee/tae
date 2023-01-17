package chapter03;

public class LogicalOperatorExample {
	public static void main(String[] args) {
		int charCode = 'A'; 
	
		if((charCode >= 65) & (charCode <= 90)) {
			System.out.println("대문자군요");
		}
		
		if((charCode >= 97) && (charCode <= 122)) {
			System.out.println("소문자군요");
		}
	
	}
}
