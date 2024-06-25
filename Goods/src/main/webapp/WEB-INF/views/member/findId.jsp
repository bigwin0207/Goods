<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form method="post" name="findIdForm" action="findId.do">
	<h2>아이디 찾기</h2>
		<div class="field">
			<label>이름</label><input name="name" type="text"/>
		</div>
	<div class="field">
			<label>이메일</label><input name="email" type="text"/>
	</div>
		<input type="button" value="제출" onClick="return findId();">
<script src="resources/js/member/userLogin.js"></script>
</form>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</html>