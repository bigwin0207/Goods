let param = {
    table: "notice",
};

let deleteBtn = document.querySelector("#deleteBtn");
deleteBtn.addEventListener("click", () => {
	if (confirm("삭제하시겠습니까?")) {
		param.checkList = checkBoxChecked();
		
		fetch('/GoodsShop/checkDelete.do', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify(param)
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					delete param.checkList;
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

function contentList(noticeList) {
	let content = '';
	let i = 0;
	
	noticeList.forEach(() => {
		content += '<a class="link" href="/GoodsShop/adminNoticeView.do?nseq=' + noticeList[i].nseq + '">';
		content += '<li class="li-item">';
		content += '<div class="d-flex justify-content-center align-items-center">';
		content += '<div class="small-col">' + noticeList[i].nseq + '</div>';
		content += '<div class="small-col">' + noticeList[i].adminId + '</div>';
		content += '<div>' + truncateText(noticeList[i].subject, 35) + '</div>';
		content += '<div>' + truncateText(noticeList[i].content, 35) + '</div>';
		content += '<div class="small-col">' + formatDate(noticeList[i].indate) + '</div>';
		content += '<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="' + noticeList[i++].nseq + '"></div>';
		content += '</div>';
		content += '</li>';
		content += '</a>';
	});
	document.querySelector("#notice-list").innerHTML = content;	
}

function insertNotice(){
	location.href="noticeInsertForm.do";
}