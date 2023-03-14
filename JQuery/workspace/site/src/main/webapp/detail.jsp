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
table {
  margin-top: 10%;
}
.btns {
  display: flex;
  justify-content: space-between;
}
</style>
</head>
<body>
	<%
		List<BoardVO> list = (List<BoardVO>)request.getAttribute("info");
	%>
	<div class="col-sm-8 text-left"> 
		<div class="container-fluid">
		  <table class="table table-bordered">
		    <tr>
	          <td>작성자</td>
	          <td><%=list.get(0).getWriter() %></td>
	          <td>작성일</td>
	          <td><%=list.get(0).getWdate() %></td>
	          <td>조회수</td>
	          <td><%=list.get(0).getHit() %></td>
	        </tr>
	        <tr>
	          <td>제목</td>
	          <td id="tt" colspan="5"><%=list.get(0).getSubject() %></td>
	        </tr>
	        <tr>
	          <td>내용</td>
	          <td id="ctt" colspan="5"><%=list.get(0).getContent() %></td>
	        </tr>
		  </table>
		  
		  <div class="btns">
		  	<div>
		  	  <input type="button" id="mdf_<%=list.get(0).getNum() %>" class="btn-xs btn-danger" value="수정">
		  	  <input type="button" id="dlt_<%=list.get(0).getNum() %>" class="btn-xs btn-warning" value="삭제">
		  	</div>
		  	<input type="button" id="list" class="btn-xs btn-primary" value="목록">
		  </div>
		</div>	
	</div>
<script>
	
	let goList = function(){
		location.href="/site/Main?page=" + <%=request.getAttribute("cPage") %>;
	}
	
	//목록으로 이동 (페이지 현상유지)
	$('#list').on('click', goList);
	
	//게시글 삭제
	$('.btns input').eq(1).on('click',function(){
		
		let id = $(this).attr('id').split("_")[1];
		let conf = confirm("삭제할까요?");
		if(conf){
			//삭제처리 ajax작성
			$.ajax({
				type: 'post',
				url: '/site/Delete',
				data: {boardNo : id}, //게시물 no
				success: function(rst){
					console.log(rst);
					if(rst){
						alert("삭제되었습니다");
						goList();
					}
				},
				error: function(xhr){
					alert("상태:" + xhr.status);
				},
				dataType: 'text'
			});
		}
	});
	
	let subject, content = '';
	function print1(){
		subject = $('#tt').children().val();
	}
	function print2(){
		content = $('#ctt').children().val();
	}
	
	
	//게시글 수정
	$('.btns input').eq(0).on('click',function(){
		
		//수정할 정보 가져오기
		$('#tt').html("").append("<input class='form-control' value='<%=list.get(0).getSubject() %>' onkeyup='print1()'>");
		$('#ctt').html("").append("<textarea class='form-control' onkeyup='print2()'><%=list.get(0).getContent() %></textarea>");
		
		$(this).click(function(){
			
			let num = $(this).attr('id').split("_")[1];
			
			//console.log(subject, "|||||", content);
			//데이터 수정 ajax
			$.ajax({
				type: 'post',
				url: '/site/Modify',
				data: {
					'uniqueId': num,
					'subject': subject,
					'content': content
				},
				success: function(rst){
					console.log(rst);
					location.reload();
				},
				error: function(xhr){
					alert(xhr.status);
				},
				dataType: 'text',
			});
			
			
			
			
			
			
		});
		
		
		
		
		
		
		
	});	
	
</script>	
</body>
</html>