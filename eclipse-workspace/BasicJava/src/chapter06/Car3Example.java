package chapter06;
public class Car3Example {
	public static void main(String[] args) {
		Car3 myCar = new Car3();
		myCar.keyTurnon();
		myCar.run();
		int speed = myCar.getSpeed();
		System.out.println("현재속도: " + speed  + "km/h");
	}
}
