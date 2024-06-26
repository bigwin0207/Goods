let deleteBtn = document.querySelector('#deleteBtn');
if (deleteBtn != null) {
	deleteBtn.addEventListener('click', () => {
		deletefn();
	});
}

function deletefn() {
	if (confirm("정말로 삭제하시겠습니까?")) {
		let qseqText = document.querySelector('#qseq');
		let qseq = parseInt(qseqText.innerText);
		
		fetch('/GoodsShop/qnaDelete.do', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify({"qseq": qseq})
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					alert(jsonResult.message);
					location.href = jsonResult.url;
				} else {
					alert(jsonResult.message);
				}
		});
	} else {
		return;
	}
}