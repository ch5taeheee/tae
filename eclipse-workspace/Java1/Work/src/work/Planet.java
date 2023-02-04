package work;

public enum Planet {
	수성("2439"), 금성("6052"), 지구("6371"), 화성("3390"), 목성("69911"), 토성("58232"), 천왕성("25362"), 해왕성("24622");

	public static final Planet[] pl_arr = Planet.values();
	public String radius;

	private Planet(String radius) {
		this.radius = radius;
	}

	public String getRadius() {
		return radius;
	}

//	@Override
//	public String toString() {
//		return name() + getRadius();
//	}

}

class PlanetExample {
	public static void main(String[] args) {

		Planet[] pl_arr = Planet.values();
		for (int i = 0; i < pl_arr.length; i++) {
			System.out.println(pl_arr[i].name() + "(" + pl_arr[i].radius + ")");

		}
	}
}
