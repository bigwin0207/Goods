document.addEventListener("DOMContentLoaded", () => {
	let qseqText;
	let qseq;
		
	function writeupdate(command) {
		let param = {
			"subject": subject.value,
			"content": content.value,
		}
		
		if (command == "qnaUpdate") {
			qseqText = document.querySelector('#qseq');
			qseq = parseInt(qseqText.innerHTML);
			param.qseq = qseq;
		}
		
		fetch('/GoodsShop/'+command+'.do', {
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify(param)
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
	}

	let writeBtn = document.querySelector('#writeBtn');

	if (writeBtn != null) {
		writeBtn.addEventListener('click', () => {
			writeupdate("qnaWrite");
		});
	}

	let updateBtn = document.querySelector('#updateBtn');
	
	if (updateBtn != null) {
		updateBtn.addEventListener('click', () => {
			writeupdate("qnaUpdate");
		});
	}
});