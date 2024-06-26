let param = {
    table: "review_view",
};
let category = [];
let paging;
let myPaging;
let selectAmount = document.querySelector("#selectAmount");
let pages = document.querySelectorAll('.all-page-link');
let myPages = document.querySelectorAll('.my-page-link');
let search = document.querySelector('#search');
let searchValue = search.value;
let keywordInput = document.querySelector("#keyword");
let keyword = '';

document.addEventListener('DOMContentLoaded', () => {
	let allTab = document.querySelector('#all-tab');
	let myTab = document.querySelector('#my-tab');
	
	let allReview = document.querySelector('#allReview');
	let myReview = document.querySelector('#myReview');
    
    allTab.addEventListener('click', () => {
		myTab.classList.remove('active');
		allTab.classList.add('active');
        myReview.classList.remove('show', 'active');
        allReview.classList.add('show', 'active');
        
    });
    
    if (myTab != null) {
	    myTab.addEventListener('click', () => {
	        allTab.classList.remove('active');
	        myTab.classList.add('active');
	        allReview.classList.remove('show', 'active');
	        myReview.classList.add('show', 'active');
	    });
    }
    
    getPageInfo();
});

document.querySelector("#keyword").addEventListener("keydown", (e) => {
	keyword = keywordInput.value;
	
	if (e.keyCode === 13) {
		asynGetContent("all");
		asynGetContent("my");
		
	}
});

function searchKeyword() {
	Object.keys(param).forEach(key => {
        if (key !== 'table' && key !== 'category') {
            delete param[key];
        }
    });
    
	if (searchValue === "sc") {
        param.subject = keyword;
        param.content = keyword;
    } else if (searchValue) {
        param[searchValue] = keyword;
    }
}

document.getElementById('search').addEventListener('change', () => {
	searchValue = search.value;
	searchKeyword();
});

keywordInput.addEventListener("input", () => {
	keyword = document.querySelector("#keyword").value;
	searchKeyword();
});

function getPageInfo() {	
	fetch('/GoodsShop/pageInfo.do', {
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
				myPaging = jsonResult.myPaging;
				
				for (let k = 0; k < selectAmount.length; k++){  
			    	if(selectAmount.options[k].value == jsonResult.paging.amount){
			    		selectAmount.options[k].selected = true;
			    	}
			  	}
			}
	});
}

selectAmount.addEventListener("change", () => {
	paging.amount = parseInt(selectAmount.options[selectAmount.selectedIndex].value);
	
	let realEnd = Math.ceil(paging.total / paging.amount);
	let myRealEnd = 0;
	
	if (realEnd < paging.currentPage) {
		if (realEnd <= 0) {
			paging.currentPage = 1;
		} else {
			paging.currentPage = realEnd;
		}
	}
	
	if (paging.amount == 0) {
		return;
	} else {
		asynGetContent("all");
	}

	if (document.querySelector('#my-tab') != null) {
		myPaging.amount = parseInt(selectAmount.options[selectAmount.selectedIndex].value);
		myRealEnd = Math.ceil(myPaging.total / myPaging.amount);
		
		if (myRealEnd < myPaging.currentPage) {
			if (myRealEnd <= 0) {
				myPaging.currentPage = 1;
			} else {
				myPaging.currentPage = myRealEnd;
			}
		}
		
		if (myPaging.amount == 0) {
			return;
		} else {
			asynGetContent("my");
		}
	}
})

function addPagingEvent() {
	pages = document.querySelectorAll('.all-page-link');
	
	pages.forEach(page => {
		page.addEventListener("click", (e) => {
			if (e.target.getAttribute('data-value') == "prev") {
				paging.currentPage = parseInt(paging.startPage - 10);
			} else if (e.target.getAttribute('data-value') == "next") {
				paging.currentPage = parseInt(paging.startPage + 10);
			} else {
				paging.currentPage = parseInt(e.target.getAttribute('data-value'));
			}
			asynGetContent("all");
		});
	});
}
addPagingEvent();

function addMyPagingEvent() {
	myPages = document.querySelectorAll('.my-page-link');
	
	myPages.forEach(page => {
		page.addEventListener("click", (e) => {
			if (e.target.getAttribute('data-value') == "prev") {
				myPaging.currentPage = parseInt(myPaging.startPage - 10);
			} else if (e.target.getAttribute('data-value') == "next") {
				myPaging.currentPage = parseInt(myPaging.startPage + 10);
			} else {
				myPaging.currentPage = parseInt(e.target.getAttribute('data-value'));
			}
			asynGetContent("my");
		});
	});
}
addMyPagingEvent();

function formatDate(dateString) {
    const date = new Date(dateString);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    return `${year}-${month}-${day}`;
}

function truncateText(text, maxLength) {
    if (text.length > maxLength) {
        return text.substring(0, maxLength - 1) + "...";
    } else {
        return text;
    }
}

