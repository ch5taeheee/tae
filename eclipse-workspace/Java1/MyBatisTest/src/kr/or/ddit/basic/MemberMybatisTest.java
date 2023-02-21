package kr.or.ddit.basic;

import java.io.IOException;
import java.io.Reader;
import java.nio.charset.Charset;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import kr.or.ddit.member.vo.MemberVO;

public class MemberMybatisTest {
	public static void main(String[] args) {
		// myBatis를 이용하여 DB자료를 읽어와 처리하는 작업 순서
		// 1. myBatis의 환경설정파일을 읽어와 myBatis 객체를 생성한다.

		SqlSessionFactory sqlSessionFactory = null;

		try {
			// 1-1. xml문서 읽어오기
			Charset charset = Charset.forName("UTF-8"); // 설정파일의 한글처리용
			Resources.setCharset(charset);

			Reader rd = Resources.getResourceAsReader("config/mybatis-config.xml");

			// 1-2. 위에서 읽어온 Reader개체를 이용하여 실제 작업을 진행할 객체 생성하기
			sqlSessionFactory = new SqlSessionFactoryBuilder().build(rd);

			rd.close(); // Reader 닫기

		} catch (IOException e) {
			e.printStackTrace();
		}

		// 2. 실행할 sql문에 맞는 쿼리문을 호출해서 원하는 작업을 수행한다.

		// 2-1. insert 작업 연습
		System.out.println("insert 작업 시작");

		// 1) 저장할 데이터를 vo에 담는다.
		MemberVO mv = new MemberVO();

		mv.setMemId("d002");
		mv.setMemName("강감찬");
		mv.setMemTel("010-333-3333");
		mv.setMemAddr("경남 창원시");

		// 2) SqlSession 객체변수를 이용하여 해당 쿼리문을 실행한다.
		// 예) sqlSession.insert("namespace값.id값",파라미터객체);
		// 반환값 : 성공한 레코드 수

		SqlSession session = sqlSessionFactory.openSession(true);

		try {
			int cnt = session.insert("memberTest.insertMember", mv);
			if (cnt > 0) {
				System.out.println("insert작업 성공");
			} else {
				System.out.println("insert작업 실패");
			}
			System.out.println("insert 작업 끝");

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			session.close();
		}

		System.out.println("--------------------------------------------------");

		// 2-2. update 연습
		System.out.println("update 작업 시작");

		MemberVO mv2 = new MemberVO();
		mv2.setMemId("d002");
		mv2.setMemName("이순신");
		mv2.setMemTel("3333-4444");
		mv2.setMemAddr("전남 목포시");

		session = sqlSessionFactory.openSession(); // DEFAULT = FALSE

		try {
			// update()의 반환값도 성공한 레코드 수이다.
			int cnt = session.update("memberTest.updateMember", mv2);

			if (cnt > 0) {
				System.out.println("update작업 성공!");

			} else {
				System.out.println("update작업 실패");
			}
			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();

		} finally {
			session.close();
		}
		System.out.println("update 작업 끝");

		// 2-3 delete 연습
		System.out.println("delete 작업 시작");

		session = sqlSessionFactory.openSession();

		try {
			// delete 메서드의 반환값 : 성공한 레코드 수

			int cnt = session.delete("memberTest.deleteMember", "doo2");

			if (cnt > 0) {
				System.out.println("delete 작업 성공");
			} else {
				System.out.println("delete 작업 실패");
			}

		} catch (Exception e) {
			e.printStackTrace();
			session.rollback();
		} finally {
			session.close();
		}
		System.out.println("delete 작업 끝");

		System.out.println("--------------------------------------------------");

		// 2-4. select 연습
		// 1) 응답결과가 여러 개일 경우
		// 값이 여러개일 경우 반환값이 list => resultset 뽑아서 membervo 뽑아서 list에 담아서 한땀한땀 => 마이바티스로
		// list에 담고
		// 값이 하나일 경우 => count함수 => list에 담아도 되지만 굳이.. => object로 하고

		System.out.println("select 연습 시작(결과가 여러 개일 경우)");

		session = sqlSessionFactory.openSession();

		try {
			List<MemberVO> memList = session.selectList("memberTest.selectAllMember");

			for (MemberVO mv3 : memList) {
				System.out.println("ID : " + mv3.getMemId());
				System.out.println("이름 : " + mv3.getMemName());
				System.out.println("전화번호 : " + mv3.getMemTel());
				System.out.println("주소 : " + mv3.getMemAddr());
			}

			System.out.println("출력 끝");

		} finally {
			session.close();
		}

		// 2) 응답이 1개일 경우
		System.out.println("select 연습 시작(결과가 1개일 경우)...");

		try {
			session = sqlSessionFactory.openSession();

			// 응답 결과가 1개가 확실할 경우에는 selectOne() 메서드를 이용한다.
			MemberVO mv4 = (MemberVO) session.selectOne("memberTest.getMember", "d002"); // 오브젝트로 리턴하기 때문에 캐스팅

			System.out.println("ID : " + mv4.getMemId());
			System.out.println("이름 : " + mv4.getMemName());
			System.out.println("전화번호 : " + mv4.getMemTel());
			System.out.println("주소 : " + mv4.getMemAddr());

			System.out.println("출력 끝...");

		} finally {
			session.close();
		}

	}
}
