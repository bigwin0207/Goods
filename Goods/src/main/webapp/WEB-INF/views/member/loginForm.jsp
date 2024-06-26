<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="/member/loginForm.css">

<div>
<section id="loginForm">
		<article id="login">
			<form method="post" action="login" name="loginForm">
			<h2>LOGIN</h2>
			<div class="loginbox">
				<div class="logininput">
					<label>User ID</label><input name="userid" type="text">
					<label>Password</label><input name="pwd" type="password" >
				</div>
				<div class="loginbtn">
					<input type="submit" value="로그인" onClick="return loginCheck();"><br/>
				</div>
			
				<div class="btn">
					<input type="button" value="아이디 찾기" onClick="return findIdForm();">
					<input type="button" value="비밀번호 찾기" onClick="return findPwdForm();"><br/>
					<input type="button" value="KaKao" style=" background:yellow; " onclick="location.href='kakaostart'" >
				</div>
				<div style="display:flex; font-size:80%; font-weight:bold; border:1px solid lightgoldenrodyellow">${message}</div><br/>

				<div class="join-box" style="border:none;"><br/>
					<div class="join-message">
					아직 회원이 아니라면? <br>
					오브플라워에 가입하고, 더욱 다양한 혜택을 만나보세요! <br>
					</div>
					<input type="button" value="회원가입하기" onclick="location.href='joinPage'">
				</div>
			</div>
			</form>
			
		</article>
</section>
</div>
<script src="script/member/userLogin.js"></script>
<%@ include file="../footer.jsp"%>
<script src="/js/member/userLogin.js"></script>