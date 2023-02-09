package report;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

public class HorseRace {
	public static int rank = 0;
	public static int wait = 1;

	public static void main(String[] args) {
		List<Horse> horses = new ArrayList<>();
		List<Thread> horseList = new ArrayList<>();
		horses.add(new Horse("1번말"));
		horses.add(new Horse("2번말"));
		horses.add(new Horse("3번말"));

		for (Horse h : horses) {
			horseList.add(new RaceThread(h));
		}
		
		for (Thread th : horseList) {
			th.start();
		}

		for (Thread th : horseList) {
			try {
				th.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

		Collections.sort(horses);

		for (Horse h : horses) {
			if (h.getRank() == 1) {
				System.out.println(h + " 우승!");
			} else {
				System.out.println(h);
			}
		}
	}
}

class RaceThread extends Thread {
	Horse horse;
	String[] stadium;

	public RaceThread(Horse horse) {
		stadium = new String[50];
		stadium[0] = ">";
		for (int i = 1; i < stadium.length; i++) {
			stadium[i] = "-";
		}
		this.horse = horse;
	}

	@Override
	public void run() {
		String position;
		int i = 0;
		
		try {
			Thread.sleep(HorseRace.wait++);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		while (stadium[stadium.length - 1] != ">") {
			try {
				Thread.sleep(new Random().nextInt(500));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			position = stadium[i];
			stadium[i] = stadium[i + 1];
			stadium[i + 1] = position;

			i++;
			System.out.print(horse.getName());
			System.out.println();
			for (String str : stadium) {
				System.out.print(str);
			}
			System.out.println();
		}

		horse.setRank(++HorseRace.rank);

		return;
	}
}