package horseGame;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class HorseGame  {
    public static void main(String[] args) {
        List<Horse> horses = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            horses.add(new Horse((i + 1) + "번마"));
        }
        PrintGameBoard board = new PrintGameBoard(horses);

        for (Horse hors : horses) {
            hors.start(); // 말 자리 이동
        }
        board.start(); // 말 자리 이동에 맞춰서 게임 현황 보드 출력

        for (Horse hors : horses) {
            try {
                hors.join();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        try {
            board.join();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("============ 결과 ============");
        Collections.sort(horses);
        for (Horse hors : horses) {
            System.out.println(hors.getRank() + "등 : " + hors.getHorseName());
        }


    }// main

} // HorseGame

class PrintGameBoard extends Thread {

    List<Horse> horses;

    public PrintGameBoard(List<Horse> horses) {
        this.horses = horses;
    }

    @Override
    public void run() {
        while (Horse.gameFlagCount != horses.size()) {

            System.out.println("\n\n\n\n\n");

            for (int i = 0; i < horses.size(); i++) {

                System.out.print(horses.get(i).getName() + ": \t");
                for (int j = 0; j < 50; j++) {
                    if (horses.get(i).getLocation() == j) {
                        System.out.print(">");
                    } else {
                        System.out.print("-");
                    }
                }
                System.out.println();
            }
            try {
                // 보드 갱신 속도 조정
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }
}
