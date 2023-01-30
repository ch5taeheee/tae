package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

public class T01ArrayListTest {
	public static void main(String[] args) {
		
		// 기본 용량값  : 10;
		List list1 = new ArrayList<>();
		
		//add()를 이용해서 데이터를 추가한다.
		list1.add("aaa");
		list1.add("bbb");
		list1.add(111); // list1.add(new Integer(111)); 원래 이렇게 해야하는데 저렇게 해도 컴파일이 알아서 해줌.
		list1.add('k');
		list1.add(true);
		list1.add(12.34);
		
		//size() => 데이터 개수 조회
		System.out.println("size => " + list1.size());
		
		//get()으로 데이터 꺼내오기
		System.out.println("1번째 자료 : " + list1.get(0));
		
		//데이터를 끼워넣기도 같다.
		list1.add(0,"zzz");
		System.out.println("list1 => " + list1);
		
		//데이터 변경하기
		String temp = (String) list1.set(0, "YYY");
		System.out.println("temp => " + temp);
		System.out.println("list1 => "+ list1);
		
		//데이터 삭제하기
		list1.remove(0);
		System.out.println("삭제 후 : " + list1);
		
		list1.remove("bbb");
		System.out.println("bbb 삭제 후 : " + list1);
		System.out.println("================================");
		
		list1.remove(1);
		
		
		list1.remove(new Integer(111));
	
		
	}
}
