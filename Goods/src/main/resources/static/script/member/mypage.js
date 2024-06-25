function goodbye(){
	var ans = confirm("정말 탈퇴하시겠어요?")
	if(ans){
		location.href="deleteMember.do";
	}
}