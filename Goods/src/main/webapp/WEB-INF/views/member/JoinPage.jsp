<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="../css/member.css">
<script src="script/member/newID.js"></script>

<article id="joinPage">
	<form method="post" action="join"  name="formm">
		<table>
			<div id="join">
				<div class="box">
					<h2 >JOIN US</h2>
					<h3>기본 정보</h3>
					<div class="field">
<%--
						<div class="label">message</div>
--%>
						<div>${message}</div>

					</div>
					<div class="field">
						<div class="label">아이디</div>
						<input type="text" name="userid" id="userid" value="${dto.userid}">
						<input type="hidden" name="reid" id="reid">
						<input type="button" value="중복 확인" onClick="checkid()">
					</div>
					<div class="field">
						<div class="label">비밀번호</div>
						<input type="password"	name="pwd">
					</div>
					<div class="field">
						<div class="label">비밀번호 확인</div>
						<input type="password" name="pwdCheck">
					</div>
					<div class="field">
						<div class="label">성명</div>
						<input type="text" name="name"	placeholder="ex) 홍길동" value="${dto.name}">
					</div>
					<div class="field">
						<div class="label">연락처</div>
						<input type="text" name="phone" placeholder="010-1234-5678" value="${dto.phone}">
					</div>
					<div class="field">
						<div class="label">이메일</div>
						<input type="text" name="email"	id="email" placeholder="abc@gmail.com" value="${dto.email}">
					</div>


					<h3>부가 정보</h3>
					<div class="field">
						<div class="label">우편번호</div>
						<input type="text" id="sample6_postcode" name="zip_code" readonly>
						<input type="button" value="우편번호 찾기" onclick="sample6_execDaumPostCode()">
					</div>
					<div class="field">
						<div class="label">도로명 주소</div>
						<input type="text" name="address1" size=30
							   id="sample6_address" value="${dto.address1}" readonly>
					</div>
					<div class="field">
						<div class="label">상세 주소</div>
						<input type="text" name="address2"
							   id="sample6_extraAddress" value="${dto.address2}">
					</div>
					<div class="field">
						<div class="label">추가 주소</div>
						<input type="text" name="address2"
							   id="sample6_detailAddress" value="${dto.address3}">
					</div>
				</div>
			</div>

			<div id="contract">
				<h3>약관 동의</h3>
				<p class="check" style="padding: 8px">
					■ 수집하는 개인정보 항목<br />
						회사는 회원가입, 상담, 서비스 신청 등등을 위해 아래와 같은 개인정보를 수집하고	있습니다.<br/>
						ο 수집항목 : 이름 , 생년월일 , 성별 , 로그인ID , 비밀번호 , 비밀번호 질문과 답변 , 자택 전화번호 , 자택
						주소 , 휴대전화번호 , 이메일 , 직업 , 회사명 , 부서 , 직책 , 회사전화번호 , 취미 , 결혼여부 , 기념일 ,
						법정대리인정보 , 서비스 이용기록 , 접속 로그 , 접속 IP 정보 , 결제기록<br />
						ο 개인정보 수집방법 : 홈페이지(회원가입) , 서면양식<br /><br/>
							
					■ 개인정보의 수집 및 이용목적<br />
							
						회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.<br />
							
						ο 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 콘텐츠 제공 , 구매 및 요금 결제 , 물품배송 또는 청구지 등 발송<br />
						ο 회원 관리 : 회원제 서비스 이용에 따른 본인확인 , 개인 식별 , 연령확인 , 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인 , 고지사항 전달<br/>
						ο 마케팅 및 광고에 활용 : 접속 빈도 파악 또는 회원의 서비스 이용에 대한 통계<br/><br/>
							
					■ 개인정보의 보유 및 이용기간<br />
						회사는 개인정보 수집 및 이용목적이 달성된 후에는 예외 없이 해당 정보를 지체 없이 파기합니다.<br/>
					■ 사실 그런거 없고 귀하의 개인정보는 이 사이트의 데이터베이스에 고이 잘 보관해놓고 있다가 후에 사용할 일이 있다면
					언제든지 마음껏 사용할 예정이니<br/> 선택에 대한 책임은 전적으로 귀하에게 달려있다는 점을 다시 한번 명시해드립니다.<br/>
					■ 자 지축을 박차고 자 포효하라 그대 조국의 영원한 고동이 되리라 우리의 함성은 신화가 되리라 울려라 이곳에 포에버<br/>
					지금은 그 어디서 내 생각 잊었는가 꽃처럼 어여쁜 그 이름도 고왔던 순이 순이야 파도치는 부둣가에 지나간 일들이 가슴에 남았는데
					부산 갈매기 부산 갈매기 너는 정녕 나를 잊었나<br/>
					비내리는 호남선 남행열차에 흔들리는 차창 너머로 빗물이 흐르고 내눈물도 흐르고 피어버린 첫사랑도 흐르네
					깜빡깜빡이는 희미한 기억속에 그때만난 그사람 말이없던 그사람 자꾸만 멀어지는데<br/> 만날순 없어도 잊지는 말아요 당신을 사랑했어요
				</p>
					<span>약관에 동의하시겠습니까?</span>
					<div style="display: flex; margin-top: 10px">
							<input type="radio" name="yno"> 동의  &nbsp; &nbsp; &nbsp;
							<input type="radio" name="yno" checked style="margin-left: 20px;"> 미동의
					</div>
				</div>
				<div class="btn" style="display: flex; justify-content: center; margin: 20px">
					<input type="submit"  id="regi1"  value="가입하기">
					<input type="button"  id="regi2"  value="메인으로" onclick="location.href='/'">
				</div>

			<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

			<script>
				function sample6_execDaumPostCode() {
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
		</table>
	</form>
</article>
<%@ include file="../footer.jsp"%>