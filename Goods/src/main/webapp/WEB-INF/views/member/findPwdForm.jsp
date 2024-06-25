<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<link rel="stylesheet" href="<c:url value='/resources/css/findId_PwdForm.css'/>">
<article id="article">
	<form method="post" name="findPwdForm" action="findPwd.do";>
	<h2>비밀번호 찾기</h2>
		<div class="field">
			<label>아이디</label><input name="userid" type="text"/>
		</div>
	<div class="field">
			<label>이메일</label><input name="email" type="text" id="email"/>
	</div>
		<input type="submit" value="이메일 인증 받기" onClick="return findPwd();"/>
		<div style="font-size:80%; font-weight:bold">${message}</div>
</form>
</article>
<script src="<c:url value='/resources/js/member/userLogin.js'/>"></script>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>