package chapter13;

import java.util.HashSet;
import java.util.Set;

public class HashSetExample01 {
	public static void main(String[] args) {
		Set<Member> set = new HashSet<>();
		
		set.add(new Member("홍길동",30));
		set.add(new Member("김자바",20));
		set.add(new Member("이순신",35));
		set.add(new Member("신용권",25));
		set.add(new Member("홍길동",30));
		set.add(new Member("김자바",30));
		

		
		System.out.println();
	}

}
