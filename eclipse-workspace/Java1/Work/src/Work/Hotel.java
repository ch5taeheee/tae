package Work;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.jar.Attributes.Name;

public class Hotel {
	public static void main(String[] args) {

		Scanner scanner = new Scanner(System.in);
		Map<String, String> info = new HashMap<>();

		System.out.println("******************************");
		System.out.println("호텔 문을 열었습니다.");
		System.out.println("******************************");
		System.out.println();
		System.out.println("******************************");
		System.out.println("어떤 업무를 하시겠습니까?");
		System.out.println("1. 체크인 2. 체크아웃 3. 객실상태 4. 업무종료");
		System.out.println("******************************");
		System.out.println("메뉴선택 => ");

		int num = scanner.nextInt();

		switch (num) {
		case 1:
			checkin();
			break;
		case 2:
			checkout();
			break;
		case 3:
			roomcondition();
			break;
		case 4:
			end();
			break;

		}

	}

	public void checkin() {
		System.out.println("어느 방에 체크인 하시겠습니까?");
		System.out.println("방 번호 입력 => ");
		System.out.println("누구를 체크인하시겠습니까?");
		System.out.println("이름 입력: ");
		String name = Scanner.nextLine();
	}


class hotelC {
	private String name;
	private String roomnum;

	public hotelC(String name, String roomnum) {
		super();
		this.name = name;
		this.roomnum = roomnum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRoomnum() {
		return roomnum;
	}

	public void setRoomnum(String roomnum) {
		this.roomnum = roomnum;
	}

	@Override
	public String toString() {
		return "hotelC [name=" + name + ", roomnum=" + roomnum + "]";
	}

}
