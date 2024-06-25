
//go_main
function goMain(){
	let main = document.querySelector("#go_main");
	
	if(main != null){
		main.addEventListener("click", ()=>{
			location.href="main";
		})
	}
}

goMain();

//add_cart
function addCart() {
    let addcart = document.querySelector("#add_cart");
    
    if (addcart !== null) {
        addcart.addEventListener("click", function() {
            let quantity = parseInt(document.goodsform.input_quantity.value);
            
            if (isNaN(quantity) || quantity < 1) {
                alert("장바구니 최소수량은 1개입니다.");
            } else {
                document.goodsform.action = "addCart";
                document.goodsform.method = "post";
                document.goodsform.submit();
            }
        });
    }
}
addCart();


//input_quantity
function inputOnlyNum(){
	let quantity = document.querySelector("#input_quantity");
	
	if(quantity != null ){
		quantity.addEventListener("keydown", (e)=>{
			let key = e.key || e.which;
			
			if((key < "0" || key > "9") && (key !== "Backspace" && key !== "Delete" && key !== "ArrowLeft" && key !== "ArrowRight" && key !== "Tab" && key !== "Enter")){
				e.preventDefault();
			}			
		})
	}	
}
inputOnlyNum();


//add_wishlist
function addWishlist(){
	let addwish = document.querySelector("#add_wishlist");
	
	if (addwish != null){
		addwish.addEventListener("click", function(){
			document.goodsform.action = "addWish";
			document.goodsform.method = "post";
			document.goodsform.submit();			
		})			
	}	
}

addWishlist();


//go_order
function goOrder() {
	let ordernow = document.querySelector("#purchase_now");
	let quantity = parseInt(document.goodsform.input_quantity.value);	

	if (ordernow != null) {
		ordernow.addEventListener("click", () => {
            let quantity = parseInt(document.goodsform.input_quantity.value);
            
            if (isNaN(quantity) || quantity < 1) {
                alert("주문 최소수량은 1개입니다.");
            } else {
                document.goodsform.action = "orderNow";
                document.goodsform.method = "post";
                document.goodsform.submit();
            }
		})
	}
}

goOrder();

//admin - 목록으로
function viewGoodsList (){
	let goodslist = document.querySelector("#go_goodslist");
	
	if (goodslist != null){
		goodslist.addEventListener("click", ()=>{
			document.goodsform.action = "adminGoodsView";
			document.goodsform.method = "post";
			document.goodsform.submit();
			
		})
	}
}

viewGoodsList();

//admin - 상품 수정
function update_Goods(){
	let updateGoods = document.querySelector("#update_goods");
	
	if(updateGoods != null){
		updateGoods.addEventListener("click", ()=>{
			document.goodsform.action = "adminGoodsUpdateForm";
			document.goodsform.method = "post";
			document.goodsform.submit();
		})
	}	
}

//admin - 상품 추가
function update_Goods(){
	let updateGoods = document.querySelector("#update_goods");
	
	if(updateGoods != null){
		updateGoods.addEventListener("click", ()=>{
			document.goodsform.action = "adminGoodsUpdateForm";
			document.goodsform.method = "post";
			document.goodsform.submit();
		})
	}	
}

update_Goods();

//admin - 상품 삭제
function delete_Goods(){
	let deleteGoods = document.querySelector("#delete_goods");
	
	if(deleteGoods != null){
		deleteGoods.addEventListener("click", ()=>{
			document.goodsform.action = "adminGoodsDelete";
			document.goodsform.method = "post";
			document.goodsform.submit();
		})		
	}
}

delete_Goods();

// review
let param = {
    table: "review_view",
};
let paging;
let pages = document.querySelectorAll('.page-link');

document.addEventListener('DOMContentLoaded', () => {
    getPageInfo();
});

function getPageInfo() {
	fetch('/GoodsShop/pageInfo', {
		method : 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
			body: JSON.stringify(param)
		})
		.then(response => response.json())
		.then(jsonResult => {
			if (jsonResult.status == true) {
				paging = jsonResult.paging;
			}
	});
}

