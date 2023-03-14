package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.IMemberService;
import service.MemberServiceImpl;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uId = request.getParameter("userId");
		String uPw = request.getParameter("userPw");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uId", uId);
		map.put("uPw", uPw);
		
		//서비스객체 생성하기
		IMemberService service = MemberServiceImpl.getInstance();
		String memId = service.loginChk(map);
		
		System.out.println("조회된 정보>>" + memId);
		
		//로그인 자격을 갖고 메인페이지로 이동
		if(memId != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginCode", memId);
			
			// ("/") >> root >> web-app위치 (에서 자동접근되는 index.jsp로 연결)
			request.getRequestDispatcher("/Main").forward(request, response);
			
		//기존 페이지(로그인페이지)에 머물기
		}else {
			response.sendRedirect("login.html");
		}
		
		
		
	}

}
