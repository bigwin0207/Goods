
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


function change_status(){
    let changeSt = document.querySelector("#changeStat");
    let osseqSelect = document.querySelector("#osseq");

    osseqSelect.addEventListener("change", function() {
        if (osseqSelect.value != '0') {
            changeSt.addEventListener("click", ()=>{
                document.adminOrderForm.action = "adminUpdateOrderStatus.do";
                document.adminOrderForm.method = "post";
                document.adminOrderForm.submit();
            });
        } else {
            changeSt.removeEventListener("click", ()=>{});
        }
    });
}

change_status();


function search_by(){
	let goSearch = document.querySelector("#goSearch");
	
	goSearch.addEventListener("click",()=>{
		document.adminOrderForm.action = "adminSearchOrder.do";
		document.adminOrderForm.method = "post";
		document.adminOrderForm.submit();
	})
}
search_by();

function enter_Search(){
	let input = document.querySelector("#searchKey");
	
	input.addEventListener("keypress", (e)=>{
		if(e.key === "Enter"){
			document.adminOrderForm.action = "adminSearchOrder.do";
			document.adminOrderForm.method = "post";
			document.adminOrderForm.submit();
		}
	})	
}

enter_Search();

function preventSubmit(){
	let form = document.querySelector("#adminOrderForm");
	form.addEventListener("keypress", (e)=>{
		if(e.key === "Enter"){
			e.preventDefault();
		}	
	})	
}

preventSubmit();



function paging_prev(){
	let prev = document.querySelector("#prevbtn");
	let url = document.adminOrderForm.url.value;
	
	prev.addEventListener("click", ()=>{
		document.adminOrderForm.action = url + "?page=${paging.beginPage-1}";
		document.adminOrderForm.method = "post";
		document.adminOrderForm.submit();		
		
	})
}
paging_prev();





function pageClick(num, url) {
	document.adminOrderForm.action = url + "?page=" + num;
	document.adminOrderForm.method = "post";
	document.adminOrderForm.submit();
}


