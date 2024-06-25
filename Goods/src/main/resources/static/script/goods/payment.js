function payment(){
	let pay = document.querySelector("#get_payment")
	
	if(pay != null){
		pay.addEventListener("click", function(){
			document.paymentform.action = "orderInsert";
			document.paymentform.method = "post";
			document.paymentform.submit();
		})
	}	
}
payment();