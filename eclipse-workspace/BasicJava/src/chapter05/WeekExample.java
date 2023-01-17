package chapter05;

import java.time.DayOfWeek;
import java.time.LocalDate;

public class WeekExample {
	public static void main(String[] args) { //208페이지
		Week today = null;
		
//		Calendar calendar = calendar.getInstance();
//		int i = calendar.get(Calendar.DAY_OF_WEEK);
		
		
		LocalDate now = LocalDate.now(); //Calender.getInstance();
		DayOfWeek dayOfWeek = now.getDayOfWeek();
		switch(dayOfWeek) {
		case SUNDAY:
			today = Week.SUNDAY;
			break;
		case MONDAY:
			today = Week.MONDAY;
			break;
		case TUESDAY:
			today = Week.TUESDAY;
			break;
		case WEDNESDAY:
			today = Week.WEDNESDAY;
			break;
		case THURSDAY:
			today = Week.THURSDAY;
			break;
		case FRIDAY:
			today = Week.FRIDAY;
			break;
		case SATURDAY:
			today = Week.SATURDAY;
			break;
		}
		System.out.println("오늘 요일: " + today.korName);
		if (today==Week.SUNDAY) {
			System.out.println("일요일에는 축구를 합니다.");
		} else {
			System.out.println("열심히 자바 공부합니다.");
		}
	}
}
