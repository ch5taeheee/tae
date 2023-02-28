package kr.or.ddit.http;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.URLConnection;
import java.net.URLDecoder;
import java.util.StringTokenizer;

/**
 * 간단한 HttpServer 예제
 *
 */
public class MyHttpServer {

	private final int port = 80;
	private final String encoding = "UTF-8";

	/**
	 * Http 서버 시작
	 */
	public void start() {

		System.out.println("Http 서버가 시작되었습니다.");

		ServerSocket server = null;
		Socket socket = null;

		try {

			server = new ServerSocket(this.port);

			while (true) {

				socket = server.accept();

				// http 요청 처리하기
				HttpHandler handler = new HttpHandler(socket);
				handler.start();

			}

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				server.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}

	/*
	 * Http 요청 처리를 위한 스레드 클래스
	 */
	class HttpHandler extends Thread {
		private final Socket socket;

		public HttpHandler(Socket socket) {
			this.socket = socket;

		}

		@Override
		public void run() {
			OutputStream out = null;
			BufferedReader br = null;

			try {

				out = new BufferedOutputStream(socket.getOutputStream());
				br = new BufferedReader(new InputStreamReader(socket.getInputStream()));

				// 요청헤더 정보 파싱하기
				StringBuilder sb = new StringBuilder();

				// Request Line
				String reqLine = br.readLine(); // 첫 줄 읽어오기

				// printMsg("Request Line",reqLine);

				while (true) {
					String str = br.readLine();

					if (str.equals(""))
						break; // Empty line 체크

					sb.append(str + "\n");
				}

				// 헤더 정보(Header)
				String reqHeaderStr = sb.toString();

				printMsg("요청헤더", reqHeaderStr);

				String reqPath = ""; // 요청 경로

				// 요청 페이지 정보 가져오기
				StringTokenizer st = new StringTokenizer(reqLine);

				while (st.hasMoreTokens()) {

					String token = st.nextToken();

					if (token.startsWith("/")) {
						reqPath = token;
						break;
					}

				}

				// URL 디코딩 처리하기(한글 처리)
				reqPath = URLDecoder.decode(reqPath, encoding);
				
				String filePath = "./WebContent" + reqPath;
				System.out.println("요청파일 경로 : " + filePath);

				File file = new File(filePath);
				if (!file.exists()) {
					// 에러 페이지 출력
					makeErrorPage(out, 404, "Not Found");
					return;

				}
				
				// 해당 파일이름을 이용하여 Content-type 정보 추출하기
				
				String contentType = URLConnection.getFileNameMap().getContentTypeFor(filePath);
				
				byte[] body = makeResponseBody(filePath);
				
				byte[] header = makeResponseHeader(body.length,contentType);
				
				out.write(header); // 헤더 정보 보내기
				
				// 응답내용 보내기 전 반드시 Empty Line을 보내야 한다.
				out.write("\r\n\r\n".getBytes());
				
				out.write(body); // 응답내용 보내기
				
				
				
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				try {
					socket.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		/**
		 * 메시지 정보 콘솔 출력
		 * 
		 * @param title 제목
		 * @param msg   메시지
		 */
		private void printMsg(String title, String msg) {
			System.out.println("================================");
			System.out.println(title);
			System.out.println("================================");
			System.out.println(msg);
			System.out.println("================================");
		}
	}

	/**
	 * 응답헤더 생성하기
	 * 
	 * @param ContentLength 응답내용 크기
	 * @param mimeType      응답내용 컨텐트 타입정보
	 * @return
	 */
	private byte[] makeResponseHeader(int ContentLength, String mimeType) { // 헤더 만들기 
		String header = "HTTP/1.1 200 OK\r\n" + "Server: MyHttpServer 1.0\r\n" + "Content-length : " + ContentLength
				+ "r\n" + "Content-type: " + mimeType + "; charset = " + this.encoding; // r\n은 엔터

		return header.getBytes();
	}
	
	/**
	 * 응답내용 생성하기
	 * @param filePath 응답으로 사용할 파일경로
	 * @return 파일내용을 담은 바이트 배열
	 * @throws IOException 
	 */
	
	private byte[] makeResponseBody(String filePath) throws IOException {
		
		FileInputStream fis = null;
		byte[] data = null;
		
		try {
			
			File file = new File(filePath);
			data = new byte[(int) file.length()];
			
			fis = new FileInputStream(file);
			fis.read(data);
			
		} catch (IOException e) {
			e.printStackTrace();
		
		} finally {
			fis.close();
		}
		return data;
		
	}
	
	
	
	/**
	 * 에러 페이지 생성
	 * @param out
	 * @param statusCode
	 * @param errMsg
	 */
	private void makeErrorPage(OutputStream out, int statusCode, String errMsg) {
		try {
			String statusLine = "HTTP/1.1 " + statusCode + " " + errMsg;
			
			out.write(statusLine.getBytes());
			out.flush();
			
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		new MyHttpServer().start();
	}

}
