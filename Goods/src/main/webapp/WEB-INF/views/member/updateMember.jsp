<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>

<link rel="stylesheet" href="resources/css/update.css">
<meta charset="UTF-8">
<section id="section">
		<article id="article">
			<form action="updateMember.do" method="post" name="formm" id="updateForm">
			<h3>회원정보 수정</h3>
			<div class="field">
				<label>아이디</label><input type="text" name="userid" value="${loginUser.userid}" readonly>
			</div>
			<div class="field">
				<label>비밀번호</label><input type="password" name="pwd">
			</div>
			<div class="field">
				<label>비밀번호 확인</label><input type="password" name="pwdCheck">
			</div>
			<div class="field">
				<label>이름</label><input type="text" name="name" value="${loginUser.name}">
			</div>
			<div class="field">
				<label>핸드폰</label><input type="text" name="phone" value="${loginUser.phone}">
			</div>
			<div class="field">
				<label>이메일</label><input type="text" name="email" value="${loginUser.email}">
			</div>
			
			<h3>주소 수정</h3>
			<div class="field">
				<label>우편번호 검색</label>
					<input type="text" name="zip_code" readonly/>
					<input type="button" id="findAddressBtn"  onClick="post_zip();" value="우편번호 찾기"/>
			</div>
			<div class="field">
				<label>주소</label><input type="text" name="address" value="${loginUser.address}" readonly>
			</div>
			<div class="field">
				<label>상세 주소</label><input type="text" name="d_address" value="${loginUser.d_address}">
			</div>
			
			<div class="btn1">
				<input type="button" value="회원정보 수정" onClick="return go_updateMember()"/>
			</div>
			<div class="btn2">
				<input type="button" value="회원 탈퇴하기" onClick="goodbye('${loginUser.pwd}')">
			</div>
		</form>
		</article>
</section>
<script src="<c:url value='/resources/js/member/userLogin.js'/>"></script>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
