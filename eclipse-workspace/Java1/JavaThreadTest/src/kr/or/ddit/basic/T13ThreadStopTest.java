package kr.or.ddit.basic;

public class T13ThreadStopTest {
	public static void main(String[] args) {

		/* Thread th1 = new ThreadStop1();
		th1.start();

		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}*/
		
		/*
		 * Thread의 stop() 메서드를 호출하면 스레드가 바로 멈춘다. 이 때 사용하던 자원을 정리하지 못하고 프로그램이 종료되어서 나중에
		 * 실행되는 프로그램에 영향을 줄 수 있다. 그래서 현재는 비추천으로 되어 있다.
		 */
		// th1.stop();

		//((ThreadStop1) th1).setisStoped(true);
////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		Thread th2 = new ThreadStop2();
		th2.start();
		
		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		th2.interrupt(); // 인터럽트 걸기
		
	}

}

class ThreadStop1 extends Thread {
	private boolean isStoped;

	public boolean isStoped() {
		return isStoped;
	}

	public void setisStoped(boolean isStoped) {
		this.isStoped = isStoped;
	}

	@Override
	public void run() {
		while (!isStoped) {
			System.out.println("스레드 처리 작업 중...");

		}
		System.out.println("자원 정리 중...");
		System.out.println("실행종료.");
	}

}

// interrupt() 메서드를 이용한 스레드 중지 방법
class ThreadStop2 extends Thread {

	@Override
	public void run() {
		/*
		 * 방법 1 => sleep() 메서드나 join() 메서드 등을 사용했을 때 interrupt() 메서드를 호출하면
		 * InterruptedException 이 발생한다.
		 * 
		 */

		/*try {
			while (true) {
				System.out.println("스레드 처리 작업 중...");
				Thread.sleep(1);
			}
		} catch (InterruptedException ex) {

		}*/
		/////////////////////////////////////////////////////////////////////////////////////////
		
		// 방법2 => interrupt()호출되었는지 검사하여 처리하기
		while(true) {
			System.out.println("스레드 처리 작업 중...");
			
		// 검사 방법 1 => 스레드의 인스턴스 메서드 를 이용하는 방법
			// 검사 방법 1 => 스레드의 인스턴스 메서드 를 이용하는 방법
			/* if(this.isInterrupted()) {
				System.out.println("인스턴스용 isInterrupted() 호출됨.");
				break; */
		
		// 검사 방법 2 => 스레드 클래스의 정적 메서드를 이용하는 방법
			if(Thread.interrupted()) {
				System.out.println("정적 메서드 interupted() 호출됨.");
				break;
			}
		}
		
		System.out.println("자원 정리 중...");
		System.out.println("실행종료.");
	}

}