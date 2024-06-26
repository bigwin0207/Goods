/*===========로그인================*/
/* 로그인 창 입력 확인*/
function loginCheck(){
	if(document.loginForm.userid.value=="아이디"){
		alert("아이디를 입력하세요");
		document.loginForm.userid.focus();
		return false;
	}else if(document.loginForm.pwd.value=="비밀번호"){
		alert("비밀번호를 입력하세요");
		document.loginForm.userid.focus();
		return false;
	}else{
		return true;
	}
}
/* 아이디 찾기 창으로 이동*/
function findIdForm(){
	location.href="findIdForm.do"
}

/* 아이디찾기 */
function findId(){ 
	var name = document.findIdForm.name.value;
    var email = document.findIdForm.email.value;
	if(name==""){
		alert("이름을 입력하세요");
		document.findIdForm.name.focus();
		return false;
	}else if(email==""){
		alert("이메일을 입력하세요");
		document.findIdForm.email.focus();
		return false;
	}else{
        document.findIdForm.submit();
    }
}
/* 비밀번호 찾기 창으로 이동*/
function findPwdForm(){
	location.href="findPwdForm.do"
}

function findPwd(){
	var userid = document.findIdForm.userid.value;
    var email = document.findIdForm.email.value;
	if(userid==""){
		alert("아이디을 입력하세요");
		document.findPwdForm.userid.focus();
		return false;
	}else if(email==""){
		alert("이메일을 입력하세요");
		document.findPwdForm.email.focus();
		return false;
	}else{
        document.findPwdForm.submit();
    }
}

function PwdCodeOK(){
	var userid = document.formm.userid.value;
    var email = document.formm.email.value;
	var securityCodeInput = document.formm.securityCodeInput.value;
	if(securityCodeInput==""){
		alert("인증코드를 입력하세요");
		document.formm.securityCodeInput.focus();
		return false;
	}else {
		document.formm.submit();
	}

}

function codeOK(){
	var userName = document.formm.name.value;
    var userEmail = document.formm.email.value;
	var securityCodeInput = document.formm.securityCodeInput.value;
	if(securityCodeInput==""){
		alert("인증코드를 입력하세요");
		document.formm.securityCodeInput.focus();
		return false;
	}else {
		document.formm.submit();
	}

}


/* 회원 정보 수정 */
function go_updateMember(){
	 if(document.formm.pwd.value == "") {
   alert("비밀번호를 입력해 주세요.");
   document.formm.pwd.focus();
   } else if(document.formm.pwd.value != document.formm.pwdCheck.value) {
   alert("비밀번호와 비밀번호 확인이 일치하지 않습니다.");
   document.formm.pwd.focus();
   } else if(document.formm.name.value == "") {
   alert("이름을 입력해 주세요.");
   document.formm.name.focus();
   } else if(document.formm.phone.value == "") {
   alert("전화번호를 입력해 주세요.");
   document.formm.phone.focus();
   }else if(document.formm.email.value == "") {
   alert("이메일을 입력해 주세요.");
   document.formm.email.focus();
   }  else{
   document.formm.submit();
   }
  }
/* 주소 찾기 창*/
function post_zip(){
	 var url = "findZipnum.do";
  	 var opt = "menubar=no,scrollbars=no,width=550,height=300,top=300,left=300";
   window.open(url, "findZipNum",opt);
}

/* 주소 찾기*/
function addressOK(zip_code , sido, gugun, dong){
   opener.formm.zip_code.value =zip_code;
   opener.formm.address.value = sido+" " + gugun + " " + dong ;
   self.close();
}

function Join(){
	location.href="joinPage.do";
}

function goodbye(pwd){
	
	let input_pwd  =  prompt("비밀번호를 입력해주세요");
	
	if(input_pwd == pwd){
			var ans = confirm("정말 탈퇴하시겠어요?")
			if(ans){
			location.href="deleteMember.do";
			}
	} else {
		alert("비밀번호가 일치하지 않습니다.");
	}
}

function clearPlaceholder(input) {
            if (input.value === input.defaultValue) {
                input.value = '';
                input.classList.remove('placeholder');
                input.type = "text";
                
            }
        }

function clearPlaceholders(input) {
    if (input.value === input.defaultValue) {
        input.value = '';
        input.classList.remove('placeholder-visible');
        input.type = "password";
    }
}

function setPlaceholder(input, placeholder) {
    if (input.value === '') {
        input.value = placeholder;
        input.classList.add('placeholder-visible');
        input.type = "text";
    }
}    