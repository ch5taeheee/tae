package kr.or.ddit.basic;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;

public class T08HashMapTest {
	public static void main(String[] args) {

		/*
		 * Map => key값과 value값을 한 쌍으로 관리하는 객체 => key값은 중복을 허용하지 않고 순서가 없다. (Set의 특징) =>
		 * value 값은 중복을 허용한다.
		 * 
		 */

		Map<String, String> map = new HashMap<>();

		// 자료 추가 => put(key값, value값);
		map.put("name", "홍길동");
		map.put("addr", "대전");
		map.put("tel", "010-1234-5678");

		System.out.println("map => " + map);

		// 자료 수정 => 데이터를 저장할 때 key 값이 같으면 나중에 입력한 값이 저장된다.
		// put(수정할 key값, 새로운 value 값);
		map.put("addr", "서울");
		System.out.println("map => " + map);

		// 자료 삭제 => remove(삭제할 값);
		map.remove("name");
		System.out.println("map => " + map);

		// 자료 읽기 => get(key값);
		System.out.println("addr : " + map.get("addr"));
		System.out.println("========================================================");

		////////////////////////////////////////////////////////////////////////////////

		// key 값들을 읽어오 자료를 출력하는 방법

		// 방법 1 => keySet() 메서드 이용하기
		// Map의 key값들을 담은 Set 타입의 객체를 반환한다.
		Set<String> keySet = map.keySet();

		System.out.println("Iterator를 이용한 방법");
		Iterator<String> it = keySet.iterator();
		while (it.hasNext()) {
			String key = it.next();
			System.out.println(key + " : " + map.get(key));
		}
		System.out.println("---------------------------------------------------------");

		// 방법2 => Set 형의 데이터를 '향상된 for문'으로 처리하면 Iterator를 사용하지 않아도 된다.
		System.out.println("향상된 for문을 이용한 방법");
		for (String key : keySet) {
			System.out.println(key + " : " + map.get(key));
		}
		System.out.println("----------------------------------------------------------");

		// 방법3 => value 값만 읽어와 출력하기
		System.out.println("values()메서드 이용한 방법");
		for (String value : map.values()) {
			System.out.println(value);
		}
		System.out.println("----------------------------------------------------------");

		// 방법 4 => Map 관련 클래스는 Map.Entry타입의 내부 class가 만들어져 있다.
		// 이 내부 클래스는 key와 value라는 멤버변수로 구성되어 있다.
		// Map에서 이 Map.Entry 타입의 객체들을 Set 타입의 데이터로 저장하여 관리한다.
		// Map.Entry 타입의 객체 모두 가져오기 => entrySet() 메서드 이용함.

		Set<Map.Entry<String, String>> entrySet = map.entrySet(); //Map 안에 있는 entry 타입은 getkey, getvalue 메서드를 가지고 있다.

		// 가져온 Entry 객체들을 순서대로 처리하기 위해 Iterator 객체 사용하기 
		Iterator<Map.Entry<String, String>> entryIt = entrySet.iterator();
		
		while (entryIt.hasNext()) {
			Map.Entry<String, String> entry = entryIt.next();

			System.out.println("key 값 : " + entry.getKey());
			System.out.println("value 값 : " + entry.getValue());
			System.out.println();
		}
		
		//향상된 FOR문 가능

	}
}
