function marginCal() {
	let cal_Margin = document.querySelectorAll("#prices");

	if (cal_Margin != null) {
		cal_Margin.forEach(function (e) {
			e.addEventListener("keyup", () => {
				let oprice = document.goodsWriteForm.o_price.value;
				let sprice = document.goodsWriteForm.s_price.value;
				document.goodsWriteForm.m_price.value = sprice - oprice;
			})
		})
	}
}

marginCal();


function go_update() {
	let goUpdate = document.querySelector("#admingoods_update");
	if (goUpdate != null) {
		goUpdate.addEventListener("click", () => {

			let form = document.goodsWriteForm;

			if (form.gname.value == "") {
				alert("상품명을 입력해주세요");
			} else if (form.o_price.value == "") {
				alert("원가를 입력해주세요");
			} else if (form.s_price.value == "") {
				alert("판매가를 입력해주세요");
			} else if (form.content.value == "") {
				alert("상품설명을 입력해주세요");
			} else if (form.cgseq.value == "0") {
				alert("카테고리를 선택해주세요");
			} else {
				document.goodsWriteForm.action = "adminGoodsUpdate";
				document.goodsWriteForm.method = "post";
				document.goodsWriteForm.submit();

			}
		})
	}
}

go_update();


function go_insert() {
	let goInsert = document.querySelector("#admingoods_insert");
	if (goInsert != null) {
		goInsert.addEventListener("click", () => {

			let form = document.goodsWriteForm;

			if (form.gname.value == "") {
				alert("상품명을 입력해주세요");
			} else if (form.o_price.value == "") {
				alert("원가를 입력해주세요");
			} else if (form.s_price.value == "") {
				alert("판매가를 입력해주세요");
			} else if (form.content.value == "") {
				alert("상품설명을 입력해주세요");
			} else if (document.querySelector("#hiddenFields").value == "") {
				alert("파일이미지를 등록해주세요");
			} else if (form.cgseq.value == "0") {
				alert("카테고리를 선택해주세요");
			} else {
				document.goodsWriteForm.action = "adminInsertGoods";
				document.goodsWriteForm.method = "post";
				document.goodsWriteForm.submit();
			}
		})
	}
}

go_insert();


function inputFile(){
	let inputFile = document.querySelector("#fileInputButton");
	if(inputFile != null){
		inputFile.addEventListener("click", ()=>{
			document.querySelector("#fileInputHidden").click();
		})
	}
}

inputFile();


function imgUseYn(realname){
	let img = document.querySelector(`#update-imgbox img[src*="${realname}"]`).parentElement;
	if (img){
		img.remove();
	}
}



/*function imgUseYn(gseq, gname, realname){
	let url = "/deleteFiles";

	fetch('/deleteFiles', {
		method: 'POST',
			headers: {
				'Content-Type': 'application/json'
			},
			body: JSON.stringify({
				gseq: gseq,
				gname: gname,
				realname: realname
			})
	})
	.then(response => {
		if (!response.ok) {
			throw new Error('Network response was not ok');
		}
		return response.json();
	})
	.then(data => {
		if (data.STATUS == 1) {{
			let img = document.querySelector(`#update-imgbox img[src*="${realname}"]`).parentElement;
			if (img){
				img.remove();
			}
		}}
	})
	.catch(error => {
		console.error('Error:', error);
	});
}*/



$(document).ready(function () {
	$('#fileInputHidden').change(function () {
		let formselect = $("#fileUploadForm")[0];
		let formdata = new FormData(formselect);

		$.ajax({
			url: "/uploadTemps",
			type: "POST",
			enctype: "multipart/form-data",
			data: formdata,
			contentType: false,
			processData: false,
			success: function (data) {
				if (data.STATUS == 1) {
					data.savefilenames.forEach(function (filename) {
						$("#prev-img").append('<img src="imageWrite?folder=temps&realName=' + filename + '"/>');
						$('#hiddenFields').append('<input type="hidden" name="uploadedFiles[]" value="' + filename + '"/>');
					});
				} else {
					alert("파일 업로드 실패 : status == 2" + data.ERROR);
				}
			},
			error: function (xhr, status, error) {
				alert("파일 업로드 실패");
				console.log("Error message: " + error);
			}
		});
	});
});

