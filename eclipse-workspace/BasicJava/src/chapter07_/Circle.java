package chapter07_;

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
		return String.format("도형의 종류: 원, 도형의 둘레: %.15fcm, 도형의 넓이: %.15f㎠", perimeter(), area());
	}
	
 
}
