<%@page import="org.apache.commons.collections4.bag.SynchronizedSortedBag"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%


	//넘어오는 데이터 읽기 - 버퍼를 이용한 입출력 객체 홀용
	BufferedReader rd = request.getReader();
	String jsonData = rd.readLine();
	//System.out.print(jsonData);
	


	// 직렬화되어 넘어온 데이터를 역직렬화 해야 함
	// gson 라이브러리 활용
	
	
	
	
	// 역직렬화 이후 BeanUtils를 활용하는 방식 동일


%>