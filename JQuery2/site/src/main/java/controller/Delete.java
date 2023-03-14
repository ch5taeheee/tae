package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardServiceImpl;
import service.IBoardService;

@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Delete() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//delete처리해보기
		int no = Integer.parseInt(request.getParameter("boardNo"));
		
		IBoardService service = BoardServiceImpl.getInstance();
		int result = service.deleteBoard(no);
		
		PrintWriter out = response.getWriter();
		out.print(result); //1을 문자열 자체로 전달
	}

}
