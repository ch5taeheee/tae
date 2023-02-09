package presentation;

import java.util.ArrayList;
import java.util.List;

public class HorseRace2 {
	public static int rank = 1;

	public static void main(String[] args) {
	


		List<Horse> horseList = new ArrayList<>();
		horseList.add(new Horse("1번마"));
		horseList.add(new Horse("2번마"));
		horseList.add(new Horse("3번마"));
		horseList.add(new Horse("4번마"));
		horseList.add(new Horse("5번마"));
		horseList.add(new Horse("6번마"));
		horseList.add(new Horse("7번마"));
		horseList.add(new Horse("8번마"));
		horseList.add(new Horse("9번마"));
		horseList.add(new Horse("10번마"));
		
		
		for(Thread th : horseList) {
			th.start();
		}	

		Thread th1 = new Photographer(horseList);
		th1.setDaemon(true);
		th1.start();
		
		for(Thread th : horseList) {
			try {
				th.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("-----------------------");
		System.out.println("  경기\t\t결과");
		System.out.println("-----------------------");
		
		for (Horse horse : horseList) {
			System.out.println("  " + horse.getName() +"  \t"+ horse.getRank() + "등");
		}
		
		
		
		
	}
}

class Horse extends Thread implements Comparable<Horse>{
	
	private int rank;

	private int speed;
	
	
	public Horse() {
	}
	
	public Horse(String name) {
		super(name);
	}
	

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public int getSpeed() {
		return speed;
	}


	@Override
	public int compareTo(Horse horse) {
		return new Integer(this.rank).compareTo(horse.rank);
	}

	@Override
	public void run() {
		
		for(speed=0; speed<50; speed++) {
		
			try {
				Thread.sleep((int)(Math.random() * 500 + 50));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println(this.getName() + "도착...");
		setRank(HorseRace2.rank++);
	}
}




//----------------------------------------------
class Photographer extends Thread{
	private List<Horse> list;
	private int speed;
	
	public Photographer(List<Horse> list ) {
		this.list = list;
		
	}
	
	
	 	@Override
	public void run() {
	 	while(speed < 50) {	
	 	
	 	for (Horse horse : list) {
	 		speed = horse.getSpeed();

	 		System.out.print(horse.getName());
				
	 		for(int j=0; j< speed; j++) {
	 			System.out.print("-");
	 		}	
	 		System.out.print(">");
			
	 		for(int j=0; j< 50 - speed ; j++) {
	 			System.out.print("-");
	 		}
	 		System.out.println();
	 	}
	 	
	 	try {
			Thread.sleep(1000);
		} catch (InterruptedException e1) {
			e1.printStackTrace();
		}
	 	System.out.println();
	 	}
	 }
}

