package chapter08;
//get, set 안 써도 되는 눔북
//Lombok
//@Data
public class Apple {
	private String name;
	private Color color;

	public Apple() {

	}

	public String getName() {
		return name;
	}

	public Apple(String name, Color color) {
		super();
		this.name = name;
		this.color = color;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Color getColor() {
		return color;
	}

	public void setColor(Color color) {
		this.color = color;
	}

	@Override
	public String toString() {
		return "Apple";
	}

	enum Color {
		RED, GREEN, YELLOW;
	}

}