let param = {
    table: "review_view",
};

let category = [];
document.querySelectorAll('.btn-check').forEach(checkbox => {
    checkbox.addEventListener('change', () => {
        if (checkbox.checked) {
            category.push(checkbox.id);
        } else {
            category = category.filter(item => item !== checkbox.id);
        }
        param.category = category;
        asynGetContent();
    });
});

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

function contentList(reviewList) {
	let content = '';
	let i = 0;
	
	reviewList.forEach(() => {
		content += '<a class="link" href="/GoodsShop/goodsDetailView.do?gseq=' + reviewList[i].gseq + '">';
		content += '<li class="li-item">';
		content += '<div class="d-flex justify-content-center align-items-center">';
		content += '<div class="small-col">' + reviewList[i].rseq + '</div>';
		content += '<div><img src="/GoodsShop/imageWrite.do?folder=' + reviewList[i].gseq + reviewList[i].gname + '&realName=' + reviewList[i].realName + '"></div>';
		content += '<div class="small-col">[' + reviewList[i].category + ']</div>';
		content += '<div>' + truncateText(reviewList[i].gname, 18) + '</div>';
		content += '<div>' + truncateText(reviewList[i].subject, 18) + '</div>';
		content += '<div><img id="badge" src="/GoodsShop/resources/image/badge/' + reviewList[i].grade + '.png"> ' + reviewList[i].userid + '</div>';
		content += '<div>' + formatDate(reviewList[i].indate) + '</div>';
		content += '<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="' + reviewList[i++].rseq + '"></div>';
		content += '</div>';
		content += '</li>';
		content += '</a>';
	});
	document.querySelector("#review-list").innerHTML = content;	
}