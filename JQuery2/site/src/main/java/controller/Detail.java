package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardServiceImpl;
import service.IBoardService;
import vo.BoardVO;

@WebServlet("/Detail")
public class Detail extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Detail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int uniqueId = Integer.parseInt(request.getParameter("uniqueId"));
		
		//페이지 상세 정보 가져오기 위해 서비스 객체 생성
		IBoardService service = BoardServiceImpl.getInstance();
		
		//조회수 증가
		service.updateHit(uniqueId);

		//상세페이지 조회
		List<BoardVO> info = service.detailInfo(uniqueId);
		
		request.setAttribute("info", info);
		request.setAttribute("detail", "yes");
		request.setAttribute("cPage", request.getParameter("page"));
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

}
