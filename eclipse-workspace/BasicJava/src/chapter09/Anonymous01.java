package chapter09;

public class Anonymous01 {
	Vehicle field = new Vehicle() {
		public void run() {
			System.out.println("자전거가 달립니다.");
		}
	};

	void method1() {
		Vehicle localVal = new Vehicle() {
			public void run() {
				System.out.println("승용차가 달립니다.");

			}
		};

		localVar.run();
	}

	void method2(Vehicle v) {
		vehicle.run();
	}

}
