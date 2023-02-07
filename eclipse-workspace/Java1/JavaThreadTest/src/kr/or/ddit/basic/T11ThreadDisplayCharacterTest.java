package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

public class T11ThreadDisplayCharacterTest {
	/*
	 * 3개(명)의 스레드가 각각 알파벳 대문자를 출력하는데 출력을 끝낸 순서대로 결과를 나타내는 프로그램을 작성하시오.
	 */
	static int currRank = 1; // 현재 순위 정보

	public static void main(String[] args) {
		List<DisplayCharacter> disCharList = new ArrayList<>();
		disCharList.add(new DisplayCharacter("홍길동"));
		disCharList.add(new DisplayCharacter("일지매"));
		disCharList.add(new DisplayCharacter("변학도"));
		disCharList.add(new DisplayCharacter("성춘향"));
		
		for(Thread th : disCharList) {
			th.start();
		}
		for(Thread th : disCharList) {
			try {
				th.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("경기 끝");

	}
}

/**
 * 알파벳 대문자 출력을 하는 스레드 클래스
 */
class DisplayCharacter extends Thread {
	private String name;
	private int rank;


	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public DisplayCharacter(String name) {
		super(name); // 스레드 이름?
		this.name = name;
	}

	@Override
	public void run() {
		for (char ch = 'A'; ch <= 'Z'; ch++) {
			System.out.println(name + "의 출력 문자 : " + ch);

			try {
				// 200 ~ 500 ms 사이의 정지상태가 일어남
				Thread.sleep((int) (Math.random() * 301 + 200));
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println(name + "출력 끝");

		setRank(T11ThreadDisplayCharacterTest.currRank++); // 현재 순위정보 설정

	}
}