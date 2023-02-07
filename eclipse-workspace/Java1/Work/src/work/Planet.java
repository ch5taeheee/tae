package work;

import java.util.Scanner;

public enum Planet {
	수성("2439"), 금성("6052"), 지구("6371"), 화성("3390"), 목성("69911"), 토성("58232"), 천왕성("25362"), 해왕성("24622");

	public static final Planet[] pl_arr = Planet.values();
	public String radius;

	private Planet(String data) {
		this.radius = data;

	}

	public String getRadius() {
		return radius;
	}

	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		System.out.print("행성이름 : ");
		String pp = scanner.nextLine();
		for (int i = 0; i < pl_arr.length; i++) {
			if (pl_arr[i].name().equals(pp)) {
				System.out.println(pl_arr[i].name() + "의 면적은"
						+ (Double.valueOf(pl_arr[i].radius)) * (Double.valueOf(pl_arr[i].radius)) * 4 * Math.PI
						+ "입니다.");
			}

		}

	}
}
