package homework;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class StudentExample {
	public static void main(String[] args) {
		List<Student> student = new ArrayList<>();	
		student.add(new Student("101", "해린", 100, 100, 100));
		student.add(new Student("102", "박보검", 90, 80, 89));
		student.add(new Student("103", "혜인", 56, 100, 88));
		student.add(new Student("104", "민지", 100, 89, 84));
		student.add(new Student("105", "하니", 95, 72, 100));
		student.add(new Student("106", "차은우", 100, 100, 100));
		student.add(new Student("107", "다니엘", 90, 82, 90));
		student.add(new Student("108", "송강", 85, 100, 89));
		student.add(new Student("109", "이도현", 95, 90, 60));
		student.add(new Student("110", "서강준", 70, 85, 100));
		
		StudentExample studente = new StudentExample();
		studente.rankRank(student);
		
		for (Student s : student) {
			System.out.println(s);
		}
		
		System.out.println("=====================================================================================");
		
		Collections.sort(student, new TotalScoreSort());
		for (Student s : student) {
			System.out.println(s);
		}
	}
	public void rankRank(List<Student> student){
		for (Student std : student) {  
			int rank = 1;
			for (Student std2 : student) { 
				if(std.getTotalScore() < std2.getTotalScore() ){
					rank++;
				}
			}
			std.setRank(rank);
		}
	}
}


class Student implements Comparable<Student>{
	private String studentNumber;
	private String name;
	private int koreanScore;
	private int englishScore;
	private int mathScore;
	private int totalScore;
	private int rank;
	
	public Student(String studentNumber, String name, int koreanScore, int englishScore, int mathScore) {
		super();
		this.studentNumber = studentNumber;
		this.name = name;
		this.koreanScore = koreanScore;
		this.englishScore = englishScore;
		this.mathScore = mathScore;
		this.totalScore = koreanScore + englishScore + mathScore;
	}
	public String getStudentNumber() {
		return studentNumber;
	}
	public void setStudentNumber(String studentNumber) {
		this.studentNumber = studentNumber;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getKoreanScore() {
		return koreanScore;
	}
	public void setKoreanScore(int koreanScore) {
		this.koreanScore = koreanScore;
	}
	public int getEnglishScore() {
		return englishScore;
	}
	public void setEnglishScore(int englishScore) {
		this.englishScore = englishScore;
	}
	public int getMathScore() {
		return mathScore;
	}
	public void setMathScore(int mathScore) {
		this.mathScore = mathScore;
	}	
	public int getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(int totalScore) {
		this.totalScore = totalScore;
	}
	public int getRank() {
		return rank;
	}
	public void setRank(int rank) {
		this.rank = rank;
	}
	@Override
	public int compareTo(Student std) {
		return studentNumber.compareTo(std.getStudentNumber());
	}
	@Override
	public String toString() {
		return "[ 학번 : " + studentNumber + ", 이름 : " + name + ", 국어 : " + koreanScore
				+ ", 영어 : " + englishScore + ", 수학 : " + mathScore + ", 총점 : " + totalScore
				+ ", 등수 : " + rank + "]";
	}
}

class TotalScoreSort implements Comparator<Student>{
	@Override
	public int compare(Student std1, Student std2) {
		if (std1.getTotalScore() == std2.getTotalScore()){
			return std1.getStudentNumber().compareTo(std2.getStudentNumber()) * -1;
		} else {
			return Integer.compare(std1.getTotalScore(), std2.getTotalScore()) * -1;
		}
	}
}