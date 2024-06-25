<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<article id="article">
	<form method="post" name="findIdForm" action="findId";>
	<h2>아이디 찾기</h2>
		<div class="field">
			<label>이름</label><input name="name" type="text"/>
		</div>
	<div class="field">
			<label>이메일</label><input name="email" type="text" id="email"/>
	</div>
		<input type="submit" value="이메일 인증 받기" onClick="return findId();"/>
		<div style="font-size:80%; font-weight:bold; margin-left:20px;">${message}</div>
</form>
</article>
<script src="script/member/userLogin.js"></script>
<%@ include file="../footer.jsp"%>