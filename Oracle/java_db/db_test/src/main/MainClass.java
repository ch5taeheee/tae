package main;

import dao.MemberDAO;
import dto.MemberDTO;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.List;

public class MainClass {

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = new MemberDTO();

		dto.setMem_id("a002");
		dto.setMem_name("이순신");
		dto.setMem_regno1("011015");
		dto.setMem_regno2("3876543");
		dto.setMem_hp("010-3456-0987");
		dto.setMem_mail("sunshin@naver.com");

		boolean result = dao.insert(dto);

		if (result) {
			System.out.println("자료 삽입 성공");
		} else {
			System.out.println("자료 삽입 실패");
		}

	}
}
