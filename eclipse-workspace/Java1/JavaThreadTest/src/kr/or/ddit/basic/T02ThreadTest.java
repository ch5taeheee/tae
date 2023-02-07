package kr.or.ddit.basic;

public class T02ThreadTest {
	// 항상 DEFAULT로 메인 스레드 있음.
	// 2개의 스레드 실행 => 멀티 스레드
	// 다중 상속이 안되기 때문에 2,3번째 방법o

	public static void main(String[] args) {
		// 멀티 스레드 프로그램 방식

		// 방법1: Thread 클래스를 상속한 클래스의 인스턴스를 생성한 후 이 인스턴스의 start() 메서드를 호출한다.
		MyThread1 th1 = new MyThread1();
		th1.start(); //메인 스레드가 run으로 실행하면 순차적으로 실행 -> 스레드가 하나인 것 처럼 실행
		//start -> 동시에 실행 
		

		// 방법2 : Runnable 인터페이스를 구현한 클래스의 인스턴스를 생성한 후 /Runnable : void run 추상메서드를 가지고 있음/
		// 이 인스턴스를 Thread객체를 생성할 때의 생성자의 파라미터로 넘겨준다.
		// 이 때 생성된 Thread객체의 start() 메서드를 호출한다..

		Runnable r = new MyRunnable();
		Thread th2 = new Thread(r);
		th2.start();

		// 방법3 : 익명클래스를 이용하는 방법
		// Runnable 인터페이스를 구현한 익명클래스를 Thread 인스턴스를 생성할 때
		// 파라미터로 넘겨준다.
		Thread th3 = new Thread(new Runnable() {

			@Override
			public void run() {
				for (int i = 1; i <= 200; i++) {
					System.out.print("@");

					try {
						Thread.sleep(100);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
				}
			}
		});
		th3.start();

	}
}

class MyThread1 extends Thread {

	@Override
	public void run() {
		for (int i = 1; i <= 200; i++) {
			System.out.print("*");

			try {
//				Thread.sleep(100); => 주어진 시간동안 잠시 멈춘다.
//				시간은 밀리세컨드 단위를 사용한다. 즉 1000은 1초를 의미한다.
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

}

class MyRunnable implements Runnable {

	@Override
	public void run() {
		for (int i = 1; i <= 200; i++) {
			System.out.print("$");

			try { // 아직 스레드 객체 아님. 엄밀히 말하면 Runnable 객체
				Thread.sleep(100);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}

	}

}
