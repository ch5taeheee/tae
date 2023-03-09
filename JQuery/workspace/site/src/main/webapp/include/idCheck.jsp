<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String userId = request.getParameter("uId");
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	String url="jdbc:oracle:thin:@localhost:1521:xe";
	Connection conn = DriverManager.getConnection(url, "ljy92", "java");
	Statement stmt = conn.createStatement();
	String sql = "select mem_id from member"
				+" where mem_id ='" + userId +"'";
	ResultSet rs = stmt.executeQuery(sql);
	//결과 있을 때 id사용불가
	if(rs.next()){
%>		
		{
			"Code":"fail",
			"msg":"사용불가"
		}
<%		
	//결과 없을 때 id사용가능
	}else{
%>		
		{
			
			"Code":"ok",
			"msg":"사용가능"
			
		}
<%		
	}

%>