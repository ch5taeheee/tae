package Work;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

public class Hotel1 {
	private Scanner scan;
	private Map<String, Hotel> hotelInfo;

	public void Hotel1Test() {
		scan = new Scanner(System.in);
		hotelInfo = new HashMap<>();
	}

	public void displayMenu() {
		System.out.println();

		System.out.println("어떤 업무를 하시겠습니까?");
		System.out.println("1. 체크인 2. 체크아웃 3. 객실상태 4. 업무종료");
		System.out.println("******************************");
		System.out.println("메뉴선택 => ");

	}

	public void HotelStart() {
		System.out.println("******************************");
		System.out.println("호텔 문을 열었습니다.");
		System.out.println("******************************");
		System.out.println();
		System.out.println("******************************");

		while (true) {
			displayMenu(); // 메뉴 출력

			int menuNum = scan.nextInt(); // 메뉴 번호 입력

			switch (menuNum) {

			case 1:
				checkin();
			case 2:
				checkout();
			case 3:
				roominfo();
			case 4:
				end();
			default:
				System.out.println("잘못 입력하셨습니다. 다시 입력하세요.");

			}
		}
	}



	private void checkin() {
		System.out.println();
		System.out.println("어느 방에 체크인 하시겠습니까?");
		System.out.println("방 번호 입력: ");
		String roomNum = scan.next();
		System.out.println("누구를 체크인 하시겠습니까?");
		System.out.println("이름 입력: ");
		String name = scan.next();

		// 방이 비워있는지 확인하기
		if (hotelInfo.get(roomNum) != null) {
			System.out.println(roomNum + "방에는 이미 사람이 있습니다.");
			System.out.println("다시 입력해주세요");
			return;
		}
		System.out.println("체크인 되었습니다.");

	}
	
	private void checkout() {
		System.out.println();
		System.out.println("어느 방을 체크아웃 하시겠습니까?");
		System.out.println("방 번호 입력 => ");
		String roomNum = scan.next();
		
		if(hotelInfo.get(roomNum) ==null ) {
			System.out.println(roomNum  + " 에는 체크인한 사람이 없습니다.");
			System.out.println(" 다시 입력해주세요.");
			return;

		} System.out.println("체크아웃 되었습니다.");
		
	}
	private void roominfo() {
		
		Set<String> keyset = hotelInfo.keySet();
		
		if(keyset.size() == 0) {
			System.out.println("정보가 없습니다.");
			
		} else { 
			Iterator<String> it = keyset.iterator();
			
			while (it.hasNext()) {
				String roomNum = it.next();
				Hotel h = hotelInfo.get(roomNum);
				System.out.println();
				System.out.println("방번호 : " + h. + ", 투숙객 : " + h.getName());
				
			}
		}
		
		
		
		
		
		

		
	}
	
	private void end() {

		
	}

}

	class HotelCu {
		private String name;
		private String roomNum;

		public HotelCu(String name, String roomNum) {
			super();
			this.name = name;
			this.roomNum = roomNum;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getRoomNum() {
			return roomNum;
		}

		public void setRoomNum(String roomNum) {
			this.roomNum = roomNum;
		}

		@Override
		public String toString() {
			return "HotelInfo [name=" + name + ", roomNum=" + roomNum + "]";
		}
	}

