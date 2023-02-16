package kr.or.ddit.basic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

/**
 * 객체 입출력을 위한 보조스트림 예제
 */

public class T15ObjectStreamTest {
	public static void main(String[] args) {
		Member mem1 = new Member("홍길동", 10, "대전");
		Member mem2 = new Member("이순신", 20, "광주");
		Member mem3 = new Member("일지매", 30, "대구");
		Member mem4 = new Member("성춘향", 40, "서울");

		ObjectOutputStream oos = null;

		try {
			// 객체를 파일로 저장하기

			// 출력용 스트림객체 생성하기
			oos = new ObjectOutputStream(new BufferedOutputStream(
					new FileOutputStream("d:/D_Other/memObj.bin")));

			// 쓰기 작업
			oos.writeObject(mem1); // 직렬화
			oos.writeObject(mem2); // 직렬화
			oos.writeObject(mem3); // 직렬화
			oos.writeObject(mem4); // 직렬화

			System.out.println("쓰기 작업 완료");

		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				oos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		/////////////////////////////////////////////////////////////////////////////////

		ObjectInputStream ois = null;

		try {
			// 저장한 객체를 읽어와 화면에 출력하기
		ois = new ObjectInputStream(new BufferedInputStream(
				new FileInputStream("d:/D_Other/memObj.bin")));
		
		Object obj = null;
		
		while((obj = ois.readObject())!=null) {//역직렬화 // 직렬화되ㄴ걸 하나하나 읽어서 .. 오브젝트 단위로 읽어들인다. 
			//읽어온 데이터를 원래의 객체형으로 변환 후 사용한다. 기본적으로 리턴타입이 오브젝트 원하는 형으로 바꾸고 싶으면 캐스팅 해야함
			Member mem = (Member)obj;
			System.out.println("이름 : " + mem.getName());
			System.out.println("나이 : " + mem.getAge());
			System.out.println("주소 : " + mem.getAddr());
			System.out.println("=================================================");
			
		}
		
		
		} catch (IOException ex) {
			//ex.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} finally {
			try {
				ois.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}

/**
 * 회원정보를 담기 위한 VO 클래스
 */
class Member implements Serializable { // 직렬화는 데이터를 write 할 때 데이터를 읽어서 객체를 힙영역에 read할 때 역직렬화가 일어남.
	//io가 일어난다? 직렬화한다. 객체 저장을 위해서는 직렬화가 필용하다 직렬화를ㄷ 다시 객체로 복원하는 것은 역직렬화

	// 자바는 Serializable 인터페이스를 구현한 클래스만 직렬화 할 수 있도록 제한하고 있음.
	// 구현하지 않으면 직렬화 작업 시 예외발생함.
	
	/*
	 * transient(일시적인) => 직렬화가 되지 않을 멤버 변수에 지정한다. //보안, 민감한 정보
	 * 				(*static 필드도 직렬화가 되지 않는다.)
	 * 				직렬화가 되지 않는 멤버변수는 기본값으로 지정한다.
	 * 				(참조변수 : null, 숫자형 변수 : 0)
	 * io 작업을 하는 건 객체, 인스턴스변수만 io대상이 된다. static 애시당초 직렬화 대상에서 제외가 된다. 
	 */

	private String name;
	transient private int age;
	private String addr;

	public Member(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	@Override
	public String toString() {
		return "Member [name=" + name + ", age=" + age + ", addr=" + addr + "]";
	}

}
