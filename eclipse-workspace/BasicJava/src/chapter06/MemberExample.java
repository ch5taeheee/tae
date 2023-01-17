package chapter06;

public class MemberExample {
	public static void main(String[] args) {
		Member member = new Member();
		member.name = "조태희";
		member.age = 25;
		
		System.out.println(member.name);
		System.out.println(member.age);
		
		Member member3 = new Member("조태희", 30);
		
		System.out.println(member3.age);
	}
}
