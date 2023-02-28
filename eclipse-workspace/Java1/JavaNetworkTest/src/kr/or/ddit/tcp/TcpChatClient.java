package kr.or.ddit.tcp;

import java.io.IOException;
import java.net.Socket;

public class TcpChatClient {
	public static void main(String[] args) throws IOException {
		
		Socket socket = new Socket("192.168.141.10",8888);
		
		System.out.println("클라이언트 접속 중");
		
		Sender sender = new Sender(socket);
		Receiver receiver = new Receiver(socket);
		
		sender.start();
		receiver.start();
		
		
	}

}
