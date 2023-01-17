package chapter07_;

import work.Circle;

public class ShapeTest {
	public static void main(String[] args) {
		Shape[] shapes = new Shape[3];
		shapes[0] = new chapter07_.Circle(1.0);
		shapes[1] = new Triangle(2.0);
		shapes[2] = new Rectangle(2.0,3.0);
		for(Shape shape : shapes) {
			System.out.println(shape);
		}
		
		
	}
}
