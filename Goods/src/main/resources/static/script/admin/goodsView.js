function viewGoodsDetail(gseq) {
	location.href = "goodsDetailView.do?gseq=" + gseq;
}


function check_all() {
	let checkAll = document.querySelector("#checkAll");

	if (checkAll != null) {
		checkAll.addEventListener("click", () => {
			let checkboxes = document.querySelectorAll("#checkboxes");
			if (checkboxes.length > 0) {
				Array.from(checkboxes).forEach((checkbox) => {
					checkbox.checked = checkAll.checked;
				});
			}
		})
	}
}

check_all();


function toggle_best() {
	let best = document.querySelector("#bestToggle");

	if (best != null) {
		best.addEventListener("click", () => {
			let count = 0;
			let gseq = document.goodsViewForm.gseq;

			if (gseq.length == undefined) {
				if (gseq.checked == true) {
					count++;
				}
			} else {
				for (let i = 0; i < gseq.length; i++) {
					if (gseq[i].checked == true) {
						count++;
					}
				}
			}

			if (count == 0) {
				alert("상태를 변경할 상품을 선택해주세요");
			} else {
				document.goodsViewForm.method = "post";
				document.goodsViewForm.action = "adminBestToggle"
				document.goodsViewForm.submit();
			}
		})
	}
}
toggle_best();

function toggle_use() {
	let useyn = document.querySelector("#useynToggle");

	if (useyn != null) {
		useyn.addEventListener("click", () => {

			let count = 0;
			let gseq = document.goodsViewForm.gseq;

			if (gseq.length == undefined) {
				if (gseq.checked == true) {
					count++;
				}
			} else {
				for (let i = 0; i < gseq.length; i++) {
					if (gseq[i].checked == true) {
						count++;
					}
				}
			}

			if (count == 0) {
				alert("상태를 변경할 상품을 선택해주세요");
			} else {
				document.goodsViewForm.method = "post";
				document.goodsViewForm.action = "adminUseYnToggle"
				document.goodsViewForm.submit();
			}
		})
	}
}
toggle_use();

function delete_goods() {
	let del = document.querySelector("#deleteGoods");

	if (del != null) {
		del.addEventListener("click", () => {

			let count = 0;
			let gseq = document.goodsViewForm.gseq;

			if (gseq.length == undefined) {
				if (gseq.checked == true) {
					count++;
				}
			} else {
				for (let i = 0; i < gseq.length; i++) {
					if (gseq[i].checked == true) {
						count++;
					}
				}
			}

			if (count == 0) {
				alert("삭제할 상품을 선택해주세요");
			} else {
				document.goodsViewForm.action = "adminGoodsDelete"
				document.goodsViewForm.method = "post";
				document.goodsViewForm.submit();
			}
		})
	}
}
delete_goods();

function category_view() {
	let cate = document.querySelector("#selectCategory");

	if (cate != null) {
		cate.addEventListener("change", () => {
			if (cate.value != 0) {
				document.goodsViewForm.action = "adminCategoryView";

			} else {
				document.goodsViewForm.action = "adminGoodsView";

			}
				document.goodsViewForm.method = "post";
				document.goodsViewForm.submit();
		})
	}
}

category_view();


function preventSubmit(){
	let form = document.querySelector("#goodsViewForm");
	form.addEventListener("keypress", (e)=>{
		if(e.key === "Enter"){
			e.preventDefault();
		}	
	})	
}

preventSubmit();


function enter_Search(){
	let input = document.querySelector("#searchKey");
	
	input.addEventListener("keypress", (e)=>{
		if(e.key === "Enter"){
			document.goodsViewForm.action = "adminGoodsSearch?page=1";
			document.goodsViewForm.method = "post";
			document.goodsViewForm.submit();
		}
	})	
}

enter_Search();



function pageClick(num, url) {
	if(document.goodsViewForm.searchKey.value == ''){
		document.goodsViewForm.searchKey.value = document.goodsViewForm.searchKeySave.value
	}
	
	document.goodsViewForm.action = url + "?page=" + num;
	document.goodsViewForm.method = "post";
	document.goodsViewForm.submit();
}





preventSubmit();