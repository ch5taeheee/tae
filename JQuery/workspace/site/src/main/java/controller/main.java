package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.BoardServiceImpl;
import service.IBoardService;
import vo.BoardVO;

@WebServlet("/Main")
public class Main extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Main() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		// 요청정보가 넘어오면 -> controller가 받아서 <-> service <-> dao <-> sql문 실행(결과)
		
		//게시글 목록 가져오기 전에
		//특정 범위의 목록데이터만 가져오기 위해 필요한 정보들 우선 수집 또는 생성
		
		System.out.println(">>>>>>>>>" + request.getParameter("page"));
		int currentPage = 1; //현재 페이지 (default)
		currentPage = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
		
		//전체 글 갯수 가져오기(서비스객체 필요)
		IBoardService service = BoardServiceImpl.getInstance();
		int countList = service.countList(); //20
		
		//한 화면에 출력할 페이지 수
		int perPage = 2;
		
		//한 페이지에 출력할 글 갯수
		int perList = 5;
		
		//전체 페이지 수 계산 (전체 글 갯수 / 페이지 당 글 갯수)
		int totalPage = (int)Math.ceil((double)countList / (double)perList);
		//System.out.println("ttPage>> " + totalPage);
		
		//페이지에 표시될 게시글의 start ~ end 범위 값
		//start = (currentPage - 1) * perList + 1;
		// currentPage 1 >> 1
		// currentPage 2 >> 6
		// currentPage 3 >> 11
		// currentPage 4 >> 16
		int start = (currentPage - 1) * perList + 1;
		
		//end = start + perList - 1;
		int end = start + perList - 1;
		
		
		//페이지에 표시할 startPage ~ endPage 값
		//startPage = ((currentPage - 1) / perPage * perPage) + 1;
		int startPage = ((currentPage - 1) / perPage * perPage) + 1;
		//endPage = startPage + perPage - 1;
		int endPage = startPage + perPage - 1;
		if(endPage > totalPage) endPage = totalPage;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		//게시글 목록 가져오기
		List<BoardVO> boardList = service.boardList(map);
		request.setAttribute("list", boardList);
		request.setAttribute("sPage", startPage);
		request.setAttribute("ePage", endPage);
		request.setAttribute("ttPage", totalPage);
		request.setAttribute("cPage", currentPage);
		
		request.getRequestDispatcher("index.jsp").forward(request, response);
		
//		request.getRequestDispatcher("WEB-INF/index_security.jsp").forward(request, response);
	}

}
