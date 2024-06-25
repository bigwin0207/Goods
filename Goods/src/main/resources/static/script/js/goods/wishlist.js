
function wishtocart(){

	let wish = document.querySelector("#wish_to_cart");
	
	if(wish!=null){
		wish.addEventListener("click", ()=>{
			
			let count = 0;
			let gseq = document.wishlistform.gseq;
				
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
				alert("장바구니에 추가할 상품을 선택하세요");			
			} else {
				document.wishlistform.action = "wishToCart.do";
				document.wishlistform.method = "post";
				document.wishlistform.submit();
			}			
		})
	}
}

wishtocart();

function deletewish(){
	let deletewish = document.querySelector("#wish_delete");
	if (deletewish != null){
		deletewish.addEventListener("click", ()=>{
			
			let count = 0;
			let gseq = document.wishlistform.gseq;
			
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
				alert("찜목록에서 삭제할 상품을 선택하세요");			
			} else {
				document.wishlistform.action = "deleteWish.do";
				document.wishlistform.method = "post";
				document.wishlistform.submit();
			}				
			
		})			
	}
}

deletewish();


function gomain(){
	let main = document.querySelector("#go_main");
	
	if(main != null){
		main.addEventListener("click", ()=>{
			location.href="main.do";
		})
	}
}

gomain();

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