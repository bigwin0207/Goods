document.addEventListener("DOMContentLoaded", () => {
    let writeBtn = document.getElementById("writeBtn");
    let updateBtn = document.querySelector("#updateBtn");
    let deleteBtn = document.querySelector("#deleteBtn");
	
	if (writeBtn != null) {
	    writeBtn.addEventListener("click", () => {
			if (document.getElementById("reply").value !== '')
				document.getElementById("writeForm").submit();
			else {
				alert("답변을 작성해주세요");
			}
	    });
    }
    
    if (updateBtn != null) {
	    updateBtn.addEventListener("click", () => {
			let span = document.getElementById('replySpan');
	        let reply = document.getElementById('reply');
	        
	        if (reply.value === '' || span.innerText === reply.value) {
	            alert("답변을 수정해 주세요.");
	        } else {
				if (confirm("수정 하시겠습니까?")) {
					document.getElementById("updateForm").submit();
				}
	        }
	    });
	}
	
	if (deleteBtn != null) {
	    deleteBtn.addEventListener("click", () => {
	        if (confirm("정말 삭제하시겠습니까?")) {
	            let deleteForm = document.getElementById("deleteForm");
	            deleteForm.submit();
	        }
	    });
    }
});