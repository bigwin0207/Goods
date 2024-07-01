let paging;
let selectAmount = document.querySelector("#selectAmount");
let pages = document.querySelectorAll('.page-link');
let search = document.querySelector('#search');
let searchValue = search.value;
let keyword = '';
let checkAll = document.querySelector("#checkAll");
let checkBoxes = document.querySelectorAll("div.small-col input[type='checkbox'][name='check']");

function truncateText(text, maxLength) {
    if (text.length > maxLength) {
        return text.substring(0, maxLength - 1) + "...";
    } else {
        return text;
    }
}

document.querySelector("#keyword").addEventListener("keydown", (e) => {
	keyword = document.querySelector("#keyword").value;
	
	if (e.keyCode === 13) {
		asynGetContent();
	}
});

function searchKeyword() {
	Object.keys(param).forEach(key => {
        if (key !== 'table') {
            delete param[key];
        }
    });
    param[searchValue] = keyword;
}

document.getElementById('search').addEventListener('change', () => {
	searchValue = search.value;
	searchKeyword();
});

document.querySelector("#keyword").addEventListener("input", () => {
	keyword = document.querySelector("#keyword").value;
	searchKeyword();
});

checkAll.addEventListener("change", function() {
	let isChecked = checkAll.checked;
	checkBoxes = document.querySelectorAll("div.small-col input[type='checkbox'][name='check']");
	
	if(isChecked){
		for(let checkBox of checkBoxes) {
			checkBox.checked = true;
		}
	} else {
		for(let checkBox of checkBoxes) {
			checkBox.checked = false;
		}
	}
});

function checkBoxChecked() {
	let checkList = [];
	checkBoxes = document.querySelectorAll("div.small-col input[type='checkbox'][name='check']");
	
	for (let i = 0; i < checkBoxes.length; i++) {
		if (checkBoxes[i].checked == true) {
			checkList.push(checkBoxes[i].value);
		}
	}

	return checkList;
}

selectAmount.addEventListener("change", () => {
	paging.amount = parseInt(selectAmount.options[selectAmount.selectedIndex].value);
	
	let realEnd = Math.ceil(paging.total / paging.amount);
	
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
		asynGetContent();
	}
})

document.addEventListener('DOMContentLoaded', () => {
    getPageInfo();
});

function getPageInfo() {	
	fetch('/admin/pageInfo', {
		method : 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
			body: JSON.stringify(param)
		})
		.then(response => response.json())
		.then(jsonResult => {
			/*if (jsonResult.status == true) {*/
				paging = jsonResult;
				
				for (let k = 0; k < selectAmount.length; k++){  
			    	if(selectAmount.options[k].value == jsonResult.amount){
			    		selectAmount.options[k].selected = true;
			    	}
			  	}
		/*}*/
	});
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

function formatDate(dateString) {
    let date = new Date(dateString);
    let year = date.getFullYear();
    let month = String(date.getMonth() + 1).padStart(2, '0');
    let day = String(date.getDate()).padStart(2, '0');
    
    return `${year}-${month}-${day}`;
}

function asynGetContent() {
	param.amount = paging.amount;
	param.currentPage = paging.currentPage;

	fetch('/admin/getContent', {
		method : 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
			body: JSON.stringify(param)
		})
		.then(response => response.json())
		.then(response => {
			contentList(response.memberList);
			
			paging = response.paging;
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
			document.querySelector("#pageInfo").innerHTML = paging.currentPage + ' / ' + paging.realEnd;
			
			addPagingEvent();
	});
	checkAll.checked = false;
}