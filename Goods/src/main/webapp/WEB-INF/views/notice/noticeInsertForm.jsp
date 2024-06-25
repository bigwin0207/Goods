<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 등록</title>
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
					        공지사항 작성
					    </div>
					    <div class="card-body">
					        <div class="card-item mb-1">
			        			<strong>제목</strong>
			        			<input class="form-control" type="text" name="subject" id="subject" placeholder="제목"/>
					        </div>
					        <div class="card-item">
			        			<strong>내용</strong>
			        			<textarea class="form-control" name="content" id="content" rows="10" cols="100" placeholder="내용"></textarea>
					        </div>
					    </div>
					    <div class="card-footer d-flex justify-content-end pb-3">
							<button type="submit" class="btn btn-secondary me-2">등록</button>
							<a class="btn btn-light" href="<c:url value='/adminNoticeList.do'/>">목록</a>
						</div>
					</form>
                </div>
        	</div>
        </div>
	</body>
</html>
