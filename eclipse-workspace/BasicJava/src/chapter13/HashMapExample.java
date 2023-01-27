package chapter13;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class HashMapExample {
	public static void main(String[] args) {

		Map<Student, Integer> map = new HashMap<>();
		map.put(new Student(1, "홍길동"), 95);
		map.put(new Student(1, "홍길동"), 80);
		map.put(new Student(2, "이순신"), 90);

		Integer integer = map.get(new Student(2, "이순신"));
		System.out.println("이순신 점수 :" + integer);
		// map 안의 데이터 보기
		// 1. 엔트리 집합을 이용
		Iterator<Entry<Student, Integer>> iterator = map.entrySet().iterator();
		while (iterator.hasNext()) {
			Entry<Student, Integer> entry = iterator.next();
			System.out.println(entry.getKey() + ":" + entry.getValue());
		}
		System.out.println();
		// 2. 키 집합을 이용
//		map.keySet();
		Iterator<Student> keyiIterator = map.keySet().iterator();
		while (keyiIterator.hasNext()) {
			Student student = keyiIterator.next();
			System.out.println(student + "=" + map.get(student));
		}
		System.out.println();
		// 3. 직접 value를 전부 가져오기
//		map.values();
		Iterator<Integer> valueIterator = map.values().iterator();
		while (valueIterator.hasNext()) {
			Integer value = valueIterator.next();
			System.out.println(value);
		}
		System.out.println();
	}

}
