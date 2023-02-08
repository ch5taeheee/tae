package kr.or.ddit.basic;

public class T14ThreadShareDataTest {
	/*
	 * 스레드에서 데이터를 공통으로 사용하는 방법
	 * 
	 * 1. 공통으로 사용할 데이터를 클래스로 정의한다. 
	 * 2. 공통으로 사용할 클래스의 인스턴스를 만든다. 
	 * 3. 이 인스턴스를 각각의 스레드에 넘겨준다. 
	 * 4. 각각의 스레드는 이 인스턴스의 참조값을 지정한 변수를 이용하여 공통 데이터를 사용한다.
	 * 
	 * 공유객체 사용 이유 =? 멀티 스레드일 경우 정보 공유를 위해 
	 * 
	 * 예) 원주율을 계산하는 스레드가 있고, 계산된 원주율을 출력하는 스레드가 있다. 원주율을 계산한 후 이 값을 출력하는 프로그램을
	 * 작성하시오.
	 * 
	 * 
	 */
	public static void main(String[] args) {
		
		ShareData sd = new ShareData();
		Thread th1 = new CalcPIThread(sd);
		Thread th2 = new PirntPIThread(sd);
		
		th1.start();
		th2.start();

	}
}

//원주율을 관리하는 클래스(공통으로 사용할 클래스)
class ShareData {
	private double result; // 원주율이 저장될 변수
	volatile boolean isOk; // 원주율 계산이 완료되었는지를 확인하기 위한 변수
	
	/*
	 	volatile => 선언된 변수를 컴파일러의 최적화 대상에서 제외시킨다. 
	 				즉, 값이 변경되는 즉시 변수에 적용시킨다. 
	 				멀티스레드 환경에서 하난의 변수가 완벽하게 한번에 작동하도록 보장하는 키워드(일종의 동기화)
	 */

	public double getResult() {
		return result;
	}

	public void setResult(double result) {
		this.result = result;
	}

	public boolean isOk() {
		return isOk;
	}

	public void setOk(boolean isOk) {
		this.isOk = isOk;
	}

}

// 원주율 계산하는 스레드
class CalcPIThread extends Thread {
	private ShareData sd;

	public CalcPIThread(ShareData sd) {
		super();
		this.sd = sd;
	}

	@Override
	public void run() {
		/*
		 * 원주율 = (1/1-1/3+1/5-1/7+1/9....) *4; 1 - 3 + 5 - 7 + 9 => 분모 0 1 2 3 4 => 2로
		 * 나눈 몫
		 */

		double sum = 0.0;
		for (int i = 1; i <= 1500000000; i += 2) {
			if (((i / 2) % 2) == 0) { // 로 나눈 몫이 짝수이면 ... +
				sum += (1.0 / i);

			} else {
				sum -= (1.0 / i);
			}

		}
		sd.setResult(sum * 4); // 계산된 원주율 공통객체에 저장하기
		sd.setOk(true); // 계산이 완료되었음을 저장함.

	}

}

// 계산된 원주율을 출력하는 스레드

class PirntPIThread extends Thread {
	private ShareData sd;

	public PirntPIThread(ShareData sd) {
		this.sd = sd;
	}

	@Override
	public void run() {
		while (true) {
			if (sd.isOk()) {
				break;
			}
		}
		System.out.println();
		System.out.println("계산된 원주율 : " + sd.getResult());
		System.out.println("       pi : " + Math.PI);
	}
}
