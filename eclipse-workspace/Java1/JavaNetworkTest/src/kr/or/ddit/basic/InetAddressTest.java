package kr.or.ddit.basic;

import java.net.InetAddress;
import java.net.UnknownHostException;

public class InetAddressTest {
	public static void main(String[] args) throws UnknownHostException {

		// InetAddress 클래스 => IP 주소를 다루기 위한 클래스

		// 네이버 사이트의 IP정보 가져오기
		InetAddress naverIP = InetAddress.getByName("www.naver.com");
		System.out.println("Host Name =>" + naverIP.getHostName()); //도메인네임이 존재한다면 도메인 네임일수도, 머신네임?일수도, 할당되어있는 ip주소가 될 수 있다. 상황에 따라서 여러가지가 표현 가능
		System.out.println("Host Address =>" + naverIP.getHostAddress()); //도메인서버로부터 받아옴? // 숫자로 구분되어 있는 주소.
		System.out.println();

		// 자기 자신 컴퓨터의 IP정보 가져오기
		InetAddress localIp = InetAddress.getLocalHost();
		System.out.println("내 컴퓨터의 Host Name => " + localIp.getHostName());
		System.out.println("내 컴퓨터의 Host Address => " + localIp.getHostAddress());
		System.out.println();

		// IP 주소가 여러 개인 호스트의 정보 가져오기
		InetAddress[] naverIps = InetAddress.getAllByName("www.naver.com");
		for (InetAddress iAddr : naverIps) {
			System.out.println(iAddr.toString());
		}

	}
}
