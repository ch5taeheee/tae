package chapter08;

public interface Predicate {
	/* 이 메소드는 사과(Apple) 객체를 매개값으로 받아서 
	 * 구분하기 원하는 조건에 따라 일치하면 true, 그렇지 않으면 false를 반환하는 메소드
	 * @Param apple : 판별하고자 하는 사과 객체
	 *  일치하면 true, 그렇지 않으면 false
	 */
	boolean test(Apple apple);
}