function currentTime() {
	let now = new Date();
	let formattedTime = now.getFullYear() + '-' +
                    String(now.getMonth() + 1).padStart(2, '0') + '-' +
                    String(now.getDate()).padStart(2, '0') + ' ' +
                    String(now.getHours()).padStart(2, '0') + ':' +
                    String(now.getMinutes()).padStart(2, '0') + ':' +
                    String(now.getSeconds()).padStart(2, '0');
                    
	return formattedTime;
}

function formatDate(dateString) {
    let date = new Date(dateString);
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');
    let day = String(date.getDate()).padStart(2, '0');
    let hour = String(date.getHours()).padStart(2, '0');
    let minute = String(date.getMinutes()).padStart(2, '0');
    let second = String(date.getSeconds()).padStart(2, '0');
    
    return `${year}-${month}-${day} ${hour}:${minute}:${second}`;
}

function liFactory(li, vo) {
	li.classList.add("list-item");
	
	let header = document.createElement("div");
	header.classList.add("item-header");
	let numdiv = document.createElement("div");
	numdiv.classList.add("num");
	let subjectdiv = document.createElement("div");
	subjectdiv.classList.add("subject");
	let authordiv = document.createElement("div");
	authordiv.classList.add("author");
	let timediv = document.createElement("div");
	timediv.classList.add("time");
	let buttonsdiv = document.createElement("div");
	buttonsdiv.classList.add("buttons");
	let contentdiv = document.createElement("div");
	contentdiv.classList.add("item-content");
	
	let numspan = document.createElement("span");
	numspan.classList.add("item-num");
	numspan.textContent = 'no.' + vo.rseq;
	numdiv.appendChild(numspan);
	
	let subjectspan = document.createElement("span");
	subjectspan.classList.add("item-subject");
	subjectspan.textContent = vo.subject;
	subjectdiv.appendChild(subjectspan);
	
	let authorspan = document.createElement("span");
	let img = document.createElement("img");
	img.src = '/GoodsShop/resources/image/badge/' + vo.grade + '.png';
	authorspan.classList.add("item-author");
	let text = document.createTextNode(vo.userid);
	authorspan.appendChild(img);
	authorspan.appendChild(text);
	authordiv.appendChild(authorspan);
	
	let timespan = document.createElement("span");
	timespan.classList.add("item-time");
	timespan.textContent = currentTime();
	timediv.appendChild(timespan);
	
	let editButton = document.createElement("button");
	let iedit = document.createElement("i");
	iedit.classList.add("bi", "bi-pen-fill");
	editButton.appendChild(iedit);
	editButton.classList.add("btn", "btn-primary", "btn-sm", "reviewUpdateBtn");
	editButton.addEventListener("click", (e) => {
	    reviewUpdate(e);
	});
	
	let deleteButton = document.createElement("button");
	let idelete= document.createElement("i");
	idelete.classList.add("bi", "bi-x-square-fill");
	deleteButton.appendChild(idelete);
	deleteButton.classList.add("btn", "btn-danger", "btn-sm", "reviewDeleteBtn");
	deleteButton.addEventListener("click", (e) => {
	    reviewDelete(e)
	    asynGetContent();
	});
	buttonsdiv.appendChild(editButton);
	buttonsdiv.appendChild(deleteButton);
	
	header.appendChild(numdiv);
	header.appendChild(subjectdiv);
	header.appendChild(authordiv);
	header.appendChild(timediv);
	header.appendChild(buttonsdiv);
	
	let contentspan = document.createElement("span");
	contentspan.classList.add("item-content-text");
	contentspan.textContent = vo.content;
	let pre = document.createElement("pre");
	pre.classList.add("pre-styled");
	pre.appendChild(contentspan);
	contentdiv.appendChild(pre);
	
	li.appendChild(header);
	li.appendChild(contentdiv);
	
	return li;
}

let reviewList = document.querySelector('#reviewList');
let reviewWriteBtn = document.querySelector('#reviewWriteBtn');

