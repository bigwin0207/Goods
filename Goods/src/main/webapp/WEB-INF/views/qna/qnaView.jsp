<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/qna/qnaView.css'/>">
</head>
<body>
	<div class="card">
	    <div class="card-header">
	        번호: <span id="qseq">${vo.qseq}</span>
	    </div>
	    <div class="card-body">
	    	<div class="card-item">
	            <strong>제목:</strong><span>${vo.subject}</span>
	        </div>
	        <div class="card-item">
	            <strong>작성자:</strong><span>${vo.userid}</span>
	        </div>
	        <div class="card-item">
	            <strong>내용:</strong><pre class="pre-styled"><span>${vo.content}</span></pre>
	        </div>
	        <div class="card-item">
	            <strong>작성일자:</strong><span><fmt:formatDate value="${vo.indate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
	        </div>
	        <c:if test="${not empty vo.reply}">
	            <div class="card-item" id="replytext">
	                <strong>답변:</strong><span id="replySpan">${vo.reply}</span>
	            </div>
	            <div class="card-item" id="replydate">
	                <strong>답변일자:</strong> <span><fmt:formatDate value="${vo.replyDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
	            </div>
	        </c:if>
	    </div>
	    <div class="card-footer d-flex justify-content-end pb-3">
	    	<c:if test="${vo.userid eq loginUser.userid && empty vo.reply}">
				<a class="btn btn-light me-2" href="qnaWriteForm.do?qseq=${vo.qseq}">수정</a>
			</c:if>
			<c:if test="${vo.userid eq loginUser.userid}">
				<button class="btn btn-secondary me-2" name="deleteBtn" id="deleteBtn">삭제</button>
			</c:if>
			<a class="btn btn-light" href="<c:url value='/qnaList.do'/>">목록</a>
	    </div>
    </div>
<script type="text/javascript" src="<c:url value='/resources/js/qna/qnaView.js'/>"></script>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</html>