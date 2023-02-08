package work;

import java.util.ArrayList;
import java.util.List;

public class HorseGame {
	public static void main(String[] args) {
		List<Horse> horselist = new ArrayList<>();
		horselist.add(new Horse("1번말"));
		horselist.add(new Horse("2번말"));
		horselist.add(new Horse("3번말"));
		horselist.add(new Horse("4번말"));
		horselist.add(new Horse("5번말"));
		horselist.add(new Horse("6번말"));
		horselist.add(new Horse("7번말"));
		horselist.add(new Horse("8번말"));
		horselist.add(new Horse("9번말"));
		horselist.add(new Horse("10번말"));

		for (Thread th : horselist) {
			th.start();
			System.out.println();
		}
		for (Thread th2 : horselist) {
			try {
				th2.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("경기 끝");

	}
}

class Horse extends Thread {
	private String horsename;
	private int rank;
	

	public Horse(String horsename) {
		super(horsename);
		this.horsename = horsename;
	}

	public String gethorsename() {
		return horsename;
	}

	public void sethorsename(String horsename) {
		this.horsename = horsename;
	}

	@Override
	public void run() {
		System.out.print(horsename + " : ");

		for (int i = 1; i <= 50; i++) {
				System.out.print(">");
		}

			try {
				Thread.sleep((int) Math.random() * 800);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}
class AutoSaveThread extends Thread {
	public void save() {
		System.out.println("작업 내용을 저장합니다..");
	}

	@Override
	public void run() {
		while (true) {
			try {
				Thread.sleep(500);

			} catch (InterruptedException e) {
				e.printStackTrace();
			}

			save(); // 저장기능호출
		}
	}
}

