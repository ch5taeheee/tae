package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class T03ListSort {
	public static void main(String[] args) {
		/*
		 	정렬과 관련된 Interface는 Comparable과 Comparator가 있다.
		    
		   - 보통 객체 자체에 정렬 기능을 넣기 위해서는 Comparable을 구현하고 
		   	 정렬 기준을 별도로 구현하고 싶을 때는 Comparator를 구현하여 
		   	 사용하면 된다.
		   	 
		   - Comparable에서는 compareTo()메서드를 구현해야 하고, 
		     Comparator 에서는 compare()메서드를 구현해야 한다.
		     
		 */
		
		List<String> list = new ArrayList<>();
		
		list.add("일지매");
		list.add("홍길동");
		list.add("성춘향");
		list.add("변학도");
		list.add("이순신");
		
		System.out.println("정렬 전 : " + list);
		
		// 정렬은 Collections.sort() 메서드를 이용하여 정렬한다. s는 인터페이스 - 클래스
		// 정렬은 기본적으로 '오름차순' 정렬을 수행한다.
		
		// 정렬방식을 변경하려면 정렬방식을 결정하는 객체를 만들어서
		// Collections.sort()메서드에 인수로 넘겨주면 된다.
		
		Collections.sort(list); //정렬하기.
		System.out.println("정렬 후 : " + list);
		
		Collections.shuffle(list); // 데이터 섞기
		System.out.println("자료 섞기 후 : " + list);
		
		
		
		
		
		
		
		
		
		
	}
}
