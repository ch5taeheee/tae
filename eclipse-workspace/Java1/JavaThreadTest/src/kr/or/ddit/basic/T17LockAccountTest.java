package kr.or.ddit.basic;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * 은행의 입출금 처리를 스레드로 처리하는 예제 
 * (Lock 객체를 이용한 동기화 처리)
 */
public class T17LockAccountTest {
	/*
	 * 락 기능을 제공하는 클래스
	 * 
	 * ReentrantLock : Read 및 Write 구분없이 사용하기 위한 락 클래스로 동기화 처리를 위해 사용된다. 
	 * 				   Synchronized를 이용한 동기화 처리보다 부가적인 기능이 제공됨.
	 * 				   ex) fairness 설정 등 => 가장 오래 기다린 스레드가 가장 먼저 락을 획득하게 함. 
	 * 
	 * ReentrantReadWriteLock : Read 및 Write 락을 구분하여 사용가능함.
	 * 							여러 스레드가 동시에 Read 작업은 가능하지만 Write 작업은 단지 하나의 스레드만 가능하다.(exclusive)
	 * 							=> Write 보다 Read 위주의 작업이 많이 발생하는 경우에 사용하면 처리량(Throughput)이 좋아진다. 
	 * 
	 */
	public static void main(String[] args) {
		
		Lock lock = new ReentrantLock(true); //fairness 설정 => true
		
		LockAccount lAcc = new LockAccount(lock);
		lAcc.deposit(10000);
		
		Thread th1 = new BankThread2(lAcc);
		Thread th2 = new BankThread2(lAcc);
		
		th1.start();
		th2.start();
	}

}


//입출금을 담당하는 클래스(공유객체)
class LockAccount{
	private int balance;
	
	//Lock 객체 생성 => 되도록이면 private final로 만든다. // 값바꾸지못하도록, 외부에서 접근 x
	private final Lock lock;
	
	public LockAccount(Lock lock) {
		this.lock = lock;
		
	}
	public int getBalance() {
		return balance;
		
	}
	//입금처리하는 메서드
	
	public void deposit(int money) {
		/*
		   Lock 객체의 lock()메서드가 동기화 시작이고, unlock() 메서드가 동기화의 끝을 나타낸다.
		   1ock() 메서드로 동기화를 설정한 곳에서는 반드시 unlock()메서드로 해제해 주어야 한다.
		 */
		lock.lock(); // 락 설정(락을 획득하기 전까지 BLOCKED 됨.)
		
		balance += money; // 동기화 처리 부분
	
		lock.unlock(); // 락 해제
	
	}
	
	// 출금하는 메서드(출금 성공 : true, 출금 실패 : false 반환함.
	
	public boolean wirhtdraw(int money) {
		boolean isOk = false;
		/*
		 * try ~ catch 블럭을 사용할 경우에는 unlock() 메서드 호출은 finally 블럭에서 하도록 한다. 
		 */
		
		try {
			lock.lock(); // 락 설정
			
			System.out.println(Thread.currentThread().getName()+"락 설정(획득) 성공!");
			
			if(balance >= money) {
				for(int i =0; i<1000000000; i++) {} // 시간 때우기
				
				 balance -= money;
				 
				 System.out.println("메서드 안에서 balance = " + getBalance());
			
			isOk = true;
			}
			
		} catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			lock.unlock(); //락 해제 
			System.out.println(Thread.currentThread().getName()+"락 해제(반납) 완료!");
		}
		return isOk;
		
	}
	
}

//은행 업무를 처리하는 스레드

class BankThread2 extends Thread {
	private LockAccount lAcc;

	public BankThread2(LockAccount lAcc) {
		this.lAcc = lAcc;
	}
	@Override
	public void run() {
		boolean result = lAcc.wirhtdraw(6000);
		
		System.out.println(Thread.currentThread().getName() + "스레드 안에서 result = " + result + ", balance = " + lAcc.getBalance());
			
	}	
	
}