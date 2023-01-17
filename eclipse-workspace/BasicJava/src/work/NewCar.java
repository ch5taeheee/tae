package work;

public class NewCar {
	private double speed;
	private String color;
	private static final double MAX_SPEED = 200.0; // killotomile(200)

	public NewCar() {
	}

	public NewCar(String color) {
		this.color = color;
	}

	public double getSpeed() {
		return MileToKillo(speed); //get 은 다 마일을 킬로로 바꿔주면됨.
	}

	public void setSpeed(double speed) {
		this.speed = speed;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public boolean speedUp(double speedUp) {//speed = killotomile(speed); 쓰면 됨. 
		if (killoToMile(MAX_SPEED) > killoToMile(speedUp) && killoToMile(speedUp) > 0) {
			speed += killoToMile(speedUp);
			return true;
		} else {
			return false;
		}
	}

	public double getMaxSpeed() {
		return MAX_SPEED; // miletokillo(max_speed)로.
	}

	private static double killoToMile(double distance) {
		return distance / 1.6;
	}

	private static double MileToKillo(double distance) {
		return distance * 1.6;
	}

}
