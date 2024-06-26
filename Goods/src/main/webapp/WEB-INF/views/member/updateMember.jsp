<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="../member/update.css">
<section id="section">
		<article id="article">
			<form action="updateMember" method="post" name="formm" id="updateForm">
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

				<div class="field">
					<label>Zip Code</label>
					<div>
						<input type="text" id="sample6_postcode"name="zip_num" readonly value="${dto.zip_num}">
						<input type="button" value="우편번호 찾기" onclick="sample6_execDaumPostcode()">
					</div>
				</div>
				<div class="field">
					<label>Address</label><input type="text" id="sample6_address" name="address1" value="${dto.address1}" readonly />
				</div>
				<div class="field">
					<label>detail Address</label><input type="text" id="sample6_detailAddress" value="${dto.address2}" name="address2" />
				</div>
				<div class="field">
					<label>Extra Address</label><input type="text" id="sample6_extraAddress" value="${dto.address3}" name="address3" />
				</div>

				<!-- 다음 카카오 도로명 주소 검색을 위한 자바스크립트 코드들 -->
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

				<script>
					function sample6_execDaumPostcode() {
						new daum.Postcode( {
							oncomplete: function(data) {
								// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

								// 각 주소의 노출 규칙에 따라 주소를 조합한다.
								// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
								var addr = ''; // 주소 변수
								var extraAddr = ''; // 참고항목 변수

								//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
								if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
									addr = data.roadAddress;
								} else { // 사용자가 지번 주소를 선택했을 경우(J)
									addr = data.jibunAddress;
								}

								// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
								if(data.userSelectedType === 'R'){
									// 법정동명이 있을 경우 추가한다. (법정리는 제외)
									// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
									if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
										extraAddr += data.bname;
									}
									// 건물명이 있고, 공동주택일 경우 추가한다.
									if(data.buildingName !== '' && data.apartment === 'Y'){
										extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
									}
									// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
									if(extraAddr !== ''){
										extraAddr = ' (' + extraAddr + ')';
									}
									// 조합된 참고항목을 해당 필드에 넣는다.
									document.getElementById("sample6_extraAddress").value = extraAddr;

								} else {
									document.getElementById("sample6_extraAddress").value = '';
								}

								// 우편번호와 주소 정보를 해당 필드에 넣는다.
								document.getElementById('sample6_postcode').value = data.zonecode;
								document.getElementById("sample6_address").value = addr;
								// 커서를 상세주소 필드로 이동한다.
								document.getElementById("sample6_detailAddress").focus();

							}
						}).open();
					}
				</script><br>
				<div style="font-size:80%; font-weight:bold">${message} </div>
			
			<div class="btn1">
				<input type="button" value="회원정보 수정" onClick="return go_updateMember()"/>
			</div>
			<div class="btn2">
				<input type="button" value="회원 탈퇴하기" onClick="goodbye('${loginUser.pwd}')">
			</div>
		</form>
		</article>
</section>
<script src="/script/member/userLogin.js"></script>
<%@ include file="../footer.jsp"%>
