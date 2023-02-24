package kr.or.ddit.tcp;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Scanner;

public class MultiChatClient {

	// 시작 메서드
	public void clientStart() {

		Socket socket = null;

		try {

			socket = new Socket("192.168.141.34", 7777);

			System.out.println("서버에 연결되었습니다.");
			
			ClientSender clientSender = new ClientSender(socket);
			clientSender.start();
			
			ClientReceiver clientReceiver = new ClientReceiver(socket);
			clientReceiver.start();

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	// 메시지를 전송하는 스레드
	class ClientSender extends Thread {
		
		private DataOutputStream dos;
		private Scanner scan = new Scanner(System.in);

		public ClientSender(Socket socket) {
			try {
				dos = new DataOutputStream(socket.getOutputStream());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {
			if (dos != null) {
				// 시작하자마자 자신의 대화명을 서버로 전송
				System.out.println("대화명 >> ");

				try {
					dos.writeUTF(scan.nextLine());

				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			while (dos != null) {
				// 키보드로 입력받은 메시지를 서버로 전송

				try {
					dos.writeUTF(scan.nextLine());

				} catch (IOException e) {
					e.printStackTrace();
				}

			}

		}

	}

	// 메시지를 받는 스레드
	class ClientReceiver extends Thread {
		private DataInputStream dis;

		public ClientReceiver(Socket socket) {
			try {
				dis = new DataInputStream(socket.getInputStream());

			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		@Override
		public void run() {
			while (dis != null) {
				try {
					// 서버로부터 수신한 메시지 출력하기
					System.out.println(dis.readUTF());

				} catch (IOException e) {
					e.printStackTrace();
				}

			}

		}
	}
	public static void main(String[] args) {
		new MultiChatClient().clientStart();
	
	}

}
