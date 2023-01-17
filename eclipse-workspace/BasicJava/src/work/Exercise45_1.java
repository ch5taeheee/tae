package work;

import java.util.Random;
import java.util.Scanner;

public class Exercise45_1 {
	Scanner scanner = new Scanner(System.in);
	Random random = new Random();
	int com = random.nextInt(100) + 1;
	int me ;
	int count= 0;

	while(com!=me) {
		count++;
		System.out.print("1부터 100사이의 정수 중 하나를 선택하세요: ");
		if (com > me) {
			System.out.println("정답은 더 큰 수입니다.");
			int me = scanner.nextInt();

		} else
			System.out.println("정답은 더 작은 수입니다.");
		me = scanner.nextInt();
		System.out.println("정답입니다. \n게임을 종료합니다. " + count + "번 만에 맞췄습니다.");
	}

	}

}
