<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>




<!-- header -->
<%@ include file="../include/header.jsp"%>

<%@ include file="../include/nav1.jsp"%>

<%
String joinCd = (String) request.getAttribute("joinCode");

if (joinCd == "yes") {
%>
<%@ include file="../join_novalid.jsp"%>
<%
//회원가ㅣ입코드 없을 때 기존 메인페이지 보이기
} else {
%>


<div class="col-sm-8 text-left">
	<h1>Welcome</h1>
	<hr>
	<p>private main page</p>
</div>
<%
}
%>




조인코드[<%=joinCd%>]

<!-- nav1 -->
<!-- nav2 -->
<%@ include file="../include/nav2.jsp"%>

<!-- footer -->
<%@ include file="../include/footer.jsp"%>

</body>
</html>
