<%@page import="vo.BoardVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.pager {
  float: left;
}
#pageArea {
  display: flex;
  justify-content: center;
}
#writeArea {
  display: flex;
  justify-content: flex-end;
  margin: 10px 0;
}
td, th {
  text-align: center;
}
</style>
</head>
<body>
	<div class="col-sm-8 text-left">
	
		<!-- 글쓰기 영역 -->
		<div id="writeArea">
			<input type="button" id="wrtBtn" value="글작성"
				class="btn-xs btn-primary">
		</div>
		
	
		<!-- 리스트 영역 -->
		<div id="listArea">
			<table class="table table-hover">
			    <thead>
			      <tr>
			        <th width="40%">제목</th>
			        <th width="15%">작성자</th>
			        <th width="30%">작성일</th>
			        <th width="15%">조회수</th>
			      </tr>
			    </thead>
			    <tbody>
			    <%
			    	List<BoardVO> list = (List<BoardVO>)request.getAttribute("list");
			    	if(list != null){
			    
				    	for(int i=0; i<list.size(); i++){
				    %>
				      <tr class="detail" id="<%= list.get(i).getNum() %>">
				        <td><%= list.get(i).getSubject() %></td>
				        <td><%= list.get(i).getWriter() %></td>
				        <td><%= list.get(i).getWdate() %></td>
				        <td><%= list.get(i).getHit() %></td>
				      </tr>
				    <%
				    	}//for end
				    
			    	}else{
			    	%>
			    		<tr>
					        <td colspan="4" style="text-align: center;">내용없음</td>
					     </tr>
					<%
			    	}
				    %>  
			    </tbody>
			  </table>
		</div>
<% 
		if(list != null){
%>
			<!-- 페이징 영역 -->
			<div id="pageArea">
				
				<ul class="pager">
				  <li class="prev"><a href="#">Prev</a></li>
				</ul>
				
				<ul class="pagination pager">
				<%
					int sPage = (int)request.getAttribute("sPage");
					int ePage = (int)request.getAttribute("ePage");
					int ttPage = (int)request.getAttribute("ttPage");
					int cPage = (int)request.getAttribute("cPage");
				  
					for(int i=sPage; i<=ePage; i++){
					  //페이지 번호 활성화
					  if(cPage == i){
				%>
						  <li class="active"><a href="#"><%=i %></a></li>
				<%
					  }else{
				%>  	
						  <li><a href="#"><%=i %></a></li>
				<%
					  }
					}//for end
				%>
				</ul>
				
				<ul class="pager">
				  <li class="next"><a href="#">Next</a></li>
				</ul>
			</div>
		<%} %>
	</div>
<script>
	
	//페이지 번호 클릭이벤트
	$('.pagination li').on('click',function(){
		//alert($(this).text());
		location.href = "/site/Main?page=" + $(this).text();
	});


	let currentPage = 0;
	//다음(next)버튼 클릭이벤트
	$('.next').on('click',function(){
		
		//현재 페이지와 전체페이지(마지막페이지) 수 비교를 조건으로 사용
		//각 페이지 단위로 이동
		<%-- if( <%=request.getAttribute("cPage")%> == <%=request.getAttribute("ttPage")%>){
			currentPage = <%=request.getAttribute("cPage")%>;
		}else{
			currentPage = <%=request.getAttribute("cPage")%> + 1;
		}
		location.href="/site/Main?page=" + currentPage; --%>
		
		//현재페이지의 다음 페이지로 이동
		currentPage = parseInt($('.pagination').children().last().text()) + 1;
// 		alert(currentPage);
		if(<%=request.getAttribute("ttPage")%> < currentPage) return;
		location.href="/site/Main?page=" + currentPage; 		
	});
	
	//이전(prev)버튼 클릭이벤트
	$('.prev').on('click',function(){
		//현재 페이지와 첫페이지(1) 비교
		//각 페이지 단위로 이동
		<%-- if( <%=request.getAttribute("cPage")%> == 1){
			currentPage = <%=request.getAttribute("cPage")%>;
		}else{
			currentPage = <%=request.getAttribute("cPage")%> - 1;
		}
		location.href="/site/Main?page=" + currentPage; --%>
		
		//현재페이지의 이전 페이지로 이동
		currentPage = parseInt($('.pagination').children().first().text()) - 1;
// 		alert(currentPage);
		if(currentPage <= 0) return;
		location.href="/site/Main?page=" + currentPage;
	});


	//게시글 작성 이벤트
	$('#wrtBtn').on('click',function(){
		location.href="/site/Write";
	});
	
	
	//상세페이지 보기 이벤트
	$('.detail').on('click',function(){
		let id = $(this).attr('id');
		location.href = "/site/Detail?uniqueId=" + id
						+ "&page=" + <%=request.getAttribute("cPage")%>;
	});	
	
	

</script>	
</body>
</html>