package chapter11;

import chapter06.Car;

public class ClassExample1 {
	public static void main(String[] args) {
		Class clazz = Car.class;
		
		Class clazz = Class.forName("sec01.exam08.Car");
		
		Car car = new Car();
		Class clazz = car.getClass();
		
		System.out.println(clazz.getName());
		System.out.println(clazz.getSimpleName());
		System.out.println(clazz.getPackage().getName());
	}
}
