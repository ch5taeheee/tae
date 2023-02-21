package kr.or.ddit.board;

import java.util.Scanner;

public class BoardMain {
	
	private Scanner scan = new Scanner(System.in);

	public void displayMenu() {

		System.out.println();
		System.out.println("------------------------------------------");
		System.out.println("  === 작 업 선 택 ===");
		System.out.println("  1. 전체 목록 출력");
		System.out.println("  2. 새 글 작성");
		System.out.println("  3. 글 수정");
		System.out.println("  4. 글 삭제");
		System.out.println("  5. 글 검색");
		System.out.println("  6. 작업 끝.");
		System.out.println("------------------------------------------");
		System.out.print("원하는 작업 선택 >> ");

	}
	
	
	public void start() {
		
		int num;
		
		do {
			displayMenu();
			num = scan.nextInt();
			
			switch (num) {
			case 1:
				selectAll();
				break;
			case 2:
				boardInsert();
				break;
			case 3:
				boardUpdate();
				break;
			case 4:
				boardDelete();
				break;
			case 5:
				boardSearch();
				break;
			case 6 :
				boardEnd();
			default:
				break;
			}
		}while(num !=6);
	}




	private void selectAll() {
		// TODO Auto-generated method stub
		
	}


	private void boardInsert() {
		// TODO Auto-generated method stub
		
	}


	private void boardUpdate() {
		// TODO Auto-generated method stub
		
	}


	private void boardDelete() {
		// TODO Auto-generated method stub
		
	}


	private void boardSearch() {
		// TODO Auto-generated method stub
		
	}
	private void boardEnd() {
		// TODO Auto-generated method stub
		
	}
}
