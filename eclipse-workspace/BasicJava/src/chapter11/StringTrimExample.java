package chapter11;

public class StringTrimExample {
	public static void main(String[] args) {
		String tel1 = "  010-";
		String tel2 = "4158-   ";
		String tel3 = "   9871   ";

		String tel = tel1.trim() + tel2.trim() + tel3.trim();
		System.out.println(tel);
	}
}
