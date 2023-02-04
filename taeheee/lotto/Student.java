package kr.or.ddit.basic.listTest;

public class Student implements Comparable<Student> {
    private int studentId;
    private String name;
    private int koreanScore;
    private int englishScore;
    private int mathScore;
    private int total;
    private int rank;

    @Override
    public int compareTo(Student o) { // 학번 정렬
        if (studentId > o.getStudentId()) {
            return 1;
        } else if (studentId == o.getStudentId()) {
            return 0;
        } else {
            return -1;
        }
    }
    //등수 만들어주기



    public Student(int studentId, String name, int koreanScore, int englishScore, int mathScore) {
        this.studentId = studentId;
        this.name = name;
        this.koreanScore = koreanScore;
        this.englishScore = englishScore;
        this.mathScore = mathScore;
        this.total = koreanScore + englishScore + mathScore;
    }
    //Getter Setter

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
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

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    @Override
    public String toString() {
        return "학번 =" + studentId + ", 이름='" + name + '\'' + ", 국어점수 =" + koreanScore +
                ", 영어점수 =" + englishScore + ", 수학점수 =" + mathScore + ", 총점 = " + total + ", 등수 = " + rank;

    }
}
