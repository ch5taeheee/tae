package wwork;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

public class Hotel2 {
	private Scanner scan;
	private Map<String, Hotel> roomInfo;

	public static void main(String[] args) {

		new Hotel2().HotelStart();
		
	}

	////////////////////////////////////////////////////////////////////////////////////////////
	public void output() {

		ObjectOutputStream oos = null;

		try {
			oos = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream("d:/D_Other/hotel.bin")));

			oos.writeObject(roomInfo);
			System.out.println("저장완료");

		
		} catch (IOException e) {
			e.printStackTrace();
		} finally {

			try {
				oos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

	}

/////////////////////////////////////////////////////////////////////////////////

	private void input() {

		File file = new File("d:/D_Other/hotel.bin");

		if (!file.exists()) {
			System.out.println("로드할 파일 없음");
			return;
		}

		ObjectInputStream ois = null;

		try {
			ois = new ObjectInputStream(new BufferedInputStream(new FileInputStream("d:/D_Other/hotel.bin")));

			roomInfo = (Map<String, Hotel>) ois.readObject();

			System.out.println("불러오기 작업 완료");

		} catch (IOException e) {
			e.printStackTrace();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {

			try {
				ois.close();
			} catch (IOException e) {
				e.printStackTrace();
			}

		}

	}
	//////////////////////////////////////////////////////////////////////////////
	
	public void save() {
		try {
			ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("d:/D_Other/hotell.txt"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				
				
				
			} catch (Exception e2) {
				
			}
		}
		
		
	}

//////////////////////////////////////////////////////////////////////////////////

	public Hotel2() {
		scan = new Scanner(System.in);
		roomInfo = new HashMap<>();
	}

	public void displayMenu() {
		
		System.out.println();
		System.out.println("******************************");
		System.out.println("어떤 업무를 하시겠습니까?");
		System.out.println("1. 체크인 2. 체크아웃 3. 객실상태 4. 업무종료");
		System.out.println("******************************");
		System.out.print("메뉴선택 => ");

	}

	public void HotelStart() {
		input();
		System.out.println("******************************");
		System.out.println("호텔 문을 열었습니다.");
		System.out.println("******************************");
		System.out.println();

		while (true) {
			displayMenu(); // 메뉴 출력

			int menuNum = scan.nextInt();

			switch (menuNum) {

			case 1:
				checkin();
				break;
			case 2:
				checkout();
				break;
			case 3:
				roominfo();
				break;
			case 4:
				output();
				end();
				return; // 메서드 종료
			default:
				System.out.println("잘못 입력하셨습니다. 다시 입력하세요.");

			}

		}
	}

	private void checkin() {
		System.out.println();
		System.out.println("어느 방에 체크인 하시겠습니까?");
		System.out.print("방 번호 입력: ");
		String roomNum = scan.next();
		System.out.println();

		if (roomInfo.get(roomNum) != null) {
			System.out.println(roomNum + "방은 이미 사람이 있습니다.");
			System.out.println("다시 입력해주세요");
			return;
		}
		System.out.println("누구를 체크인 하시겠습니까?");
		System.out.print("이름 입력: ");
		String name = scan.next();

		Hotel h = new Hotel(name, roomNum);
		roomInfo.put(roomNum, h);
		System.out.println();
		System.out.println("체크인 되었습니다.");

	}

	private void checkout() {
		System.out.println();
		System.out.println("어느 방을 체크아웃 하시겠습니까?");
		System.out.print("방 번호 입력 => ");

		String roomNum = scan.next();
		System.out.println();

		// remove(key) 성공하면 value 값이 반환 b, 실패하면 null 이 반환
		if (roomInfo.remove(roomNum) == null) {
			System.out.println(roomNum + " 방에는 체크인한 사람이 없습니다.");
			System.out.println();
			System.out.println("다시 입력해주세요.");
			return;

		}
		roomInfo.remove(roomNum);
		System.out.println("체크아웃 되었습니다.");

	}

	private void roominfo() {

		Set<String> keySet = roomInfo.keySet();

		if (keySet.size() == 0) {
			System.out.println("정보가 없습니다.");

		} else {
			Iterator<String> it = keySet.iterator();
			while (it.hasNext()) {
				String roomNum = it.next();
				Hotel h = roomInfo.get(roomNum);
				System.out.println();
				System.out.println("방번호 : " + h.getRoomNum() + ", 투숙객 : " + h.getName());

			}
		}

	}

	private void end() {

		System.out.println("******************************");
		System.out.println("호텔 문을 닫았습니다.");
		System.out.println("******************************");

	}

}

class Hotel implements Serializable {
	private String name;
	private String roomNum;

	public Hotel(String name, String roomNum) {
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
		return "roomInfo [name=" + name + ", roomNum=" + roomNum + "]";
	}
}
