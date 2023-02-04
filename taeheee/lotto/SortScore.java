package kr.or.ddit.basic.listTest;

import java.util.Comparator;

public class SortScore implements Comparator<Student> {

    @Override
    public int compare(Student o1, Student o2) {
        if (o1.getTotal() == o2.getTotal()) {
            //학번을 비교하여 내림차순 정렬
            if (o1.getStudentId() > o2.getStudentId()) {
                return -1;
            }
            return 0;
        } else if (o1.getTotal() > o2.getTotal()) {
            return -1;
        } else {
            return 1;
        }
    }
}