if (reviewWriteBtn != null) {
	reviewWriteBtn.addEventListener("click", () => {
		if (subject.value !== '' && content.value !== '') {
			if(confirm("리뷰 작성하시겠습니까?")) {
				fetch('/GoodsShop/reviewWrite', {
					method : 'POST',
					headers: {
						'Content-Type': 'application/json;charset=utf-8'
					},
						body: JSON.stringify({
							"gseq" : parseInt(gseq.value),
							"subject" : subject.value,
							"content" : content.value,
						})
					})
					.then(response => response.json())
					.then(jsonResult => {				
						if (jsonResult.status == true) {
							let vo = jsonResult.vo;
							let li = document.createElement("li");
							
							li = liFactory(li, vo);
							
							reviewList.prepend(li);
							document.querySelector('#subject').value = '';
							document.querySelector('#content').value = '';
							
							if (reviewList.children.length > 10) {
							    reviewList.removeChild(reviewList.lastElementChild);
							}
							
							editPaging(jsonResult.paging);
							addPagingEvent();
						} else {
							alert(jsonResult.message);
						}
				});
			} else {
				return;
			}
		} else {
			alert("리뷰를 작성하세요.");
		}
	});	
}

function getRseq(e) {
    let target = e.target;

    if (target.tagName.toLowerCase() === 'i') {
        target = target.closest('button');
    }

    let listItem = target.closest('.list-item');
    
    return listItem.querySelector('.item-num').textContent.replace('no.', '').trim();
}

let reviewUpdateBtn = document.querySelectorAll('.reviewUpdateBtn');
let reviewDeleteBtn = document.querySelectorAll('.reviewDeleteBtn');

function reviewUpdate(e) {
	let listItem = e.target.closest('.list-item');
    let subjectElement = listItem.querySelector('.item-subject');
    let contentElement = listItem.querySelector('.item-content-text');
    let timeElement = listItem.querySelector('.item-time');
    let subjectText = subjectElement.textContent;
    let contentText = contentElement.textContent;
	
	if (listItem.querySelector('.save-btn')) {
	    return;
	}

    subjectElement.innerHTML = `<input type="text" class="form-control" value="${subjectText}">`;
    contentElement.innerHTML = `<textarea class="form-control">${contentText}</textarea>`;

    let saveBtn = document.createElement('button');
    saveBtn.textContent = '저장';
    saveBtn.classList.add('btn', 'btn-success', 'btn-sm', 'save-btn');
    saveBtn.addEventListener('click', () => {
        let editSubject = subjectElement.querySelector('input').value;
        let editContent = contentElement.querySelector('textarea').value;

		if ((editSubject.trim() !== '' && editContent.trim() !== '') && (subjectText !== editSubject && contentText !== editContent)) {
	        if(confirm("리뷰 내용을 수정하시겠습니까?")) {
				timeElement.innerHTML = currentTime();
				let rseq = getRseq(e);
	
				fetch('/GoodsShop/reviewUpdate', {
					method : 'POST',
					headers: {
						'Content-Type': 'application/json;charset=utf-8'
					},
						body: JSON.stringify({
							"rseq" : rseq,
							"subject" : editSubject,
							"content" : editContent,
						})
					})
					.then(response => response.json())
					.then(jsonResult => {				
						if (jsonResult.status == true) {
							alert(jsonResult.message);
						} else {
							alert(jsonResult.message);
						}
				});
				subjectElement.textContent = editSubject;
		        contentElement.textContent = editContent;
		        saveBtn.remove();
			} else {
				return;
			}
		} else {
			alert("제목과 내용을 수정해주세요");
		}
    });

    listItem.querySelector('.buttons').appendChild(saveBtn);
}

function addEvent() {
	reviewUpdateBtn = document.querySelectorAll('.reviewUpdateBtn');
	if (reviewUpdateBtn != null) {
		reviewUpdateBtn.forEach(btn => {
			btn.addEventListener("click", (e) => {
				reviewUpdate(e);
			});
		});
	}
	
	reviewDeleteBtn = document.querySelectorAll('.reviewDeleteBtn');
	if (reviewDeleteBtn != null) {
		reviewDeleteBtn.forEach(btn => {
			btn.addEventListener("click", (e) => {
				reviewDelete(e);
			});
		});
	}
}

addEvent();

