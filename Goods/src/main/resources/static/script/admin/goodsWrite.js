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



/*$(document).ready(function () {
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
					$("#prev-img").append('<img src=imageWrite?folder=temps&realName=' + data.SAVEFILENAME + '/>');
					$('#hiddenFields').append('<input type="hidden" name="uploadedFiles" value="' + data.SAVEFILENAME + '"/>');
				}
			},
			error: function (xhr, status, error) {
				alert("파일 업로드 실패");
				console.log("Error message: " + error);
			}
		});
	});
});*/

$(document).ready(function () {
	$('#fileInputHidden').change(function () {
		let formselect = $("#fileUploadForm")[0];
		let formdata = new FormData(formselect);

		// 선택된 여러 파일들을 FormData에 추가
		let files = $('#fileInputHidden')[0].files;
		for (let i = 0; i < files.length; i++) {
			formdata.append('image[]', files[i]); // 'image[]'로 각 파일을 추가 (서버에서 배열 형태로 처리할 수 있어야 함)
		}

		$.ajax({
			url: "/uploadTemps",
			type: "POST",
			enctype: "multipart/form-data",
			data: formdata,
			contentType: false,
			processData: false,
			success: function (data) {
				if (data.STATUS == 1) {
					// 서버에서 전달된 파일명 배열을 처리하여 이미지 태그와 히든 필드 생성
					data.SAVEFILENAMES.forEach(function (filename) {
						$("#prev-img").append('<img src="imageWrite?folder=temps&realName=' + filename + '"/>');
						$('#hiddenFields').append('<input type="hidden" name="uploadedFiles[]" value="' + filename + '"/>');
					});
				}
			},
			error: function (xhr, status, error) {
				alert("파일 업로드 실패");
				console.log("Error message: " + error);
			}
		});
	});
});

