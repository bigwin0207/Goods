function goOrder (){
	let go_order = document.querySelector("#go_order")
	
	if(go_order!=null){
		go_order.addEventListener("click", function(){
			
			let checkboxes = document.querySelectorAll('input[type="checkbox"][name="gseq"]:checked');
			let totalQuantity = 0;
			let totalPrice = 0;
			
			checkboxes.forEach(function(checkbox){
				let quantity = parseInt(checkbox.parentElement.querySelector('input[name="quantity"]').value);
				let price = parseInt(checkbox.parentElement.querySelector('input[name="totalprice"]').value);
				
				totalQuantity += quantity;
				totalPrice += quantity * price;
				
			})
		
			if(totalQuantity < 1){
				alert("주문할 상품을 선택해주세요");
			} else {	
				let ans = confirm("총 " + totalQuantity + " 개의 상품 (총 주문금액 : " + totalPrice + ") 를 주문합니다. 확인을 누르시면 결제페이지로 이동합니다.");
				
				if (ans){
					
					document.orderpageform.numberOfGoods.value = totalQuantity;
					document.orderpageform.orderTotalPrice.value = totalPrice;
					
					document.orderpageform.action = "getPayment.do";
					document.orderpageform.method = "post";
					document.orderpageform.submit();
				} else {
					alert("주문을 취소합니다.");
				}					
			}
		})	
	}
}

goOrder();

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