<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String uId = request.getParameter("userId");
   String uPw = request.getParameter("userPw");
   
   //JDBC(Java DataBase Connectivity)
   // : 자바에서 DB에 접속할 수 있게 하는 API
   // pool방식을 이용하지 않고 정보에 접근할 때마다 객체를 생성하므로 권장되는 방식은 아니다.
   
   //작업 흐름 >> 드라이버매니저 생성 후 객체 생성하고 DB연결, SQL실행, DB연결종료

   Class.forName("oracle.jdbc.driver.OracleDriver");
   String url = "jdbc:oracle:thin:@localhost:1521:xe";
   Connection conn = DriverManager.getConnection(url, "CTH98", "java");
   Statement stmt = conn.createStatement();
   String sql = "select mem_id from member"
                 + " where mem_id = '" + uId 
                 + "' and mem_pass = '" + uPw + "'";
   ResultSet rs = stmt.executeQuery(sql);
   
   if(rs.next()){
%>
      {"rst" : "ok"}
<%
   }else{
%>
      {"rst" : "fail"}
<%
   }
%>
   
   
   
   