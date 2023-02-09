package wwork;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

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

		for (Thread th1 : horselist) {
			th1.start();
			System.out.println();
		}

		for (Thread th2 : horselist) {
			try {
				th2.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}

		}
		Thread th3 = new Road(horselist);
		th3.start();

		try {
			th3.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		Collections.sort(horselist);

		System.out.println("========================================");
		System.out.println("경기 끝");
		System.out.println("========================================");
		System.out.println("경기 결과");
		System.out.println("순위");

	}

}

//========================================================================
class Horse extends Thread implements Comparable<Horse> {
	private String hname; // 말 이름
	private int rank; // 순위
	private int position; // 위치

	public Horse(String hname) {
		super();
		this.hname = hname;
	}

	public Horse(int rank) {
		super();
		this.rank = rank;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public int getPosition() {
		return position;
	}

	public void setPosition(int position) {
		this.position = position;
	}

	public String getHname() {
		return hname;
	}

	@Override
	public String toString() {
		return hname + rank + "등 입니다.";
	}

	@Override
	public void run() { // 현재위치
		for (int i = 1; i <= 50; i++) {
			this.position = i;
		}
		// 속도 조절
		try {
			Thread.sleep((int) Math.random() * 10000 +500);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int compareTo(Horse hs) {
		return Integer.compare(this.getRank(), hs.getRank());
	}
}

//================================================================
class Road extends Thread {
	private Horse hhh;
	private List<Horse> hhhh;

	public Road(Horse hhh) {
		super();
		this.hhh = hhh;
	}

	public Road(List<Horse> hhhh) {
		super();
		this.hhhh = hhhh;
	}

	public List<Horse> getHhhh() {
		return hhhh;
	}

	public void setHhhh(List<Horse> hhhh) {
		this.hhhh = hhhh;
	}

	public Horse getHhh() {
		return hhh;
	}

	public void setHhh(Horse hhh) {
		this.hhh = hhh;
	}

	@Override
	public void run() {
		while (true) {
			if (hhh.getPosition() == 50) {

				for (int i = 0; i <= 10; i++) {
					System.out.println();
				}

				for (Horse hl : hhhh) {
					System.out.print(hl.getHname() + " : ");
					System.out.println();

					for (int i = 1; i <= 50; i++) {
						if (hl.getPosition() == i) {
							System.out.print(">");
						} else {
							System.out.print("-");
						}
					}
					System.out.println();

					try {
						Thread.sleep((int) Math.random() * 500);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}

				}
			}
		}
	}

}
