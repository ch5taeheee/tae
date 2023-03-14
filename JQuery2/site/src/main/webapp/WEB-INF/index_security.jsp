<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- header -->
<%@ include file="../include/header.jsp" %>
  
<%@ include file="../include/nav1.jsp" %>


<%
	String joinCd = (String)request.getAttribute("joinCode");

	//회원가입코드 있을때 회원가입페이지 보이기
	if(joinCd == "yes"){
%>		
	<%@ include file="../join_novalid.jsp" %>
<%
	//회원가입코드 없을 때 기존 메인페이지 보이기
	}else{
%>
		<div class="col-sm-8 text-left"> 
	      <h1>Welcome</h1>
	      <hr>
	      <h2>private Main page</h2>
	    </div>
<%
	}
%>



조인코드[<%=joinCd %>]


	

    
    
<!--     nav2 -->
<%@ include file="../include/nav2.jsp" %>

<!-- footer -->
<%@ include file="../include/footer.jsp" %>

</body>
</html>
