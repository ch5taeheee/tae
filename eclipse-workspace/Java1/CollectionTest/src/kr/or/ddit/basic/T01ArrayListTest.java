package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.List;

public class T01ArrayListTest {
	public static void main(String[] args) {
		
	

			// 기본 용량값  : 10;
			List list1 = new ArrayList<>(); // new LinkedList<>();
			
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
			
			//데이터 변경하기 -> SET
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
			
			//제너릭을 지정하여 선언할 수 있다.
			List<String> list2 = new ArrayList<>();
			list2.add("AAA");
			list2.add("BBB");
			list2.add("CCC");
			list2.add("DDD");
			list2.add("EEE");
		
			for(String s : list2) {
				System.out.println(s);
			}
			System.out.println("----------------------------------");
			
			//contains(비교객체) => 리스트에 '비교객체'가 있으면 true
			//					  없으면 false 반환함.
			System.out.println(list2.contains("DDD"));
			System.out.println(list2.contains("ZZZ"));
			
			
			// indexOf(비교객체) => 리스트에 '비교객체'를 찾아 '비교객체'가 있는
			// 					  index 값을 반환함. 없으면 -1 반환함.
			System.out.println("DDD의 index값 : " + list2.indexOf("DDD"));
			System.out.println("ZZZ의 index값 : " + list2.indexOf("ZZZ"));
			System.out.println("----------------------------------");
			
			//ArrayList 삭제처리하기. // 거꾸로 삭제.. 거꾸로 지워라 / removeall, clear
			for(int i =0; i<list2.size(); i++){
				list2.remove(i);
			}
			System.out.println("삭제 처리 후 arrayList 크기 : " + list2.size());
			
			

		}
}
