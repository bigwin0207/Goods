<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/notice/noticeView.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
	<div class="card">
	    <div class="card-header">
	        번호: <span>${vo.nseq}</span>
	    </div>
	    <div class="card-body">
	    	<div class="d-flex justify-content-between">
		    	<div class="card-item">
		            <strong>제목</strong><span>${vo.subject}</span>
		        </div>
		        <div class="card-item">
		            <strong>작성자</strong><span>${vo.adminId}</span>
		        </div>
	        </div>
	        <div class="card-item">
	            <strong>작성일자</strong><span><fmt:formatDate value="${vo.indate}" type="both" pattern="yyyy-MM-dd HH:mm:SS" /></span>
	        </div>
	        
	        <div class="card-item">
            	<strong>내용</strong>
	            <div class="content-box">
	            	<pre class="pre-styled"><span>${vo.content}</span></pre>
	            </div>
	        </div>
	        <a class="btn btn-light" href="<c:url value='/noticeList.do'/>">목록</a>
	    </div>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/admin/qnaView.js'/>"></script>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</html>
