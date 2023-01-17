package chapter05;

public enum Week { //클래스(객체)
	MONDAY("월요일"), TUESDAY("화요일"), WEDNESDAY("수요일"), THURSDAY("목요일"), FRIDAY("금요일"), SATURDAY("토요일"), SUNDAY("일요일");
	String korName;
	String japName;
	String chzName;
	
	private Week(String korName) {
		this.korName = korName;
	}
	
}
