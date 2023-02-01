<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <h1> JSP : Java Server Page </h1> <!-- h1은 블럭요소이기 때문에 <br> 넣을 필요가 없다. -->
    
    <!-- 자바 코드 작성 -->
    <!-- form으로 작성했을 때 한글 깨짐 -> request.setCharacterEncoding("utf-8"); 작성-->
    
    <% 
    	request.setCharacterEncoding("utf-8");
    	String nm = request.getParameter("erum");
    	String as = request.getParameter("alias");
    %>
    
    이름은 <%= nm %> <br>
    별명은 <%= as %> 입니다. 
    <%--  <%= "별명은 " + as + " 입니다." %> --%> 
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>