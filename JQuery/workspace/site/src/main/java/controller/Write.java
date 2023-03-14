package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.InvocationTargetException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import service.BoardServiceImpl;
import service.IBoardService;
import vo.BoardVO;

@WebServlet("/Write")
public class Write extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Write() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setAttribute("write", "yes");
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		BufferedReader rd = request.getReader();
		String data = rd.readLine();
		System.out.println(data);

		Map<String, String> map = new HashMap<String, String>();
		
		JsonParser parser = new JsonParser();

		// objectArray (객체배열데이터)
//		JsonArray jsonArr = (JsonArray)parser.parse(data);
//		for(int i=0; i<jsonArr.size(); i++) {
//			JsonObject jsonObj = (JsonObject)jsonArr.get(i);
//			String key = jsonObj.get("name").getAsString();
//			String value = jsonObj.get("value").getAsString();
//			map.put(key, value);
//		}
		
		// JSON Object 데이터
		JsonObject jsonObj = (JsonObject)parser.parse(data);
		Iterator<String> itr = jsonObj.keySet().iterator();
		while(itr.hasNext()) {
			String key = itr.next();
			String value = jsonObj.get(key).getAsString();
			map.put(key, value);
		}
		
		  BoardVO vo = new BoardVO();
		  try { 
			  	BeanUtils.populate(vo, map); 
		  } catch (IllegalAccessException e) { 
			  // TODO Auto-generated catch block e.printStackTrace(); 
		  } catch (InvocationTargetException e) {
			  // TODO Auto-generated catch block
			  e.printStackTrace(); 
		  }
		  vo.setWip(request.getRemoteAddr()); // 작성자(클라이언트)의 ip정보
		  
		  //서비스 객체 얻기 
		  IBoardService service = BoardServiceImpl.getInstance();
		  int result = service.insertBoard(vo);
		  
		  System.out.println("반환값" + result);
		  
		  PrintWriter out = response.getWriter();
		  out.print(result); //입력된 형태 그대로 출력 , write()는 해당하는 아스키코드로 변환한 값을 출력
		 
	}
}
