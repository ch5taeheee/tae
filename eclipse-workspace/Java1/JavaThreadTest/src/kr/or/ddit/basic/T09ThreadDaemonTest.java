package kr.or.ddit.basic;

/**
 * 데몬 스레드 예제 자동 저장하는 기능을 제공하는 스레드(3초에 한번씩 저장하기)
 * 데몬 스레드 : 일반스레드 보조하는 스레드
 */
public class T09ThreadDaemonTest {
	public static void main(String[] args) {
		
		Thread th = new AutoSaveThread();

		// 데몬 스레드로 설정하기(start()메서드를 호출하기 전에 설정해야 한다.)
		th.setDaemon(true);
		th.start();
		
		try {
			for(int i =1; i<=20; i++) {
				System.out.println("작업 " + i);
				Thread.sleep(1000);
			}
			
		} catch (InterruptedException ex) {
			ex.printStackTrace();
		}
		System.out.println("메인 스레드 종료...");

	}

}

class AutoSaveThread extends Thread {
	public void save() {
		System.out.println("작업 내용을 저장합니다..");
	}

	@Override
	public void run() {
		while (true) {
			try {
				Thread.sleep(3000);

			} catch (InterruptedException e) {
				e.printStackTrace();
			}

			save(); // 저장기능호출
		}
	}
}
