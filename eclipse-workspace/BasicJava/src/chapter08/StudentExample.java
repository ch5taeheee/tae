package chapter08;

import java.lang.reflect.Array;
import java.util.Arrays;

public class StudentExample {
	public static void main(String[] args) {

		Student[] students = new Student[16];
		students[0] = new Student("최수영", 99);
		students[1] = new Student("최경규", 95);
		students[2] = new Student("김도희", 88);
		students[3] = new Student("이경민", 97);
		students[4] = new Student("이주연", 92);
		students[5] = new Student("정시윤", 96);
		students[6] = new Student("조태희", 98);
		students[7] = new Student("임경빈", 95);
		students[8] = new Student("노태현", 90);
		students[9] = new Student("정지은", 95);
		students[10] = new Student("김종명", 90);
		students[11] = new Student("안희건", 97);
		students[12] = new Student("이 슬", 95);
		students[13] = new Student("유대석", 92);
		students[14] = new Student("김찬수", 98);
		students[15] = new Student("전아현", 95);
		
		Arrays.sort(students);

		for (Student student : students) {
			System.out.println(student);

		}
	}
}
