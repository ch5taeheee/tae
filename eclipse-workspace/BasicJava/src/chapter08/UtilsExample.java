package chapter08;

import chapter08.Apple.Color;

public class UtilsExample {
	public static void main(String[] args) {
		Apple[] apples = {
				new Apple("1",Color.GREEN),
				new Apple("2",Color.RED),
				new Apple("3",Color.YELLOW),
				new Apple("4",Color.GREEN),
				new Apple("5",Color.RED),
				new Apple("6",Color.GREEN),
				new Apple("7",Color.RED),
				new Apple("8",Color.YELLOW),
				new Apple("9",Color.GREEN),
				new Apple("10",Color.RED),
		};
		Predicate predicate = new Predicate() {
			
			@Override
			public boolean test(Apple apple) {
				return apple.getColor() == Color.RED && Integer.parseInt(apple.getName())<=5;
			}
		};
		Apple[] apples2 = Utils.filter(apples, predicate);
		for(Apple apple : apples2) {
			System.out.println(apple);
		}
	}
}
