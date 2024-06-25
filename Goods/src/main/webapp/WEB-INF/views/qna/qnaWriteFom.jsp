<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 작성하기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/qna/qnaView.css'/>">
</head>
<body>
	<div class="card">
		<c:if test="${not empty vo}">
			<div class="card-header">
		        번호: <span id="qseq">${vo.qseq}</span>
		    </div>
	    </c:if>
	    <div class="card-body">
	        <div class="card-item">
	        	<c:choose>
	        		<c:when test="${empty vo}">
	        			<strong>제목</strong>
	        			<input class="form-control" type="text" name="subject" id="subject" placeholder="제목"/>
	        		</c:when>
	        		<c:otherwise>
	        			<strong>제목</strong>
	        			<input class="form-control" type="text" name="subject" id="subject" value="${vo.content}" placeholder="제목"/>
	        		</c:otherwise>
	        	</c:choose>
	        </div>
	        <div class="card-item">
	        	<c:choose>
	        		<c:when test="${empty vo.content}">
	        			<strong>내용</strong>
	        			<textarea class="form-control" name="content" id="content" rows="10" cols="100" placeholder="내용"></textarea>
	        		</c:when>
	        		<c:otherwise>
	        			<strong>내용</strong>
	        			<textarea class="form-control" name="content" id="content" rows="10" cols="100" placeholder="내용">${vo.content}</textarea>
	        		</c:otherwise>
	        	</c:choose>
	        </div>
	        <c:if test="${not empty vo}">
		        <div class="card-item">
		            <strong>작성일자:</strong>
		            <span><fmt:formatDate value="${vo.indate}" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></span>
		        </div>
	        </c:if>
	    </div>
	    <div class="card-footer d-flex justify-content-end pb-3">
			<c:choose>
				<c:when test="${not empty vo}">
					<button class="btn btn-secondary" name="updateBtn" id="updateBtn">수정</button>
				</c:when>
				<c:otherwise>
					<button class="btn btn-secondary" name="writeBtn" id="writeBtn">작성하기</button>
				</c:otherwise>
			</c:choose>
			<a class="btn btn-light" href="<c:url value='/qnaList.do'/>">목록</a>
		</div>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/qna/qnaWrite.js'/>"></script>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</html>