package homework;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class HorseRace3 {
	public static void main(String[] args) {
		List<Horse> horses = new ArrayList<>();
		
		horses.add(new Horse("1번말")) ;
		horses.add(new Horse("2번말")) ;
		horses.add(new Horse("3번말")) ;
		horses.add(new Horse("4번말")) ;
		horses.add(new Horse("5번말")) ;
		horses.add(new Horse("6번말")) ;
		horses.add(new Horse("7번말")) ;
		horses.add(new Horse("8번말")) ;
		horses.add(new Horse("9번말")) ;
		horses.add(new Horse("10번말")) ;
		
		for (Horse hs : horses) {
			hs.start();
		}
		
		while(true) {
			for(int i=0; i<horses.size(); i++) {
				System.out.print(horses.get(i).name + " : ");
				for(int j=1; j<=50; j++) {
					if(horses.get(i).place == j) {
						System.out.print(">");
						continue;
					}
					System.out.print("-");
				}
				System.out.println();
			}
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		
			int exitCnt = 0;
			for(int i=0; i<horses.size(); i++) {
				if(horses.get(i).getState() == Thread.State.TERMINATED) {
					exitCnt++;
				}
			}
			if(exitCnt==10) {
				break;
			}
			System.out.println("\n===========================================");
		}
		
		System.out.println();
		Collections.sort(horses);
		System.out.println("===========경기 결과!!==========");
		for(Horse h : horses) {
			System.out.println(h);
		}
		
	}
}

class Horse extends Thread implements Comparable<Horse>{

	public static int setRank = 1;
	public String name;
	public int rank;
	public int place = 1;
	
	public Horse(String name) {
		this.name = name;
	}
	@Override
	public void run() {
		for(int i=0; i<=50; i++) {
			try {
				Thread.sleep((int)(Math.random() * 500));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			if(place<50) {
				place++;
			}
		}
		System.out.println(name + "경주 종료!!");
		rank = setRank++;
		System.out.println("순위는 : " + rank);
	}
	
	@Override
	public int compareTo(Horse h) {
		return Integer.compare(rank, h.rank);
	}
	@Override
	public String toString() {
		return name + " : " + rank + "등!!";
	}
	
}
