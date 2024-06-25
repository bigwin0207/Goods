let param = {
    table: "qna",
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

function contentList(qnaList) {
	let content = '';
	let i = 0;
	
	qnaList.forEach(() => {
		content += '<a class="link" href="/GoodsShop/adminQnaView.do?qseq=' + qnaList[i].qseq + '">';
		content += '<li class="li-item">';
		content += '<div class="d-flex justify-content-center align-items-center">';
		content += '<div class="small-col">';
		if (qnaList[i].reply == null)
			content += '(미처리)';
		else
			content += '(답변완료)';
		content += '</div>';
		content += '<div>' + truncateText(qnaList[i].subject, 30) + '</div>';
		content += '<div>' + truncateText(qnaList[i].content, 30) + '</div>';
		content += '<div class="small-col">' + qnaList[i].userid + '</div>';
		content += '<div class="small-col">' + formatDate(qnaList[i].indate) + '</div>';
		content += '<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="' + qnaList[i++].qseq + '"></div>';
		content += '</div>';
		content += '</li>';
		content += '</a>';
	});
	document.querySelector("#qna-list").innerHTML = content;
}

function numCheck(e) {
	var code = e.keyCode || e.which;

    if ((code >= 48 && code <= 57) || (code >= 96 && code <= 105)) {
        return;
    }

    if (code === 8 || code === 9 || code === 13 || code === 46) {
        return;
    }
    
    if (code >= 37 && code <= 40) {
        return;
    }

	e.preventDefault();
}

function numInputCheck(e) {
    const value = e.target.value;
    
    if (!/^\d*$/.test(value)) {
        e.target.value = value.replace(/\D/g, '');
    }
}

let quickMove = document.querySelector("#quickMove");
quickMove.addEventListener("keydown", (e) => {
	numCheck(e);
	
    if (e.keyCode === 13) {
        if (quickMove.value !== "" && quickMove.value !== null) {
			if (quickMove.value > paging.realEnd) {
				alert("마지막페이지 보다 넘게 이동 할 수 없습니다.");
            } else {
				paging.currentPage = quickMove.value;
            	asynGetContent();
            	quickMove.value = '';
			}
        }
    }
});
quickMove.addEventListener("input", numInputCheck);

document.addEventListener('DOMContentLoaded', () => {
    let buttons = document.querySelectorAll('.btn-group .btn');

    buttons.forEach(button => {
        button.addEventListener('click', () => {
            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');
            param.reply = button.id;
            asynGetContent()
        });
    });
});