<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.apache.commons.beanutils.BeanUtils"%>
<%@page import="vo.memeberVO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//하나로 묶인 객체 형태로 데이터가 넘어옴...
//beanUtils 라이브러리를 이용해서 편리하게 데이터를 반환받음
//주의! form의 name속성과 vo의 필드명을 일치시켜야  자동 매핑됨

MemberVO vo = new MemberVO();
BeanUtils.populate(vo, request.getParameterMap());

//jdbc db연결하기
//드라이버로딩
Class.forName("oracle.jdbc.driver.OracleDriver");

//객체 생성
String url = "jdbc:oracle:thin:@localhost:1521:xe";
Connection conn = DriverManager.getConnection(url, "ljy92", "java");

//sql조회 객체 생성
Statement stmt = conn.createStatement();

//쿼리 조회 후 결과 받기
String sql = "insert into member(" + " mem_id, mem_pass, mem_name, mem_bir,"
		+ " mem_zip, mem_add1, mem_add2, mem_hp, mem_mail" + ") values (" + "'" + vo.getMem_id() + "'," + "'"
		+ vo.getMem_pass() + "'," + "'" + vo.getMem_name() + "'," + "'" + vo.getMem_bir() + "'," + "'" + vo.getMem_zip()
		+ "'," + "'" + vo.getMem_add1() + "'," + "'" + vo.getMem_add2() + "'," + "'" + vo.getMem_hp() + "'," + "'"
		+ vo.getMem_mail() + "')";
int rst = stmt.executeUpdate(sql);
%>
<%=rst%>




