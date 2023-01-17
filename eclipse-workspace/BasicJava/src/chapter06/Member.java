package chapter06;

public class Member {
	String name;
	String id;
	String password;
	int age;

	Member() {

	}

	Member(String name) {
		this.name = name;
	}

	Member(int a, String i) {

	}

	Member(String n, String i) { // 변수명이 다른 거기 대문에 이거랑 밑에는 서로 똑같은 거임. 다른 거 아님. 이러면 안됭.. 이름으로 구분하는 게 아니라 타입으로
									// 구분해라.

	}

	Member(String i, String n) {

	}

	// 괄호 안의 변수 -> 메소드나 생성자 괄호 안에서 선언된 변수 ==> 매개 변수(parameter)
	Member(String name, int age) { // string n을 매개변수라고 한다.
		this.name = name; // this 는 메모리에 올라갔을 때 객체가 가지고 있는 네임이라는 필드
		this.age = age;
	new	Member(name, null, null,age); //new를 꼭 써야 하는데 쓰면 생성이 되니까 member대신 this를 써라
	this(name, null,null, age);
		
	}

	Member(String n, String i, String p, int a) {
		

		this. name = n;
		this. id = i;
		this.password = p;
		this.age = a;
	}
}
