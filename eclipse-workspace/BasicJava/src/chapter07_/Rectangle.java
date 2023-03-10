package chapter07_;

public class Rectangle extends Shape {

	private double width;
	private double height;

	public Rectangle(double width, double height) {
		this.width = width;
		this.height = height;
	}

	@Override
	public double area() {
		return width * height ;
	}

	@Override
	public double perimeter() {
		return 2 * (width + height);
	}

	public String toString() {
		return String.format("도형의 종류: 사각형, 도형의 둘레: %.1fcm, 도형의 넓이: %.1f㎠", perimeter(), area());
	}

}
