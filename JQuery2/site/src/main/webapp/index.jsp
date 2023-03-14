<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!-- header -->
<%@ include file="../include/header.jsp" %>
  
<%@ include file="../include/nav1.jsp" %>


<%
	String joinCd = (String)request.getAttribute("joinCode");
	String detailCd = (String)request.getAttribute("detail");
	String wrtCd = (String)request.getAttribute("write");


	//join코드 있을때 회원가입페이지 보이기
	if(joinCd == "yes"){
%>		
	<%@ include file="./join_novalid.jsp" %>
<%
	//join코드 없을 때 기존 메인페이지 보이기
	}else{
		//login코드 있을 때(회원일때 게시판 보이기)
		if(loginCd != null){

			if(wrtCd != null){
%>
				<%@ include file="./write.jsp" %>
<%
			}else if(detailCd != null){
%>			
				<%@ include file="./detail.jsp" %>
<%				
			}else{
%>
				<%@ include file="./board.jsp" %>
<%
			}
		//login코드 없을 때(비회원일때 메인페이지)
		}else{
%>
			<div class="col-sm-8 text-left"> 
		      <h1>Welcome</h1>
		      <hr>
		      <h2>public Main page</h2>
		    </div>	
<%
		}
%>
		
		
<%
	}
%>



조인코드[<%=joinCd %>]
로긴코드[<%=session.getAttribute("loginCode") %>]


	

    
    
<!--     nav2 -->
<%@ include file="../include/nav2.jsp" %>

<!-- footer -->
<%@ include file="../include/footer.jsp" %>

</body>
</html>
