package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import service.MemberServiceImpl;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Login() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println(">>>>>>>>>>>>>>>>");
		
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uId = request.getParameter("userId");
		String uPw = request.getParameter("userPw");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("uId",uId);
		map.put("uPw",uPw);
		
		
		
		
		
		
		//서비스 객체 생성하기
		
		MemberServiceImpl service = MemberServiceImpl.getInstance();
		String memId = service.loginChk(map);
		
		System.out.println("조회된 정보 >> " + memId);
		
		if(memId != null) {
			HttpSession session = request.getSession();
			session.setAttribute("loginCode", memId);

			//("/) >> root >> web-app 위치(에서 자동접근 되는 index.jsp로 연결)
			request.getRequestDispatcher("/").forward(request, response);
		// 기존페이지(로그인페이지)에 머물기	
		} else {
			response.sendRedirect("login.html");
			
		}
		
		
		
	
	}

}
