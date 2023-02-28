package kr.or.ddit.basic;

import java.io.File;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NamedNodeMap;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

public class T02DOMParsingTest {

	public void parse() throws ParserConfigurationException, SAXException, IOException {

		// XML문서를 생성하기 위한 DocumentBuider 객체 생성
		DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = dbf.newDocumentBuilder();

		// Document 객체 생성
		Document document = builder.parse(new File("./booklist.xml")); // 이미 만들어진것을 dom형태로?

		// DOM Document 객체로부터 루트 엘리먼트 객체 접근하기
		Element root = document.getDocumentElement();
		System.out.println("루트 엘리먼트 태그명 : " + root.getTagName());

		// 하위 엘리먼트 접근방법1 : getElemnetsByTagName() 메서드 이용
		NodeList bookNodeList = root.getElementsByTagName("book");
		Node firstBookNode = bookNodeList.item(0); // 첫번째 항목

		// 속성 접근방법 1 : 엘리먼트 객체의 getAttribute() 메서드 이용
		Element firstBookElement = (Element) firstBookNode;
		System.out.println("엘리먼트 객체의 getAttribute() 메서드 이용 => " + firstBookElement.getAttribute("isbn"));

		// 속성 접근방법 2 : 노드객체의 getAttributes() 메서드 이용(속성노드 접근하기)
		NamedNodeMap nodeMap = firstBookNode.getAttributes();
		System.out.println("노드객체의 getAttributes() 메서드 이용 => " + nodeMap.getNamedItem("isbn").getNodeValue());

		// 하위 엘리먼트 접근방법 2 : getChildNodes() 메서드 이용
		NodeList firstBookChildNodeList = firstBookNode.getChildNodes();
		Node n = firstBookChildNodeList.item(0);

		System.out.println("노드명 : " + n.getNodeName() + ", 노드값 : " + n.getNodeValue() + ", 노드타입 : " + n.getNodeType()
				+ ", 컨텐트값: " + n.getTextContent());

		// 전체 출력하기
		System.out.println("----------------------------------------------------------");
		System.out.printf("%8s %8s %15s %10s %8s\n", "ISBN", "분류", "제목", "저자", "가격");
		System.out.println("----------------------------------------------------------");

		for (int i = 0; i < bookNodeList.getLength(); i++) {
			Element el = (Element) bookNodeList.item(i);

			String isbn = el.getAttribute("isbn");
			String kind = el.getAttribute("kind");
			String title = el.getElementsByTagName("title").item(0).getTextContent();
			String author = el.getElementsByTagName("author").item(0).getTextContent();
			String price = el.getElementsByTagName("price").item(0).getTextContent();

			System.out.printf("%8s %8s %15s %10s %8s\n", isbn, kind, title, author, price);
			

		}

	}

	public static void main(String[] args) throws Exception {
		new T02DOMParsingTest().parse();
	}

}
