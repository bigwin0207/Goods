<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="../member/loginForm.css">
<div>
<section id="loginForm">
		<article id="login">
			<form method="post" action="login" name="loginForm">
			<h2>LOGIN</h2>
			<div class="loginbox">
				<div class="logininput">
					<label>User ID</label><input name="userid" type="text">
					<label>Password</label><input name="pwd" type="text" >
				</div>
				<div class="loginbtn">
					<input type="submit" value="로그인" onClick="return loginCheck();"><br/>
				</div>
			
				<div class="btn">
					<input type="button" value="아이디 찾기" onClick="return findIdForm();">
					<input type="button" value="비밀번호 찾기" onClick="return findPwdForm();"><br/>
					<input type="button" value="KaKao" style="background:darkkhaki" onclick="location.href='kakaostart'" >
				</div>
				<div style="font-size:80%; font-weight:bold">${message}</div>
				<div class="join-box"><br/>
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
<%@ include file="../footer.jsp"%>