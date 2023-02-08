package work;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class HorseGame {
	public static void main(String[] args) {
		String rrank = " ";

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

		for (Horse th : horselist) {
			th.start();
			System.out.println();
		}
		for (Horse th2 : horselist) {
			try {
				th2.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	for(Horse th3 : horselist) {
		th3.start();
	}

		Collections.sort(horselist);

		System.out.println("경기 끝");
		System.out.println("==============================");
		System.out.println("경기 결과");
		System.out.println("순위 : " + rrank);

	}
}

class Horse extends Thread implements Comparable<Horse> {
	private String horsename;
	private int rank;
	private int currentposition;

	public int getCurrentposition() {
		return currentposition;
	}

	public void setCurrentposition(int currentposition) {
		this.currentposition = currentposition;
	}

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

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	@Override
	public void run() {
		System.out.println(gethorsename() + " : ");
		for (int i = 0; i <= 50; i++) {
			currentposition = i;

			try {
				Thread.sleep((int) Math.random() * 700);
			} catch (InterruptedException e) {
				e.printStackTrace();

			}
		}
	}

	@Override
	public int compareTo(Horse hs) {

		return Integer.compare(this.getRank(), hs.getRank());
	}

	@Override
	public String toString() {
		return String.format("%d등", horsename, rank);
	}

}

class Road extends Thread {
	private Horse hhh;

	public Road(Horse hhh) {
		super();
		this.hhh = hhh;
	}

	public Horse getHhh() {
		return hhh;
	}

	public void setHhh(Horse hhh) {
		this.hhh = hhh;
	}

	@Override
	public void run() {
		for (int i = 1; i <= 50; i++) {
			if (hhh.getCurrentposition() == i) {
				System.out.print(">");
			} else {
				System.out.println("-");
			}

		}
		try {
			Thread.sleep(400);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	}

}
