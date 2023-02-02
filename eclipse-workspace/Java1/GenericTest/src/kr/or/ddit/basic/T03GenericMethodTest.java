package kr.or.ddit.basic;

import javax.print.DocFlavor.STRING;

class util {
	
	/*
	 	제너릭 메서드에 대하여...
	 	
	 	파라미터 타입과 리턴타입으로 타입문자(글자)를 가지는 메서드
	 	
	 	선언방법 : 리턴타입 앞에 <> 기호를 추가하고 타입문자를 기술 후 사용한다.
	 	
	 */
	
	public static <K,V> boolean compare(Pair <K,V> p1, Pair<K,V> p2) {
		
		boolean keyCompare = p1.getKey().equals(p2.getKey());
		boolean valueCompare = p1.getValue().equals(p2.getValue());
		
		
		return keyCompare && valueCompare; 
		
		
	}
}

/**
 * 멀티타입 <K,V>을 가지는 제너릭 클래스
 */

class Pair<K,V> {
	
	private K key;
	private V value;
	
	public Pair(K key, V value) {
		super();
		this.key = key;
		this.value = value;
	}
	
	public K getKey() {
		return key;
	}
	
	public void setKey(K key) {
		this.key = key;
	}
	
	public V getValue() {
		return value;
	}
	
	public void setValue(V value) {
		this.value = value;
	}
	
	public <K,V> void displayALL(K key, V val) { // 일반메서드, 리턴 타입 앞에 <> 가 없다. 제너릭 클래스 이므로 타입은 제너릭을 쓸 수는 있다. 
		System.out.println(key + " : " + val);
		// 타입이 2개인 경우 제너릭 타입을 따른다. 
	}
	
	
}

public class T03GenericMethodTest {
	public static void main(String[] args) {
		
		Pair<Integer,String> p1 = new Pair<Integer, String> (1,"홍길동");
		Pair<Integer,String> p2 = new Pair<Integer, String> (1,"홍길동");
		
		boolean result1 = util.<Integer,String> compare(p1,p2);
		
		if(result1) {
			System.out.println("논리(의미)적으로 동일한 객체임.");
		} else {
			System.out.println("논리(의미)적으로 동일한 객체가 아님.");
		}
		
		Pair<String,String> p3 = new Pair<String,String> ("001","홍길동");
		Pair<String,String> p4 = new Pair<String,String> ("002","홍길동");
		
		boolean result2 = util.<String,String>compare(p3,p4);
		if(result2) {
			System.out.println("논리(의미)적으로 동일한 객체임.");
		} else {
			System.out.println("논리(의미)적으로 동일한 객체가 아님.");
		}
		
//		p1.displayALL(100, "홍길동");
		p1.displayALL("홍길동", "홍길동"); //p1.<String, Integer> displayAll("홍길동",100);
		
		
	}

}
