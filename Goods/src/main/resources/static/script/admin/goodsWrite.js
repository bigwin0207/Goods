function marginCal() {
	let cal_Margin = document.querySelectorAll("#prices");

	if (cal_Margin != null) {
		cal_Margin.forEach(function (e) {
			e.addEventListener("keyup", () => {
				let oprice = document.goodsWriteForm.oprice.value;
				let sprice = document.goodsWriteForm.sprice.value;
				document.goodsWriteForm.mprice.value = sprice - oprice;
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
			} else if (form.oprice.value == "") {
				alert("원가를 입력해주세요");
			} else if (form.sprice.value == "") {
				alert("판매가를 입력해주세요");
			} else if (form.content.value == "") {
				alert("상품설명을 입력해주세요");
			} else if (form.cgseq.value == "0") {
				alert("카테고리를 선택해주세요");
			} else {
				document.goodsWriteForm.action = "adminUpdateGoods.do";
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
			} else if (form.oprice.value == "") {
				alert("원가를 입력해주세요");
			} else if (form.sprice.value == "") {
				alert("판매가를 입력해주세요");
			} else if (form.content.value == "") {
				alert("상품설명을 입력해주세요");
			} else if (form.image.value == "") {
				alert("파일이미지를 등록해주세요");
			} else if (form.cgseq.value == "0") {
				alert("카테고리를 선택해주세요");
			} else {
				document.goodsWriteForm.action = "adminInsertGoods.do";
				document.goodsWriteForm.method = "post";
				document.goodsWriteForm.submit();
			}
		})
	}
}

go_insert();



	$(document).ready(function () {
	$('#fileInput').change(function () {
		let formselect = $("#fileUploadForm")[0];
		let formdata = new FormData(formselect);

		$.ajax({
			url: "/uploadTemps",
			type: "POST",
			enctype: "multipart/form-data",
			data: formdata,  // FormData 객체를 전송 데이터로 사용
			contentType: false,  // 파일 업로드 시 content type을 false로 유지
			processData: false,  // 데이터 처리를 위해 processData를 false로 유지
			success: function (data) {
				if (data.STATUS == 1) {
					$("#prev-img").append('<img src=imageWrite?folder=temps&realName=' + data.SAVEFILENAME + '/>');
				}
			},
			error: function (xhr, status, error) {
				alert("파일 업로드 실패");
				console.log("Error message: " + error);  // 실패 시 에러 메시지 출력
			}
		});
	});
});


