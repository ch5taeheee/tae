package kr.or.ddit.basic;

public class T15SyncThreadTest {
	public static void main(String[] args) {
		ShareObject sObj = new ShareObject();
		
		Thread th1 = new WorkThread("1번 스레드", sObj);
		Thread th2 = new WorkThread("2번 스레드", sObj);
	
		th1.start();
		th2.start();
	}

}

//공유되어서 쓰레드가 동시에 작업을 한 지역 을 임계지역(영역) 동기화가 필요하다. 

//공통으로 사용할 클래스
class ShareObject {
	private int sum = 0;
	// 싱크로 단점 ;> 성능 떨어짐
	//동기화 하는 방법1 : 메서드 자체에 동기화 설정하기
	// synchronized public void add() { // synchronized 하나씩 작업 -> blocked(일시정지상태) ; 동기화 처리로 인해 발생, 한 작업이 끝나야지 다음 작업 가능 
	public void add() {
		for(int i =0; i<1000000000; i++) {} // 동기화 처리 전까지 시간벌기용
		
		
	    // 동기화 하는 방법2 : 동기화 블럭으로 설정하기
		// mutex : Mutual exclusion object(상호 배제 : 동시접근 차단)
		
		//synchronized (this) { 
			
		
		
		int n = sum;
		
		n += 10;
		
		sum = n;
		System.out.println(Thread.currentThread().getName() + "합계 : " + sum);
		//}
	}
}

// 작업을 수행하는 스레드
class WorkThread extends Thread {
	private ShareObject sObj;
	
	public WorkThread(String name, ShareObject sObj) {
		super(name);
		this.sObj = sObj;
	}
	
	@Override
	public void run() {
		for(int i = 1; i<=10; i++) {
			synchronized (sObj) {
				
			
			sObj.add();
			}
		}
	}
}