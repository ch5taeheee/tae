package homework;

import java.util.Arrays;

public class HorseRacing {
	public static void main(String[] args) {
		Horse[] hsList = new Horse[]{
			new Horse("01번마"),
			new Horse("02번마"),
			new Horse("03번마"),
			new Horse("04번마"),
			new Horse("05번마"),
			new Horse("06번마"),
			new Horse("07번마"),
			new Horse("08번마"),
			new Horse("09번마"),
			new Horse("10번마")
		};
		
		Display ds = new Display(hsList);
		
		for(Horse hs : hsList) {
			hs.start();
		}
		ds.start();
		
		for(Horse hs : hsList) {
			try {
				hs.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		try {
			ds.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		System.out.println();
		System.out.println("[경기 끝]");
		System.out.println("================================================");
		
		Arrays.sort(hsList);
		
		System.out.println("경기 결과");
		for(Horse hs : hsList) {
			System.out.println(hs.getRank() + "등 : " + hs.getHorseName());
		}
	}
}

class Horse extends Thread implements Comparable<Horse>{
	private String horseName;
	private int rank;
	private int location;
	public static int currentRank = 0;
	
	public String getHorseName() {
		return horseName;
	}

	public void setHorseName(String horseName) {
		this.horseName = horseName;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public Horse(String horseName) {
		super();
		this.horseName = horseName;
	}

	public int getLocation() {
		return location;
	}
	
	public void setLocation(int location) {
		this.location = location;
	}
	
	@Override
	public void run() {
		for(int i = 1; i <= 50; i++) {
			location = i;
			try {
				Thread.sleep((int)(Math.random()*300));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		rank = ++Horse.currentRank;
	}

	@Override
	public int compareTo(Horse hs) {
		return new Integer(this.getRank()).compareTo(hs.getRank());
	}

}

class Display extends Thread {
	private Horse[] horses;
	
	public Display(Horse[] horses) {
		this.horses = horses;
	}

	@Override
	public void run() {
		while(true) {
			if(Horse.currentRank == horses.length) {
				break;
			}
			
			System.out.println();
			System.out.println();
			System.out.println();
			
			for (int i = 0; i < horses.length; i++) {
				System.out.print(horses[i].getHorseName()+ " : ");
				for (int j = 1; j <= 50; j++) {
					if(horses[i].getLocation() == j) {
						System.out.print(">");
					}else {
						System.out.print("-");
					}
				}
				System.out.println();
			}
			
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}