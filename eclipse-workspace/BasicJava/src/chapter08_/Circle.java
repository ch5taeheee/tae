package chapter08_;

public class Circle extends Shape{
	
	private double radius;
	
	public Circle(double radius) {
		this.radius = radius;
	}

	@Override
	public double area() {
		return radius * radius * Math.PI;
	}
	
	@Override
	public double perimeter() {
		return 2 * radius * Math.PI;
	}
	public String toString() {
		return String.format("도형의 종류: 원, 도형의 둘레: %.2fcm, 도형의 넓이: %.2f㎠", perimeter(), area());
	}
	
 
}
