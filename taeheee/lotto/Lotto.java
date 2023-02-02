package kr.or.ddit.basic.lotto;

import java.util.List;
import java.util.Scanner;

public class Lotto {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        while (true) {

            System.out.println("==================================");
            System.out.println("Lotto 프로그램");
            System.out.println("----------------------------------");
            System.out.println("1. Lotto 구입");
            System.out.println("2. 프로그램 종료");
            System.out.println("==================================");
            System.out.print("메뉴선택 : ");
            int chooseMenu = sc.nextInt();

            switch (chooseMenu) {
                case 1:
                    System.out.println("Lotto 구입 시작");
                    System.out.println();
                    System.out.println("(" + LottoUtil.LOTTOPRICE + "원에 로또번호 하나입니다.)");
                    System.out.print("금액입력 : ");
                    int money;
                    try {
                        money = sc.nextInt();
                    } catch (Exception e) {
                        sc.next();
                        System.out.println("잘못된 입력입니다 다시 입력해주세요");
                        break;
                    }
                    System.out.println();
                    System.out.println("행운의 로또 번호는 아래와 같습니다");
                    LottoUtils lottoUtils = new LottoUtils(money);
//                  로또번호 출력
                    lottoUtils.printLottoNumbers();

                    System.out.println("받은 금액은 " + money + "원이고 거스름돈은 " +
                            lottoUtils.getChangeMoney() + "원입니다.\n\n");
                    break;
                case 2:
                    System.out.println("감사합니다");
                    return;
                default:
                    System.out.println("잘못입력하셨습니다 다시 입력해주세요");
                    System.out.println("\n\n\n");
                    break;
            }

        }
    }
}
