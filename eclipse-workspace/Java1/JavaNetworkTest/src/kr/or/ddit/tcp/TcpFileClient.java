package kr.or.ddit.tcp;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.Socket;

public class TcpFileClient {

	private Socket socket;
	private FileOutputStream fos;
	private DataInputStream dis;
	private DataOutputStream dos;

	public void clientStart() {
		File file = new File("d:/D_Other/윤정.png");

		try {
			socket = new Socket("192.168.141.34", 7777);

			// 소켓접속이 성공하면 받고 싶은 파일명을 전송한다.
			dos = new DataOutputStream(socket.getOutputStream());
			dos.writeUTF(file.getName());

			dis = new DataInputStream(socket.getInputStream());

			String resultMsg = dis.readUTF();

			if (resultMsg.equals("OK")) { // 받고 싶은 파일이 존재하는 경우

				fos = new FileOutputStream(file);

				BufferedInputStream bis = new BufferedInputStream(socket.getInputStream());
				BufferedOutputStream bos = new BufferedOutputStream(fos);

				int data = 0;

				while ((data = bis.read()) != -1) {
					bos.write(data);
				}
				bis.close();
				bos.close();

				System.out.println("파일 다운로드 완료");

			}

		} catch (Exception e) {
			// TODO: handle exception
		} finally {
			try {
				socket.close();
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) {
		 new TcpFileClient().clientStart();
	}

}
