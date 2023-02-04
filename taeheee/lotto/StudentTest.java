package kr.or.ddit.basic.listTest;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class StudentTest {
    public static void main(String[] args) {
        List<Student> students = new ArrayList<>();
        students.add(new Student(101, "홍길동", 10, 50, 100));
        students.add(new Student(100, "김둘리", 90, 50, 50));
        students.add(new Student(120, "김공룡", 80, 60, 70));
        students.add(new Student(111, "김가루", 100, 100, 100));
        students.add(new Student(102, "박수박", 10, 20, 30));
        students.add(new Student(103, "하하하", 90, 50, 50));
        students.add(new Student(104, "방수차", 90, 50, 50));

        //등수 만들어 주기
        for (Student student1 : students) {
            int rank = 1;
            //비교를 통해 등수 등록
            for (Student student2 : students) {
                if (student1.getTotal() < student2.getTotal()) {
                    rank++;
                }
            }
            student1.setRank(rank);
        }

        for (Student list : students) {
            System.out.println("정렬전  = " + list);
        }
        System.out.println();
        System.out.println("=================================================");
        System.out.println();
        Collections.sort(students);
        for (Student list : students) {
            System.out.println("학번 오름차순 = " + list);
        }
        System.out.println();
        System.out.println("=================================================");
        System.out.println();
        Collections.sort(students, new SortScore());
        for (Student list : students) {
            System.out.println("총점의 역순 = " + list);
        }
    }

}
