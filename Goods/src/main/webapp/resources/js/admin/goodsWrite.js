function marginCal() {
	let cal_Margin = document.querySelectorAll("#prices");

	if (cal_Margin != null) {
		cal_Margin.forEach(function(e) {
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
			
			if(form.gname.value == ""){
				alert("상품명을 입력해주세요");
			} else if(form.oprice.value == ""){
				alert("원가를 입력해주세요");
			} else if(form.sprice.value == ""){
				alert("판매가를 입력해주세요");
			} else if(form.content.value == ""){
				alert("상품설명을 입력해주세요");
			} else if(form.image.value == ""){
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


