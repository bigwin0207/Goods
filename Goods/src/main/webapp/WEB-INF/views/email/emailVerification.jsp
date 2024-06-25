<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="/WEB-INF/jsp/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/email.css'/>">
<div id="popup">
		<form method="post" name="formm" action="searchId.do">
		   	<input type="hidden" name="name" value="<%= session.getAttribute("name") %>">
        	<input type="hidden" name="email" value="<%= session.getAttribute("email") %>">
						<label>본인 인증 코드&nbsp;&nbsp;&nbsp;</label>
						<input type="text" name="securityCodeInput" id="securityCodeInput">
						<div><input type="submit" value="인증" onClick="return codeOK();"/></div>
						<div id="message" style="font-size:80%; font-weight:bold">${message}</div>
						<div id="timer"></div>
		</form>	
</div>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
<script src="<c:url value='/resources/js/member/userLogin.js'/>"></script>
<script>
    // 3분 타이머 함수
    function startTimer(duration, display) {
        var timer = duration, minutes, seconds;
        var intervalId = setInterval(function () {
            minutes = parseInt(timer / 60, 10);
            seconds = parseInt(timer % 60, 10);

            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.textContent = minutes + ":" + seconds;

            if (--timer < 0) {
            	display.style.display = 'none'; 
                clearInterval(intervalId);
                document.getElementById('securityCodeInput').disabled = true;
                document.querySelector('input[type="submit"]').disabled = true;
                document.querySelector('input[type="submit"]').value = "인증시간 만료";
                document.querySelector('#message').style.display = 'none';
            }
        }, 1000);
    }

    // 페이지 로드 시 타이머 시작
    window.onload = function () {
        var threeMinutes = 60 * 3,
            display = document.querySelector('#timer');
        startTimer(threeMinutes, display);
    };
</script>