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
</style>
</head>
<body>
	<div class="col-sm-8">
	
	  <h4>회원가입</h4>
	  <hr>
	  <form class="form-horizontal" method="post" onsubmit="return valid()">
	    <div class="form-group">
	      <label for="id" class="control-label col-sm-2">아이디<span class="rq"> *</span></label>
	      <span class="sp"></span>
	      <div class="col-sm-4">
	        <input type="text" class="form-control" id="id" name="mem_id" placeholder="Enter id"
	        required pattern="[a-zA-Z][a-zA-Z0-9]{3,7}">
	      </div>
	      <div class="col-sm-6" style="text-align: left;">
<!--             <button type="button" class="btn btn-success btn-sm" id="idChk">중복검사</button> -->
            <span id="disp"></span>
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="pass" class="control-label col-sm-2">비밀번호<span class="rq"> *</span></label>
	      <div class="col-sm-4">
	        <input type="text" class="form-control" id="pass" name="mem_pass" required
	        pattern="(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+]).{8,}">
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="name" class="control-label col-sm-2">이름<span class="rq"> *</span></label>
	      <span class="sp"></span>
	      <div class="col-sm-4">
	        <input type="text" class="form-control" id="name" name="mem_name" required
	        pattern="[가-힣]{2,5}">
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="bir" class="control-label col-sm-2">생년월일</label>
	      <div class="col-sm-4">
	        <input type="date" class="form-control" id="bir" name="mem_bir">
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="hp" class="control-label col-sm-2">연락처<span class="rq"> *</span></label>
	      <div class="col-sm-4">
	        <input type="text" class="form-control" id="hp" name="mem_hp" placeholder="010-0000-0000"
	        required pattern="[0-9]{3}-[0-9]{3,4}-[0-9]{4}">
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="mail" class="control-label col-sm-2">이메일</label>
	      <div class="col-sm-4">
	        <input type="email" class="form-control" id="mail" name="mem_mail">
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="add1" class="control-label col-sm-2">우편번호<span class="rq"> *</span></label>
	      <div class="col-sm-4">
	        <input type="text" class="form-control" id="postAddr" name="mem_zip" required>
	      </div>
	      <div class="col-sm-2">
	        <button type="button" id="addrBtn" class="btn btn-info btn-sm">주소검색</button>
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="add1" class="control-label col-sm-2">주소<span class="rq"> *</span></label>
	      <div class="col-sm-6">
	        <input type="text" class="form-control" id="addr1" name="mem_add1" required>
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <label for="add2" class="control-label col-sm-2">상세주소<span class="rq"> *</span></label>
	      <div class="col-sm-6">
	        <input type="text" class="form-control" id="addr2" name="mem_add2" required>
	      </div>
	    </div>
	    
	    <div class="form-group">
	      <div class="col-sm-offset-2 col-sm-6">
	        <button class="btn btn-default">가입하기</button>
	        <span id="joinspan"></span>
	      </div>
	    </div>
	  </form>
	  
	</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

// 	$('#idChk').on('click',function(){});
	$('#id').on('keyup',function(){
		$('#disp').html("");
		
		let userId = $('#id').val();
		
		//공백제거
		if(userId.trim().length == 0) return;
		
		//jquery방식 ajax
		$.ajax({
			//type: 'get',
			url: 'idCheck.jsp',
			data: {'uId':userId}, //객체로 넘겨도 자체적으로 urlencoding후 데이터 전송
			success: function(rst){
				console.log("결과>>" , rst);
				if(rst.code == "ok"){
					$('#disp').html(rst.msg).css('color','green');
				}else{
					$('#disp').html(rst.msg).css('color','red');
				}
			},
			error: function(xhr){
				alert("에러발생>> " + xhr.status);
			},
			dataType: 'json'
		});
		
	});
	
	
	
	$('#addrBtn').on('click', sample4_execDaumPostcode);
	
	//다음주소api
	function sample4_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postAddr').value = data.zonecode;
                document.getElementById("addr1").value = roadAddr;
                document.getElementById("addr1").value = data.jibunAddress;
            }
        }).open();
    }
	
	function valid(){
		console.log(event.type); //submit
		event.preventDefault(); //submit기능 중지 => 지정된 action 또는 현재 url로 submit
		
// 		let obj = $('form').serialize();
		let objArr = $('form').serializeArray();
// 		console.log(objArr);
		
		//jQuery ajax작성
		$.ajax({
			type: 'post',
			url: 'serializeArr.jsp',
			data: JSON.stringify(objArr), //직렬화
// 			data: obj,
			success: function(result){
			  console.log(result)
			  if(result == 1){
				  //alert("가입성공!!");
				  //boolean값을 반환
				  let conf = confirm("가입성공했는데, 로그인페이지로 이동할래?");
				  if(conf){
					  location.href = "login.html";
				  }
				  $('#joinspan').html("가입성공!!").css('color','gold');
			  }else{
				  $('#joinspan').html("가입실패..").css('color','gray');
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













