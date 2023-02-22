package kr.or.ddit.board;

import java.util.Scanner;

import kr.or.ddit.board.service.IBoardService;
import kr.or.ddit.boardVO.BoardVO;

public class BoardMain {

	private IBoardService boardService; // 보드 서비스 객체 생성

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
			case 6:
				boardEnd();
			default:
				break;
			}
		} while (num != 6);
	}

	private void selectAll() {
		// TODO Auto-generated method stub

	}

	/**
	 * 새 글 추가 메서드
	 */
	private void boardInsert() {

		System.out.println();
		System.out.println("작성자를 입력하세요.");
		String boardWriter = scan.next();

		System.out.println("글 제목을 입력하세요.");
		String boardTitle = scan.next();

		System.out.println("내용을 입력하세요.");
		String boardContent = scan.next();

		BoardVO bvo = new BoardVO();
		bvo.setBoardTitle(boardTitle);
		bvo.setBoardWriter(boardWriter);
		bvo.setBoardContent(boardContent);

		int cnt = boardService.registBoard(bvo);

		if (cnt > 0) {
			System.out.println(boardWriter + "님 글 작성 완료");
		} else {
			System.out.println("글 작성 실패");
		}

	}

	private void boardUpdate() {
		boolean isExist = false;
		String boardWriter = "";

		do {
			System.out.println();
			System.out.println("수정할 글의 작성자를 입력하세요.");
			boardWriter = scan.next();

			isExist = boardService.checkBoard(boardWriter);

			if (!isExist) {
				System.out.println("작성자 " + boardWriter + "님의 글이 없습니다.");
				System.out.println("다시 입력해주세요.");
			}
		} while (!isExist);

		System.out.print("글 제목 >> ");
		String boardTitle = scan.next();

		System.out.print("작성자>> ");
		String boardwriter = scan.next();

		System.out.print("글 내용>> ");
		String boardContent = scan.next();

		BoardVO bvo = new BoardVO();
		bvo.setBoardTitle(boardTitle);
		bvo.setBoardWriter(boardWriter);
		bvo.setBoardContent(boardContent);

		int cnt = boardService.modifyBoard(bvo);
		if (cnt > 0) {
			System.out.println(boardWriter + " 글 수정 성공");
		} else {
			System.out.println(boardWriter + "글 수정 실패");

		}
	}

	private void boardDelete() {
		boolean isExist = false;
		String boardWriter = "";

		do {
			System.out.println();
			System.out.println("삭제할 글의 작성자를 입력하세요.");
			boardWriter = scan.next();

			isExist = boardService.checkBoard(boardWriter);

			if (!isExist) {
				System.out.println("작성자 " + boardWriter + "님의 글이 없습니다.");
				System.out.println("다시 입력해주세요.");
			}
		} while (!isExist);

		int cnt = boardService.removeBoard(boardWriter);

		if (cnt > 0) {
			System.out.println(boardWriter + "님의 글을 삭제하였습니다.");
		} else {
			System.out.println(boardWriter + "님의 글 삭제작업 실패");
		}

	}

	private void boardSearch() {
		// TODO Auto-generated method stub

	}

	private void boardEnd() {
		// TODO Auto-generated method stub

	}
}
