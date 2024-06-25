
/* =============회원가입================*/

/* 아이디 중복 확인*/
function idcheck(){
	var uid = document.formm.userid.value;
	if(uid==""){
		alert("아이디를 입력하고 중복체크를 진행해주세요!");
		document.formm.userid.focus();
		return;
	}
	var url = "IDCheck.do?userid=" + document.formm.userid.value;
	var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
	window.open(url, "IDCheck", opt);
}
/* 약관동의 */
function go_next(){
	
	if( document.formm.okon[1].checked == true){
		alert("약관에 동의하지 않으면 가입하실 수 없습니다!!");
	}else{
		document.formm.submit();
	}
}
/* 주소 찾기 창*/
function post_zip(){
	 var url = "findZipnum.do";
  	 var opt = "menubar=no,scrollbars=no,width=550,height=300,top=300,left=300";
   window.open(url, "findZipNum",opt);
}

function find_zip(){
	var url = "findZipnum.do";
	var opt = "menubar=no, scrollbars=no, width=550, height=300, top=300, left=300";
	window.open(url, "findZipnum", opt);
}


/* 회원가입 창 빈칸 채우기 */
function go_save(){

	
	if( document.formm.userid.value == ""){
		alert("아이디가 입력되지 않았습니다!");
		document.formm.userid.focus();
	}else if( document.formm.reid.value != document.formm.userid.value){
		alert("아이디 중복확인을 해주세요.");
		document.formm.userid.focus();
	}else if( document.formm.pwd.value == ""){
		alert("비밀번호가 입력되지 않았습니다!");
		document.formm.pwd.focus();
	}else if( document.formm.pwd.value != document.formm.pwdCheck.value){
		alert("비밀번호 확인이 일치하지 않습니다!");
		document.formm.pwdCheck.focus();
	}else if( document.formm.name.value == ""){
		alert("이름을 입력해주세요.");
		document.formm.name.focus();
	}else if( document.formm.phone.value == ""){
		alert("전화번호가 입력되지 않았습니다!");
		document.formm.phone.focus();
	}else if( document.formm.email.value == ""){
		alert("이메일을 입력해주세요.");
		document.formm.email.focus();
	}else if(!emailVerified){
		alert("이메일 인증을 진행해주세요!");
		document.formm.email.focus();
	}else if( document.formm.zip_code.value == ""){
		alert("배송받으실 주소를 입력해주세요!");
	}else if( document.formm.yno[1].checked == true){
		alert("약관 동의를 해주셔야 가입이 가능합니다!");
	}else{
		document.formm.submit();
	}
}

function idok(userid){
	opener.formm.userid.value = userid;
	opener.formm.reid.value = userid;
	self.close();
}

function addressOK( zip_num, sido, gugun, dong ){
	opener.document.formm.zip_code.value=zip_num;
	opener.document.formm.address.value=sido+" "+gugun+" "+dong;
	self.close();
}

function verify(){
	var inp = document.formm.email.value;
	var emform = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
	if(inp==""||emform.test(inp)==false){
	alert("이메일 형식이 올바르지 않습니다! ")
	}
/*	else if{
	// 이메일 형식이 아니면 "올바른 이메일 형식이 아니다" 로 표시되게 걸어두기.	
	}*/
	else{
	console.log("check");
	var ans = confirm("입력하신 이 주소가 맞나요?");
		if (ans){
		alert("입력하신 이메일로 인증번호가 전송되었습니다.");
		var url = "getEmail.do?email="+inp;
		var opt = "toolbar=no, menubar=no, resizable=no, width=500, height=250, scrollbars=no";
		window.open(url, "getEmail", opt);
		}
	
	}

}

var emailVerified = false;
function m_confirm(verificationCode){
	var vemail = document.getElementById('vemail').value;		// id가 있어야 그걸 받아오겠지...?
	if(verificationCode != vemail){
		alert("인증번호가 일치하지 않습니다. 다시 입력해주세요.")
		document.getElementById('vemail').focus();
	}else{
		alert("인증 성공! 회원가입을 계속 진행해주세요.")
		opener.emailVerified = true;
		self.close();
	}
}