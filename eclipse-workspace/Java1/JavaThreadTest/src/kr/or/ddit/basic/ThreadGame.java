package kr.or.ddit.basic;

import java.net.MulticastSocket;
import java.util.Random;

import javax.swing.JOptionPane;

public class ThreadGame {

	public static boolean inputCheck = false;
	public static String me = "";// 사용자의 가위바위보가 저장될 변수

	public static void main(String[] args) {
		Random random = new Random();
		String[] data = { "가위", "바위", "보" };
		int index = random.nextInt(3);
		String val = data[index];

		GameCountDown cd = new GameCountDown();
		cd.start();

		GameUserInput ui = new GameUserInput();
		ui.start();

		try {
			ui.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}

		String result = "";

		if (me.equals(val)) {
			result = "비겼습니다.";
		} else if (val.equals("가위") && me.equals("바위") || val.equals("바위") && me.equals("보")
				|| val.equals("보") && me.equals("가위")) {
			result = "사용자가 이겼습니다.";
		} else {
			result = "컴퓨터가 이겼습니다.";
		}
		
		System.out.println("===========결과 출력 =============");
		System.out.println("컴퓨터 : " + val );
		System.out.println("사용자 : " + me);
		System.out.println("결과 : " + result);

	}

}

class GameCountDown extends Thread {
	@Override
	public void run() {
		for (int i = 5; i > 0; i--) {
			if (ThreadGame.inputCheck == true) {
				return;
			}
			System.out.println(i);

			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();

			}
		}
		System.out.println("시간이 초과되었습니다. 컴퓨터가 이겼습니다.");
		System.exit(0);

	}

}

class GameUserInput extends Thread {
	@Override
	public void run() {

		String data = JOptionPane.showInputDialog("아무거나 입력하세요.");

		if (!data.equals("가위") && data.equals("바위") && data.equals("보")) {
			System.out.println("다시 입력하세요");

			return;
		}
		ThreadGame.inputCheck = true;
		ThreadGame.me = data;

	}

}
