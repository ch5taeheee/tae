package chapter06;

public class Car2Example {
	public static void main(String[] args) {
		Car2 car = new Car2();
		System.out.println("모델: " + car.model);
		System.out.println("제작회사: " + car.company);
		System.out.println("색상: " + car.color);
		car.color = "하얀";
		System.out.println("색상: " + car.color);
		System.out.println("속력: " + car.speed);
		car.speed = 100;
		System.out.println("속력: " + car.speed);
	
		Car2 car2 = new Car2();
		System.out.println("car2의 현재 속력: " + car2.speed);
		car2.speed = 50;
		System.out.println("car2의 현재 속력: " + car2.speed);
		System.out.println("car의 현재 속력: " + car.speed);
		
		
	}
}