function asynGetContent(tab) {
	if (tab == "my" && document.querySelector('#my-tab') != null) {
		param.my = "";
		param.amount = myPaging.amount;
		param.page = myPaging.currentPage;
		
		fetch('/GoodsShop/getContent.do', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify(param)
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					delete param.my;
					let contentList = jsonResult.content;
					let content = '';
					let i = 0;
					
					contentList.forEach(() => {
						content += '<a class="link" href="/GoodsShop/goodsDetailView.do?gseq=' + contentList[i].gseq + '">';
						content += '<li class="review-item">';
						content += '<div class="d-flex justify-content-center align-items-center">';
						content += '<div class="small-col">' + contentList[i].rseq + '</div>';
						content += '<div><img src="/GoodsShop/imageWrite.do?folder=' + contentList[i].gseq + contentList[i].gname + '&realName=' + contentList[i].realName + '"></div>';
						content += '<div class="small-col">[' + contentList[i].category + ']</div>';
						content += '<div>' + truncateText(contentList[i].gname, 10) + '</div>';
						content += '<div>' + truncateText(contentList[i].subject, 10) + '</div>';
						content += '<div><img id="badge" src="/GoodsShop/resources/image/badge/' + contentList[i].grade + '.png"> ' + contentList[i].userid + '</div>';
						content += '<div>' + formatDate(contentList[i++].indate) + '</div>';
						content += '</div>';
						content += '</li>';
						content += '</a>';
					});
					document.querySelector("#my-review-list").innerHTML = content;
					
					myPaging = jsonResult.paging;
					let pagination = '';
					
					if (myPaging.prev) {
						pagination += '<li class="page-item">';
						pagination += '<a class="page-link my-page-link" data-value="prev">Prev</a>';
						pagination += '</li>';
					} else {
						pagination += '<li class="page-item disabled">';
						pagination += '<a class="page-link my-page-link">Prev</a>';
						pagination += '</li>';
					}
					
					for(let j = myPaging.startPage; j <= myPaging.endPage; j++) {
						if(myPaging.currentPage == j) {
							pagination += '<li class="page-item active">';
							pagination += '<a class="page-link my-page-link" data-value="' + j + '">';
							pagination += j;
							pagination += '</a>';
							pagination += '</li>';
						} else {
							pagination += '<li class="page-item">';
							pagination += '<a class="page-link my-page-link" data-value="' + j + '">';
							pagination += j;
							pagination += '</a>';
							pagination += '</li>';
						}
					}
					
					if (myPaging.next) {
						pagination += '<li class="page-item">';
						pagination += '<a class="page-link my-page-link" data-value="next">Next</a>';
						pagination += '</li>';
					} else {
						pagination += '<li class="page-item disabled">';
						pagination += '<a class="page-link my-page-link">Next</a>';
						pagination += '</li>';
					}
					document.querySelector("#myPagination").innerHTML = pagination;				
					document.querySelector("#myPagdInfo").innerHTML = myPaging.currentPage + ' / ' + myPaging.realEnd;
					
					addMyPagingEvent();
				} else {
					alert(jsonResult.message);
				}
		});
	} else {
		param.amount = paging.amount;
		param.page = paging.currentPage;
		
		fetch('/GoodsShop/getContent.do', {
			method : 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
				body: JSON.stringify(param)
			})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == true) {
					let contentList = jsonResult.content;
					let content = '';
					let i = 0;
					
					contentList.forEach(() => {
						content += '<a class="link" href="/GoodsShop/goodsDetailView.do?gseq=' + contentList[i].gseq + '">';
						content += '<li class="review-item">';
						content += '<div class="d-flex justify-content-center align-items-center">';
						content += '<div class="small-col">' + contentList[i].rseq + '</div>';
						content += '<div><img src="/GoodsShop/imageWrite.do?folder=' + contentList[i].gseq + contentList[i].gname + '&realName=' + contentList[i].realName + '"></div>';
						content += '<div class="small-col">[' + contentList[i].category + ']</div>';
						content += '<div>' + truncateText(contentList[i].gname, 10) + '</div>';
						content += '<div>' + truncateText(contentList[i].subject, 10) + '</div>';
						content += '<div><img id="badge" src="/GoodsShop/resources/image/badge/' + contentList[i].grade + '.png"> ' + contentList[i].userid + '</div>';
						content += '<div>' + formatDate(contentList[i++].indate) + '</div>';
						content += '</div>';
						content += '</li>';
						content += '</a>';
					});
					document.querySelector("#review-list").innerHTML = content;
					
					paging = jsonResult.paging;
					let pagination = '';
					
					if (paging.prev) {
						pagination += '<li class="page-item">';
						pagination += '<a class="page-link all-page-link" data-value="prev">Prev</a>';
						pagination += '</li>';
					} else {
						pagination += '<li class="page-item disabled">';
						pagination += '<a class="page-link all-page-link">Prev</a>';
						pagination += '</li>';
					}
					
					for(let j = paging.startPage; j <= paging.endPage; j++) {
						if(paging.currentPage == j) {
							pagination += '<li class="page-item active">';
							pagination += '<a class="page-link all-page-link" data-value="' + j + '">';
							pagination += j;
							pagination += '</a>';
							pagination += '</li>';
						} else {
							pagination += '<li class="page-item">';
							pagination += '<a class="page-link all-page-link" data-value="' + j + '">';
							pagination += j;
							pagination += '</a>';
							pagination += '</li>';
						}
					}
					
					if (paging.next) {
						pagination += '<li class="page-item">';
						pagination += '<a class="page-link all-page-link" data-value="next">Next</a>';
						pagination += '</li>';
					} else {
						pagination += '<li class="page-item disabled">';
						pagination += '<a class="page-link all-page-link">Next</a>';
						pagination += '</li>';
					}
					document.querySelector("#pagination").innerHTML = pagination;				
					document.querySelector("#pagdInfo").innerHTML = paging.currentPage + ' / ' + paging.realEnd;
					
					addPagingEvent();
				} else {
					alert(jsonResult.message);
				}
		});
	}
}