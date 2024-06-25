<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<link rel="stylesheet" href="resources/css/member.css">

<article id="joinPage">
	<form method="post" action="join.do"  name="formm">
		<table>
			<div id="join">
				<div class="box">
					<h2 >JOIN US</h2>
					<h3>기본 정보</h3>
					<div class="field">
						<div class="label">아이디</div>
						<input type="text" name="userid" id="userid">
						<input type="hidden" name="reid" id="reid">
						<input	type="button" value="중복 확인" onClick="idcheck()">
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
						<input type="text" name="name"	placeholder="ex) 홍길동">
					</div>
					<div class="field">
						<div class="label">연락처</div>
						<input type="text" name="phone" placeholder="010-1234-5678">
					</div>
					<div class="field">
						<div class="label">이메일</div>
						<input type="text" name="email"	id="email" placeholder="abc@gmail.com">
						<input type="hidden" name="reemail" id="reemail">
						<input	type="button" value="인증번호 전송" onClick="verify()">
					</div>


					<h3>부가 정보</h3>
					<div class="field">
						<div class="label">우편 번호</div>
						<input type="text"	name="zip_code" id="zipcode" readonly placeholder="123-123">
						<input type="button" value="우편번호 찾기" onClick="find_zip()">
					</div>
					<div class="field">
						<div class="label">주소</div>
						<input type="text" name="address" size=30 readonly>
					</div>
					<div class="field">
						<div class="label">상세 주소</div>
						<input type="text" name="d_address">
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
						<input type="button" id="regi" value="가입하기" onClick="go_save()">
				</div>
			
				
		</table>
	</form>
</article>
<script src="<c:url value='/resources/js/member/newID.js'/>"></script>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>