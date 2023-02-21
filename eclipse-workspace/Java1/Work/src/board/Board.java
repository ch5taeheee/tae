package board;

import java.util.List;
import java.util.Scanner;

import service.BoardServiceImpl;
import vo.BoardVO;

public class Board {
	private  BoardServiceImpl boardService = new BoardServiceImpl();

	private Scanner scan = new Scanner(System.in);

//		메뉴출력

	public void displayMenu() {
		System.out.println();
		System.out.println("------------------------------------------");
		System.out.println("  === 작 업 선 택 ===");
		System.out.println("  1. 전체 목록 출력");
		System.out.println("  2. 새 글 작성");
		System.out.println("  3. 글 수정");
		System.out.println("  4. 글 삭제");
		System.out.println("  5. 글 검색");
		System.out.println("------------------------------------------");
		System.out.print("원하는 작업 선택 >> ");
		
	}

	public void start() {
		int choice;
		do {
			displayMenu(); // 메뉴 출력
			choice = scan.nextInt(); // 메뉴번호 입력받기
			switch (choice) {
			case 1: // 전체 목록 출력
				displayALL();
				break;
			case 2: // 새 글 작성
				insert();
				break;
			case 3: // 글 수정
				update();
				break;
			case 4: // 글 삭제
				delete();
				break;
			case 5: // 글 검색
				search();
				break;
			default:
				System.out.println("번호를 잘못 입력했습니다. 다시입력하세요");
			}
		} while (choice != 5);

	}

	private void displayALL() {
		System.out.println();
		System.out.println("--------------------------");
		System.out.println("번호\t제목\t작성자\t작성날짜\t내용");
		System.out.println("--------------------------");

		List<BoardVO> boardList = boardService.selectAllBoard();

		if (boardList.size() == 0) {
			System.out.println("조회된 데이터가 없습니다.");
		} else {
			for (BoardVO bb : boardList) {
				System.out.println( bb.getTitle() + bb.getWriter() + bb.getContent());
				System.out.println("--------------------------");

			}
		}

		System.out.println("출력 작업 끝");
	}

	private void insert() {
		boolean isExist = false;
		String writer = "";
		

		//do {
			System.out.println();
			System.out.println("작성자를 입력하세요.");
			System.out.println("작성자 >>");
			writer = scan.next();
			
//			isExist = boardService.checkBoard(writer);
//
//			if (writer== null) {
//				System.out.println("다시 입력해주세요.");
//			
//			}

	//	} while (isExist);

		System.out.print("제목 >> ");
		String title = scan.next();
		
		scan.nextLine();
		
		System.out.print("내용 >> ");
		String content = scan.next();

		BoardVO bb = new BoardVO();

		bb.setTitle(title);
		bb.setWriter(writer);
		bb.setContent(content);

		int cnt = boardService.registBoard(bb);

		if (cnt > 0) {
			System.out.println(title + "글 작성 완료");
		} else {
			System.out.println("글 작성 실패");
		}

	}

	private void update() {
		boolean isExist = false;
		String writer = "";

		do {
			System.out.println();
			System.out.println("작성자를 입력하세요.");
			System.out.println("작성자 >> ");
			writer = scan.next();

			isExist = boardService.checkBoard(writer);

			if (!isExist) {
				System.out.println("작성자 " + writer + "가 존재하지 않습니다.");
				System.out.println("다시 입력해주세요");

			}

		} while (!isExist);

		System.out.println();
		System.out.println("글 제목 >> ");
		String title = scan.next();
		System.out.println("글 내용 >> ");
		String content = scan.next();
		
		BoardVO bb = new BoardVO();
		
		bb.setWriter(writer);
		bb.setTitle(title);
		bb.setContent(content);

		int cnt = boardService.modifyBoard(bb);

		if (cnt > 0) {
			System.out.println("작성자 " + writer + "의 글 수정 완료");
		} else {
			System.out.println("작성자 " + writer + "의 글 수정 실패");
		}

	}

	

	private void delete() {
		String writer = "";

		System.out.println();
		System.out.println("삭제할 글의 작성자를 입력하세요");
		System.out.println("작성자 >> ");
		writer = scan.next();

		int cnt = boardService.removeBoard(writer);

		if (cnt > 0) {
			System.out.println(writer + "의 글 삭제 작업 성공");
		} else {
			System.out.println(writer + "의 글 삭제 작업 실패");
		}
	}

	private void search() {

		scan.nextLine();
		System.out.println();
		System.out.println("검색할 글의 작성자나 제목을 입력하세요.");
		System.out.println("작성자 >> ");
		String writer = scan.nextLine().trim();
		System.out.println("글 제목 >> ");
		String title = scan.nextLine().trim();

		BoardVO bb = new BoardVO();
		bb.setWriter(writer);
		bb.setTitle(title);

		System.out.println();
		System.out.println("---------------------------------------");
		System.out.println("no\t제목\t작성자\t작성날짜\t내용\t");
		System.out.println("---------------------------------------");

		List<BoardVO> boardList = boardService.searchBoard(bb);
		
		
		if (boardList.size() == 0) {
			System.out.println("조회된 데이터가 없습니다.");
		} else {
			for (BoardVO bvo : boardList) {
				System.out.println(bvo.getNo() + "\t" + bvo.getTitle() + "\t" + bvo.getWriter() + "\t"
						+ bvo.getDate() + "\t" + bvo.getContent());
				System.out.println("--------------------------------------");

			}
		}
		System.out.println("검색 작업 끝");

	}

	public static void main(String[] args) {
		Board bbo = new Board();
		bbo.start();

	}

}
