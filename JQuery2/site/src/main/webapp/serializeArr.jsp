<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%
	BufferedReader rd = request.getReader();
	String jsonData = rd.readLine();
	System.out.print(">>> " + jsonData);
%>