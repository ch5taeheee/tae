package kr.or.ddit.udp;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.SocketException;

public class UdpFileReceiver {

	private DatagramPacket dp;
	private DatagramSocket ds;

	private byte[] buffer;

	public UdpFileReceiver(int port) {
		try {
			ds = new DatagramSocket(port);

		} catch (SocketException e) {
			e.printStackTrace();
		}
	}

	public void start() {
		long fileSize = 0;
		long totalReadBytes = 0;

		int readBytes = 0;

		System.out.println("파일 수신 대기 중");

		String str = new String(receiveData().trim());
	}

	
	/**
	 * 데이터 수신하기
	 * @return 수신된 바이트 배열 데이터
	 * @throws IOException
	 */
	public byte[] receiveData() throws IOException {
		buffer = new byte[1000]; // 버퍼 초기화

		dp = new DatagramPacket(buffer, buffer.length);
		ds.receive(dp);
		
		return dp.getData();
		

	}
}
