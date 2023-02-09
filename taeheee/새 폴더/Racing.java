package homework;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

public class Racing {
	static int currRank = 1; // 현재 순위정보
	
	public static void main(String[] args) {
		List<Horse> horseList = new ArrayList<>();
		
		horseList.add(new Horse(" 1번말"));
		horseList.add(new Horse(" 2번말"));
		horseList.add(new Horse(" 3번말"));
		horseList.add(new Horse(" 4번말"));
		horseList.add(new Horse(" 5번말"));
		horseList.add(new Horse(" 6번말"));
		horseList.add(new Horse(" 7번말"));
		horseList.add(new Horse(" 8번말"));
		horseList.add(new Horse(" 9번말"));
		horseList.add(new Horse("10번말"));
		
		
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
		
		System.out.println("경기 끝...");
		System.out.println();
		
		System.out.println("**** 순위 ****");
		Collections.sort(horseList);
		for (Horse h : horseList) {
			System.out.println(h);
		}
	}
}

/**
 * 말이 달리는 상황을 출력하는 클래스
 */

class Horse extends Thread implements Comparable<Horse> {
	private String name;
	private int rank;
	

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}
	
	public Horse(String name) {
		super(name);
		this.name = name;
	}
	
	@Override
	public void run() {
		for(int i = 0; i <= 50 ; i++) {
			List<String> numList = new ArrayList<>();
			numList.add(name + " : ");
			for(int j = 0; j < i; j++) {
				numList.add("-");
			}
			numList.add(">");
			for (int j = 50; j > i; j--) {
				numList.add("-");
			}
			System.out.println(numList.toString().replace(", ", "").substring(1, 59));
			
			try {
				// 200 ~ 500 ms 사이의 정지상태가 일어남
				Thread.sleep((int)(Math.random() * 301 + 200));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println(name + " 도착!");
		
		setRank(Racing.currRank++); // 현재 순위정보 설정
	}

	@Override
	public String toString() {
		return "[" + name + " " + rank + "등 ]";
	}

	@Override
	public int compareTo(Horse o) {
		return Integer.compare(rank, o.getRank()) * 1;
	}
}
