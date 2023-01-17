package work;

public class Circle {
	double radius;
	double x;
	double y;



	public double getRadius() {
		return radius;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		 this.x =x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y=y;
	}

	public double getArea() {
		double area = Math.PI * radius * radius;
		return area;

	}

	public void setRadius(double radius) {
		if (radius > 0) {
			this.radius = radius;
		} else {
			this.radius = 0;
		}

	}
}
