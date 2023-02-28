package kr.or.ddit.basic;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.Iterator;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class JsonSimpleParsingExam {
	public void parse() throws ParserConfigurationException, SAXException, IOException, ParseException {

		String svcKey = "Grid_20150827000000000227_1"; // 레시피 재료 정보 조회 서비스
		String apiKey = "1df7e8571e8df3f8cbc9b87691ca7d3e4d04f03c593d477e52bf67b03f0b6e1c"; // 개인별 발급.
		String startIdx = "1"; // 레시피 재료 시작 순번
		String endIdx = "5"; // 레시피 재료 종료 순번
		String recipeId = "373"; // 래시피가 궁금한 음식 ID

		URL url = new URL("http://211.237.50.150:7080/openapi/" + apiKey + "/json/" + svcKey + "/" + startIdx + "/"
				+ endIdx + "?RECIPE_ID=" + recipeId);

		System.out.println(url);

		JSONParser parser = new JSONParser();

		Object obj = parser.parse(new InputStreamReader(url.openStream()));

		JSONObject jsonObj = (JSONObject) obj;

		JSONObject rootObj = (JSONObject) jsonObj.get(svcKey);

		long totalCnt = (long) rootObj.get("totalCnt");

		url = new URL("http://211.237.50.150:7080/openapi/" + apiKey + "/json/" + svcKey + "/" + startIdx + "/"
				+ totalCnt + "?RECIPE_ID=" + recipeId);

		parser = new JSONParser();

		obj = parser.parse(new InputStreamReader(url.openStream()));

		jsonObj = (JSONObject) obj;

		rootObj = (JSONObject) jsonObj.get(svcKey);

		JSONObject result = (JSONObject) rootObj.get("result");

		String code = (String) result.get("code");

		if (code.equals("INFO-000")) { // 응답이 정상일 경우....

			JSONArray list = (JSONArray) rootObj.get("row");

			Iterator<JSONObject> it = list.iterator();

			while (it.hasNext()) {
				JSONObject jo = it.next();
			}

		}

	}

	public static void main(String[] args)
			throws ParserConfigurationException, SAXException, IOException, ParseException {
		new JsonSimpleParsingExam().parse();
	}
}
