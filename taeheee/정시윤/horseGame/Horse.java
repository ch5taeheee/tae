package horseGame;

import java.util.Random;

public class Horse extends Thread implements Comparable<Horse> {
    public static int addRank; // 등수 상승을 위p/ll한 스태틱
    public static int gameFlagCount; // 모든 말이 도착지점에 오는 수를 계산
    private String horseName; //말 이름
    private int rank; // 등수

    private int location; // 위치

    // Getter Setter

    public Horse(String name) {
        super(name);
        this.horseName = name;
    }

    public String getHorseName() {
        return horseName;
    }

    public void setHorseName(String horseName) {
        this.horseName = horseName;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public int getLocation() {
        return location;
    }

    public void setLocation(int location) {
        this.location = location;
    }

    @Override
    public void run() {
        for (int i = 0; i < 50; i++) {
            // 말의 현재 위치 지정
            location = i;
            Random rn = new Random();
            try {
                // 말들의 속도를 조정하기 위한 sleep
                Thread.sleep(rn.nextInt(500) + 1);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
//        System.out.println(this.getHorseName() + i +"번째 자리 이동중");
        }
        // 끝나는 순서에 맞춰 랭크 등록
        gameFlagCount++;
        setRank(++addRank);
    }

    @Override
    public int compareTo(Horse h) {
        return Integer.compare(this.rank, h.rank);
    }
}
