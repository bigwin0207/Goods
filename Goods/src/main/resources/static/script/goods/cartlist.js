
function gomain(){
	let main = document.querySelector("#go_main");
	
	if(main != null){
		main.addEventListener("click", ()=>{
			location.href="main.do";
		})
	}
}

gomain();


function deletecart(){

	let wish = document.querySelector("#cart_delete");
	
	if(wish!=null){
		wish.addEventListener("click", ()=>{
			
			let count = 0;
			let gseq = document.cartlistform.gseq;
				
			if(gseq.length == undefined){
				if(gseq.checked == true){
					count++;
				}		
			} else {
				for(let i=0; i<gseq.length; i++){
					if(gseq[i].checked == true){
						count++;
					}
				}
			}
			
			if(count == 0){
				alert("삭제할 상품을 선택해주세요");			
			} else {
				document.cartlistform.action = "deleteCart.do";
				document.cartlistform.method = "post";
				document.cartlistform.submit();
			}			
		})
	}
}

deletecart();


function goorder(){
	let cartorder = document.querySelector("#cart_order");
	
	if(cartorder != null){
		cartorder.addEventListener("click", ()=>{
						let count = 0;
			let gseq = document.cartlistform.gseq;
				
			if(gseq.length == undefined){
				if(gseq.checked == true){
					count++;
				}		
			} else {
				for(let i=0; i<gseq.length; i++){
					if(gseq[i].checked == true){
						count++;
					}
				}
			}
			
			if(count == 0){
				alert("주문할 상품을 선택하세요");			
			} else {
				document.cartlistform.action = "orderFromCart.do";
				document.cartlistform.method = "post";
				document.cartlistform.submit();
			}				
		})		
	}
}

goorder();


function check_all() {
	let checkAll = document.querySelector("#checkAll");

	if (checkAll != null) {
		checkAll.addEventListener("click", () => {
			const checkboxes = document.querySelectorAll("#checkboxes");
			if (checkboxes.length > 0) {
				Array.from(checkboxes).forEach((checkbox) => {
					checkbox.checked = checkAll.checked;
				});
			} else {
				console.log("No checkboxes found with the name 'gseq'");
			}
		})
	}
}

check_all();
