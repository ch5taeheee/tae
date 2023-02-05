package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

public class T05WildCardTest {

	/*
	 * 와일드카드에 대하여 ...
	 * 
	 * 와일드카드(?)는 제너릭타입을 이용한 타입 안전한 코드를 위해 사용되는 특별한 종류의 인수(Argument)로서 변수선언, 객체 생성 및
	 * 메서드 정의할 때 사용된다.
	 * 
	 * <? extends T> : 와일드카드의 상한 제한. T와 그 자손들만 가능. 
	 * <? super T> : 와일드카드의 하한 제한. T와 그 조상들만 가능. 
	 * <?> : 모든 타입이 가능 <? extends Object> 의미와 동일함.
	 * 객체 생성시 와일드 카드 사용 x
	 */

	public static void main(String[] args) {

		FruitBox<Fruit> fruitBox = new FruitBox<>(); // 과일상자
		FruitBox<Apple> appleBox = new FruitBox<>(); // 사과상자
//		FruitBox<Garbage> garbageBox = new FruitBox<>(); // 사과상자

		fruitBox.add(new Apple()); // 사과 담기 fruit 타입이라 가능
		fruitBox.add(new Grape()); // 포도 담기

		appleBox.add(new Apple()); //
		appleBox.add(new Apple()); //
		// appleBox.add(new Grape()); // 타입x
		
//		garbageBox.add(new Garbage());
		
		Juicer.makeJuice(fruitBox);
		Juicer.makeJuice(appleBox); // 에러 이유 >  fruit 타입이 아니라서 > 해결 방법 ? 쥬서 클래스의 타입을 와일드로..
		// Juicer.makeJuice(garbageBox); // <T extends Fruit> 자손만 올 수 있다. 
		

	}

}

class Juicer {
	//static <T extends Fruit> void makeJuice(FruitBox<T> box) { //제너럭 타입을 걸어버리면 저 타입만 올 수 있음. 다른 타입도 올 수 있으니 제한된 타입을 걸어버려라 
	static void makeJuice(FruitBox<? extends Fruit> box) {
	String furitListStr = ""; // 과일목록

		int cnt = 0;
		//for (T f : box.getFruitList()) {
		for (Object f : box.getFruitList()) {
			
		if (cnt == 0) {
				furitListStr += f;

			} else {
				furitListStr += "," + f;
			}
			cnt++;

		}
		System.out.println(furitListStr + " => 주스 완성!");

	}
}

class Fruit {
	private String name; // 과일이름

	public Fruit(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "과일(" + name + ")";
	}

}

class Apple extends Fruit {

	public Apple() {
		super("사과");
	}

}
class Garbage {

	@Override
	public String toString() {
		return "음식물 쓰레기";
	}


}

class Grape extends Fruit {

	public Grape() {
		super("포도");
	}

}

class FruitBox<T extends Fruit> {
	private List<T> fruitList;

	public FruitBox() {
		fruitList = new ArrayList<>();
	}

	public void add(T fruit) {
		fruitList.add(fruit);
	}

	public List<T> getFruitList() {
		return fruitList;
	}


	

}