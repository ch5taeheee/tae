package chapter08;

import chapter08.Apple.Color;

public class Utils {
	public static Apple[] filter(Apple[] apples, Predicate predicate) {// 매개변수 다르게 하면 똑같은 실행을 할 수 있따?
		Apple[] retApples = new Apple[apples.length];
		for (int i = 0; i < retApples.length; i++) {
			if (predicate.test(apples[i])) {
				retApples[i] = apples[i];
			}
		}

		return retApples;

	}
}
