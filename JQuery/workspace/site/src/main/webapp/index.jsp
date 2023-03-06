<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>



	<!-- header -->
	<%@ include file="../include/header.jsp"%>
	<!-- nav1 -->
	<%@ include file="../include/nav1.jsp"%>

<%

	String joinCd = (String)request.getAttribute("joinCode");

	if(joinCd == "yes"){
		%>	
		
	<%@ include file="../include/nav1.jsp"%>
		
<%		
	}else{
		%>		
		<div class="col-sm-8 text-left">
		<h1>Welcome</h1>
		<hr>
		<h3>Test</h3>
		<p>Lorem ipsum...</p>
	</div>

<%		
	}
%>

	조인코드[<%=joinCd %>]
	
	



	<!-- nav2 -->
	<%@ include file="../include/nav2.jsp"%>



	<!--  footer-->
	<%@ include file="../include/footer.jsp"%>



</body>
</html>

</body>
</html>