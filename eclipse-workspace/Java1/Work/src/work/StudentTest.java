package work;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class StudentTest {
	public static void main(String[] args) {

		List<Student> list1 = new ArrayList<Student>();

		list1.add(new Student("1004", "조태희", 100, 100, 100));
		list1.add(new Student("1050", "조태조", 70, 56, 90));
		list1.add(new Student("1679", "조태태", 66, 80, 34));
		list1.add(new Student("1000", "조조조", 90, 50, 40));
		list1.add(new Student("1046", "태태태", 29, 18, 87));
		list1.add(new Student("1079", "희희희", 74, 94, 91));

		for (Student student : list1) {
			int rank = 1;
			for (Student student2 : list1) {
				if (student.getScore() < student2.getScore()) {
					rank++;
				}

			}
			student.setrank(rank);
		}

		// 학번 오름차순 정렬
		Collections.sort(list1);

		for (Student o : list1) {
			System.out.println(o);
		}

		System.out.println("-------------------------------------------------------------------------------------------");

		Collections.shuffle(list1);

		// 총점 내림차순 정렬
		Collections.sort(list1, new SScore());
		for (Student o : list1) {
			System.out.println(o);
		}

	}
}

class SScore implements Comparator<Student> {

	@Override
	public int compare(Student o1, Student o2) {
		if (o1.getScore() == o2.getScore()) {
			return o1.getId().compareTo(o2.getId()) * -1;
		} else {
			return new Integer((int) o1.getScore()).compareTo((int) o2.getScore()) * -1;
		}
	}

}

class Student implements Comparable<Student> {
	private String id;
	private String name;
	private double korean;
	private double english;
	private double math;
	private double score;
	private int rank;

	public Student(String id, String name, double korean, double english, double math) {

		this.id = id;
		this.name = name;
		this.korean = korean;
		this.english = english;
		this.math = math;
		this.score = korean + english + math;
		this.rank = 1;

	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public double getKorean() {
		return korean;
	}

	public void setKorean(double korean) {
		this.korean = korean;
	}

	public double getEnglish() {
		return english;
	}

	public void setEnglish(double english) {
		this.english = english;
	}

	public double getMath() {
		return math;
	}

	public void setMath(double math) {
		this.math = math;
	}

	public double getScore() {
		return score;
	}

	public void setScore(double score) {
		this.score = score;
	}

	public int getrank() {
		return rank;
	}

	public void setrank(int rank) {
		this.rank = rank;
	}

	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + ", korean=" + korean + ", english=" + english + ", math=" + math
				+ ", score=" + score + ", rank=" + rank + "]";
	}

	@Override
	public int compareTo(Student o) {
		return id.compareTo(o.getId());
	}

}
