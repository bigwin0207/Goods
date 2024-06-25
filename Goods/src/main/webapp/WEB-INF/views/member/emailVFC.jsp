<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/member.css">
<title>Insert title here</title>
</head>
<body>

<div id="popup">
		<h2>이메일 인증번호 입력</h2>
		2분 이내에 이메일로 전송된 인증번호를 입력해주세요!!<br/>
		<input type="text" id="vemail" name="vemail" size="16"  placeholder="6자리 코드 입력"
			style="height: 25px; margin: 10px auto;">
		<input type="button" value="인증하기"  id="m_confirm" onClick="m_confirm(${verificationCode})">
		<div id="timer" style="margin-left: 10px; font-weight: bold"></div>		
</div>
<script src="<c:url value='/resources/js/member/newID.js'/>"></script>
<script>

function startTimer(count, display){
		var timer = count, min, sec;
		var intervalid = setInterval(function(){
			min = parseInt(timer / 60, 10);
			sec = parseInt(timer % 60, 10);
			
			min = min < 10 ? "0" + min : min;
			sec = sec < 10 ? "0" + sec : sec;
			
			display.textContent = min + ":" + sec;
			
			if(--timer < 0) {
				clearInterval(intervalid);
				document.getElementById('vemail'),disabled = true;
				document.querySelector('input[type="button"]').disabled = true;
				document.querySelector('input[type="button"]').value = "세션 만료";
            	display.style.display = 'none'; 
			}
		},1000);
	}
	// 페이지 로드 시 타이머 시작
	window.onload = function () {
	    var twoMins = 60*2,
	        display = document.querySelector('#timer');
	    startTimer(twoMins, display);
	};

</script>
<script src="<c:url value='/resources/js/member/newID.js'/>"></script>
</body>
</html>