package kr.or.ddit.basic;

public class T12ThreadYieldTest {
	/*
	 * yield() 메서드에 대하여...
	 * 
	 * 1. 현재 실행 대기 중인 동등한 우선순위 이상의 다른 스레드에게 실행기회를 제공한다.(양보) 2. 현재 실행중인 스레드의 상태를
	 * RUNNABLE 상태로 바꾼다. (WAITING 이나 BLOCKED 가 아니라..) 3. yield() 메서드를 실행한다고 해서 현재 실행
	 * 중인 스레드가 곧바로 RUNNABLE 상태로 전이된다고 확신할 수는 없다..
	 * 
	 */

	public static void main(String[] args) {
		
		new YieldThread1().start();
		new YieldThread2().start();

	}

}

class YieldThread1 extends Thread {
	public YieldThread1() {
		super("양보 스레드");
	}

	@Override
	public void run() {
		for (int i = 0; i < 10; i++) {
			System.out.println(Thread.currentThread().getName() + " : " + i);
			for (int j = 0; j < 1000000000; j++) {
			}

			Thread.yield(); // 양보하기
		}
	}
}

class YieldThread2 extends Thread {
	public YieldThread2() {
		super("비양보 스레드");
	}

	@Override
	public void run() {
		for (int i = 0; i < 10; i++) {
			System.out.println(Thread.currentThread().getName() + " : " + i);
			for (int j = 0; j < 1000000000; j++) {
			}
		}
	}
}
