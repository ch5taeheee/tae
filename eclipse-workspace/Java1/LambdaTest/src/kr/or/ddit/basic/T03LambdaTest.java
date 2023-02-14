package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

public class T03LambdaTest {
	public static void main(String[] args) {
		List<Integer> list = new ArrayList<>();

		list.add(1);
		list.add(2);
		list.add(3);

		for (Integer i : list) {
			System.out.println(i);
		}
		System.out.println();

		list.forEach(new Consumer<Integer>() {// 리턴타입은 없고, 매개변수가 1나인 consumer?

			@Override
			public void accept(Integer t) {
				System.out.println(t + 100);
			}

		});
		list.forEach(a -> System.out.println(a + 100));

	}
}
