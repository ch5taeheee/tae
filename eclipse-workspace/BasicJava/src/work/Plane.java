package work;

public class Plane {
	private String manufacturer;
	private String model;
	private int maxNumberOfPassengers;
	private static int numberOfPlanes;

	public Plane() {
		
		numberOfPlanes++;
	}

	public Plane(String manufacturer, String model, int maxNumberOfPassengers) {
		this(); //numberOfPlanes++;
		this.manufacturer = manufacturer;
		this.model = model;
		this.maxNumberOfPassengers = maxNumberOfPassengers;
		
	}


	public void setmanufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setmodel(String model) {
		this.model = model;
	}

	public String getModel() {
		return model;
	}

	public static int getNumberOfPlanes() {
		return numberOfPlanes;
	}

	public int getMaxNumberOfPassengers() {
		return maxNumberOfPassengers;
	}

	public void setMaxNumberOfPassengers(int maxNumberOfPassengers) {
		if (maxNumberOfPassengers > 0) {
			this.maxNumberOfPassengers = maxNumberOfPassengers;
		}

	}

	public String toString() {
		return String.format("%d",numberOfPlanes);
	}

}
