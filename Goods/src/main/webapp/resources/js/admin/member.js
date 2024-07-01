let param = {
    table: "member_view",
};

let switchBtn = document.querySelector("#switchBtn");
let discardBtn = document.querySelector("#discardBtn");

switchBtn.addEventListener("click", () => {
	if (confirm("선택한 회원(들)의 상태를 변경할까요?")) {
		fetch('/GoodsShop/switchYN.do', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify({
					"checkList" : checkBoxChecked(),
				})
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					asynGetContent();
					alert(jsonResult.message);
					checkAll.checked = false;
				} else {
					alert(jsonResult.message);
					checkAll.checked = false;
				}
		});
	} else {
		return;
	}
});

discardBtn.addEventListener("click", () => {
	if (confirm("선택한 회원(들)을 탈퇴처리합니다. 이 동작은 되돌릴 수 없습니다. 진행할까요?")) {
		fetch('/GoodsShop/discardMember.do', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify({
					"checkList" : checkBoxChecked(),
				})
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					asynGetContent();
					alert(jsonResult.message);
					checkAll.checked = false;
				} else {
					alert(jsonResult.message);
					checkAll.checked = false;
				}
		});
	} else {
		return;
	}
});

function contentList(memberList) {
	let content = '';
	let i = 0;
	
	memberList.forEach(() => {
		content += '<li class="li-item">';
		content += '<div class="d-flex justify-content-center align-items-center">';
		content += '<div>' + memberList[i].userid + '</div>';
		content += '<div>' + memberList[i].gname + '</div>';
		content += '<div>' + memberList[i].name + '</div>';
		content += '<div>' + memberList[i].phone + '</div>';
		content += '<div>' + memberList[i].email + '</div>';
		content += '<div class="small-col">' + memberList[i].zip_code + '</div>';
		content += '<div>' + memberList[i].address + '</div>';
		content += '<div>' + memberList[i].d_address + '</div>';
		content += '<div>' + formatDate(memberList[i].indate) + '</div>';
		content += '<div class="small-col">';
		if (memberList[i].is_login == 1) {
			content += 'Y';
		} else {
			content += 'N';
		}
		content += '</div>';
		content += '<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="' + memberList[i++].userid + '"><div>';
		content += '</div>';
		content += '</li>';
	});
	document.querySelector("#member-list").innerHTML = content;
}