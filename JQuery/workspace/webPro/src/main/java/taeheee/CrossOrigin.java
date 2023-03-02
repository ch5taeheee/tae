package taeheee;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.hc.client5.http.fluent.Request;

@WebServlet("/CrossOrigin")
public class CrossOrigin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CrossOrigin() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String keyword = request.getParameter("keyword");
		// URLEncoder >> url규칙에 맞게 한글을 인코딩해줘야 함
		
		// String returnStr =
		// Request.get("https://news.google.com/rss/search?hl=ko&gl=KR&ceid=KR%3Ako&oc=11&q=%EC%95%84%EB%B0%94%ED%83%802")
		String returnStr = Request.get("https://news.google.com/rss/search?hl=ko&gl=KR&ceid=KR%3Ako&oc=11&q=" + keyword)
				.execute().returnContent().toString();

		System.out.println(returnStr);
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print(returnStr); // 요청한 곳으로 보낼 출력데이터
	}

}