function reviewDelete(e) {
	if(confirm("정말로 삭제하시겠습니까?")) {
		let rseq = getRseq(e);

		fetch('/GoodsShop/reviewDelete', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify({
					"rseq" : parseInt(rseq),
				})
			})
			.then(response => response.json())
			.then(jsonResult => {				
				if (jsonResult.status == true) {
					alert(jsonResult.message);
					asynGetContent();
				} else {
					alert(jsonResult.message);
				}
		});
	} else {
		return;
	}
}

function addPagingEvent() {
	pages = document.querySelectorAll('.page-link');
	
	pages.forEach(page => {
		page.addEventListener("click", (e) => {
			if (e.target.getAttribute('data-value') == "prev") {
				paging.currentPage = parseInt(paging.startPage - 10);
			} else if (e.target.getAttribute('data-value') == "next") {
				paging.currentPage = parseInt(paging.startPage + 10);
			} else {
				paging.currentPage = parseInt(e.target.getAttribute('data-value'));
			}
			asynGetContent();
		});
	});
}
addPagingEvent();

function editPaging(json) {
	paging = json;
	let pagination = '';
	
	if (paging.prev) {
		pagination += '<li class="page-item">';
		pagination += '<a class="page-link" data-value="prev">Prev</a>';
		pagination += '</li>';
	} else {
		pagination += '<li class="page-item disabled">';
		pagination += '<a class="page-link">Prev</a>';
		pagination += '</li>';
	}
	
	for(let j = paging.startPage; j <= paging.endPage; j++) {
		if(paging.currentPage == j) {
			pagination += '<li class="page-item active">';
			pagination += '<a class="page-link" data-value="' + j + '">';
			pagination += j;
			pagination += '</a>';
			pagination += '</li>';
		} else {
			pagination += '<li class="page-item">';
			pagination += '<a class="page-link" data-value="' + j + '">';
			pagination += j;
			pagination += '</a>';
			pagination += '</li>';
		}
	}
	
	if (paging.next) {
		pagination += '<li class="page-item">';
		pagination += '<a class="page-link" data-value="next">Next</a>';
		pagination += '</li>';
	} else {
		pagination += '<li class="page-item disabled">';
		pagination += '<a class="page-link">Next</a>';
		pagination += '</li>';
	}
	document.querySelector("#pagination").innerHTML = pagination;	
}

function asynGetContent() {
	param.amount = 10;
	param.page = paging.currentPage;
	param.gseq = parseInt(gseq.value);

	fetch('/GoodsShop/getContent', {
		method : 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
			body: JSON.stringify(param)
		})
		.then(response => response.json())
		.then(jsonResult => {
			if (jsonResult.status == true) {
				let reviewList = jsonResult.content;
				let i = 0;
				let content = '';
				
				reviewList.forEach(() => {
					content += '<li class="list-item">';
					content += '<div class="item-header">';
					content += '<div class="num"><span class="item-num">no.' + reviewList[i].rseq + '</span></div>';
					content += '<div class="subject"><span class="item-subject">' + reviewList[i].subject + '</span></div>';
					content += '<div class="author"><span class="item-author"><img src="/GoodsShop/resources/image/badge/' + reviewList[i].grade + '.png">' + reviewList[i].userid + '</span></div>';
					content += '<div class="time"><span class="item-time">' + formatDate(reviewList[i].indate) + '</span></div>';
					content += '<div class="buttons">';
					if (reviewList[i].userid == userid.value) {
						content += '<button type="button" class="btn btn-primary btn-sm reviewUpdateBtn"><i class="bi bi-pen-fill"></i></button>';
						content += '<button type="button" class="btn btn-danger btn-sm reviewDeleteBtn"><i class="bi bi-x-square-fill"></i></button>';
					}
					content += '</div>';
					content += '</div>';
					content += '<div class="item-content"><pre class="pre-styled"><span class="item-content-text">'+ reviewList[i++].content + '</span></pre></div>';
					content += '</li>';
				})
				document.querySelector("#reviewList").innerHTML = content;
				addEvent();
				
				editPaging(jsonResult.paging);
				addPagingEvent();
			} else {
				alert(jsonResult.message);
			}
	});
}