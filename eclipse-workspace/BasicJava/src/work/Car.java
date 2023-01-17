package work;

public class Car {
	private double speed;
	private String color;
	private static final double MAX_SPEED=200.0;
	
	public Car() {
	}
	public Car(String color) {
		this.color = color;
	}
	public double getSpeed() {
		return speed;
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
	public boolean speedUp(double speedUp) { //SPEEDUP(DOUBLE SPEED) IF (THIS.SPEED + SPEED > 0 && THIS.SPEED + SPEED < =MAX_SPEED) THIS SPEED += SPEED; RETURN TURE;
		if(speedUp > 0 && speedUp<= MAX_SPEED) {
			this.speed += speedUp;
			return true; // RETURN이 있으면 ELSE 안 써도 됨. 
		} else {
			return false;
		}
	} 
	public static double getMaxSpeed() {
		return MAX_SPEED;
	}
	
}
