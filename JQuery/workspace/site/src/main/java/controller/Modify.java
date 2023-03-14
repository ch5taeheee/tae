package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardServiceImpl;
import service.IBoardService;
import vo.BoardVO;

@WebServlet("/Modify")
public class Modify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Modify() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		IBoardService service = BoardServiceImpl.getInstance();
		
		int num = Integer.parseInt(request.getParameter("uniqueId"));
		List<BoardVO> list = service.detailInfo(num);
		String content = list.get(0).getContent();
		
		String sbj = request.getParameter("subject") == null ? list.get(0).getSubject() : request.getParameter("subject");
		String cnt = request.getParameter("content") == "" ? content : request.getParameter("content");
		
		BoardVO vo = new BoardVO();
		vo.setNum(num);
		vo.setSubject(sbj);
		vo.setContent(cnt);
		vo.setWip(request.getRemoteAddr());
		
		
		int rst = service.updateBoard(vo);
		
		PrintWriter out = response.getWriter();
		out.print(rst);
	}

}
