package kr.or.ddit.tcp;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;

public class TcpSocketServerTest {
	public static void main(String[] args) throws IOException {
		
	
	// 소켓이란 ? 두 호스트 간 통신을 하기 위한 양 끝단(Endpoint)을 말한다. 
	
	// TCP 소켓 통신을 하기 위해 ServerSocket 객체 생성
	ServerSocket server = new ServerSocket(7777);
	System.out.println("서버가 접속을 기다립니다...");
	
	// accept()는 클라이언트에서 연결 요청이 올 때까지 계속 기다린다.
	// 연결 요청이 오면 Socket객체를 생성해서 클라이언트의 Socket과 연결한다.
	Socket socket = server.accept();
	
	// --------------------------------------------------------
	// 이 이후는 클라이언트와 연결된 후의 작업을 진행하면 된다.
	
	System.out.println("접속한 클라이언트 정보");
	System.out.println("IP주소 : " + socket.getInetAddress());
	
	// 클라이언트에 메세지 보내기
	
	// 소켓에서 OutputStream객체를 꺼내 사용한다. //메세지보내기위해
	OutputStream out = socket.getOutputStream();
	
	DataOutputStream dos = new DataOutputStream(out);
	dos.writeUTF("어서오세요"); // 메세지 보내기 //
	
	dos.close();
	
	System.out.println("메세지를 보냈습니다.");
	
	server.close(); //서버소켓 종료.
	
	
	}

}
