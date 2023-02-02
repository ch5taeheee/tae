package kr.or.ddit.basic.lotto;

import java.util.*;

public class LottoUtils {
    public static final int LOTTOPRICE = 1000;
    private List<List<Integer>> lottoNums;

    private int canBuyLotto;

    private int changeMoney;

    public LottoUtils(int money) {
        this.canBuyLotto = money / LOTTOPRICE;
        this.changeMoney = money % LOTTOPRICE;
        lottoNums = new ArrayList<>();
        makeLottoNum();
    }

    public List<List<Integer>> getLottoNums() {
        return lottoNums;
    }

    public int getCanBuyLotto() {
        return canBuyLotto;
    }

    public int getChangeMoney() {
        return changeMoney;
    }

    public void makeLottoNum() {
        Random random = new Random();

        for (int j = 0; j < canBuyLotto; j++) {
            Set<Integer> lottoNum = new TreeSet<>();
            while (lottoNum.size() < 6) {
                int rn = random.nextInt(45) + 1;
                lottoNum.add(rn);
            }
//            this.lottoNums.add(new ArrayList<>(lottoNum));
            this.lottoNums.add(new ArrayList<>(lottoNum));
        }
    }

    //전체 로또 번호 출력 메소드
    public void printLottoNumbers() {
        for (List<Integer> lottoNum : lottoNums) {
            System.out.print("로또번호" + (lottoNums.indexOf(lottoNum) + 1) + " : ");
            for (int j = 0; j < lottoNum.size(); j++) {
                System.out.print(lottoNum.get(j));
                if (j != lottoNum.size() - 1) {
                    System.out.print(", ");
                } else {
                    System.out.println();
                }
            }
        }
    }

    public void getNumber(int i) {
        for (int j = 0; j < lottoNums.get(i).size(); j++) {
            System.out.print(lottoNums.get(i).get(j));
            if (j != lottoNums.get(i).size() - 1) {
                System.out.print(", ");
            } else {
                System.out.println();
            }
        }
    }


}
