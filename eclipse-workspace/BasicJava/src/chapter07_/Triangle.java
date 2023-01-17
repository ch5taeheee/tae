package chapter07_;

public class Triangle extends Shape {
	private double side;
	
	public Triangle(double side) {
		this.side = side;
	}
	@Override
	public double area() {
		return Math.sqrt(3)/4 * side *side;
	}
	@Override
	public double perimeter() {
		return side *3;
	}
	public String toString() {
		return String.format("도형의 종류: 삼각형, 도형의 둘레: %.1fcm, 도형의 넓이: %.16f㎠", perimeter(), area());
	}
	
}
