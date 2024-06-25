<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin/notice.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
	<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>
        	
        	<div id="layoutSidenav_content">
                <div class="card">
                	<form method="post" action="<c:url value='/noticeInsert.do'/>">
						<div class="card-header">
					        <strong>No.</strong><span>${vo.nseq}</span>
					    </div>
					    <div class="card-body">
					        <div class="card-item mb-1">
			        			<strong>작성자</strong><span>${vo.adminId}</span>
					        </div>
					        <div class="card-item mb-1">
			        			<strong>제목</strong><span>${vo.subject}</span>
					        </div>
					        <div class="card-item mb-1">
			        			<strong>내용</strong><pre class="pre-styled"><span>${vo.content}</span></pre>
					        </div>
					        <div class="card-item mb-1">
			        			<strong>작성일자</strong><span><fmt:formatDate value="${vo.indate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
					        </div>
					    </div>
					    <div class="card-footer d-flex justify-content-end pb-3">
							<a class="btn btn-secondary me-2" href="<c:url value='/noticeUpdateForm.do?nseq=${vo.nseq}'/>">수정</a>
		                    <a class="btn btn-light me-2" href="<c:url value='/noticeDelete.do?nseq=${vo.nseq}'/>">삭제</a>
		                    <a class="btn btn-light" href="<c:url value='/adminNoticeList.do'/>">목록</a>
						</div>
					</form>
                </div>
        	</div>
        </div>
	</body>
</html>
