<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.rq {
  color: red;
  font-size: 1.5em;
  font-weight: bold;
}
.col-xs-8 {
  margin-top: 10%;
}
label {
  text-align: left;
}
</style>
</head>
<body>
	<div class="col-xs-8">
	
	  <form onsubmit="valid()">
	  
	    <div class="form-group col-xs-12">
	      <label for="" class="col-xs-2">이름<span class="rq"> *</span></label>
	      <div class="col-xs-10">
	        <input type="text" class="txt form-control" name="writer" id="" required>
	      </div>
	    </div>

	    <div class="form-group col-xs-12">
	      <label for="" class="col-xs-2">메일</label>
	      <div class="col-xs-10">
	        <input type="text" class="txt form-control" name="mail" id="">
	      </div>
	    </div>

	    <div class="form-group col-xs-12">
	      <label for="" class="col-xs-2">제목<span class="rq"> *</span></label>
	      <div class="col-xs-10">
	        <input type="text" class="txt form-control" name="subject" id="" required>
	      </div>
	    </div>

	    <div class="form-group col-xs-12">
	      <label for="" class="col-xs-2">비번<span class="rq"> *</span></label>
	      <div class="col-xs-10">
	        <input type="text" class="txt form-control" name="password" id="" required>
	      </div>
	    </div>
	    
	    <div class="form-group col-xs-12">
	      <label for="" class="col-xs-2">내용</label>
	      <div class="col-xs-10">
	        <input type="text" class="txt form-control" name="content" id="">
	      </div>
	    </div>
	    
	    <div class="form-group col-xs-12">
	    	<input type="submit" class="btn btn-success" value="전송">
	    </div>
	    
	  </form>
	</div>
	
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.serializeJSON/3.2.1/jquery.serializejson.min.js" referrerpolicy="no-referrer"></script>
<script>
	function valid(){
		event.preventDefault(); //submit기능막기
// 		let data = $('form').serialize(); //직렬화
// 		let data = $('form').serializeArray(); //객체배열 직렬화
		let data = $('form').serializeJSON(); //JSON Object 직렬화
		
		//jQuery- ajax작성
		$.ajax({
			type: 'post',
			url: '/site/Write',
			data: JSON.stringify(data),
			success: function(rst){
				//alert(rst);
				if(rst > 0){
					location.href = "/site/Main";
				}else{
					alert("fail page go.....");
				}
			},
			error: function(xhr){
				alert(xhr.status);
			},
			dataType: 'text'
		});
		
		
		
		
		
		
		
	}

</script>
</body>
</html>