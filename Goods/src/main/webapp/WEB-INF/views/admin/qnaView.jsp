<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 상세보기</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin/qnaView.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
</head>
	<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>
        	
        	<div id="layoutSidenav_content">
        		<div class="container-fluid px-4">
        			<div class="card">
					    <div class="card-header">
					        번호: <span>${vo.qseq}</span>
					    </div>
					    <div class="card-body">
					        <div class="card-item">
					            <strong>작성자:</strong><span>${vo.userid}</span>
					        </div>
					        <div class="card-item">
					            <strong>제목:</strong><span>${vo.subject}</span>
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
					    <div class="card-footer">
					        <c:choose>
					            <c:when test="${empty vo.reply}">
					                <form id="writeForm" method="post" action="<c:url value='/qnaReplyWrite.do?qseq=${vo.qseq}'/>">
					                    <div id="replyContainer">
					                        <textarea cols="400" name="reply" id="reply" placeholder="답변을 입력하세요" class="form-control"></textarea>
					                    </div>
					                    <input type="button" class="btn btn-secondary" id="writeBtn" value="작성"/>
					        			<a class="btn btn-light" href="<c:url value='/adminQnaList.do'/>">목록</a>
					                </form>
					            </c:when>
					            <c:otherwise>
					                <form id="updateForm" method="post" action="<c:url value='/qnaReplyUpdate.do?qseq=${vo.qseq}'/>">
					                    <div id="replyContainer">
					                        <textarea cols="400" name="reply" id="reply" placeholder="답변을 수정하세요" class="form-control">${vo.reply}</textarea>
					                    </div>
					                </form>
					                <form id="deleteForm" method="post" action="<c:url value='/qnaReplyDelete.do?qseq=${vo.qseq}'/>">
					                </form>
					                <input type="button" class="btn btn-secondary" id="updateBtn" value="수정"/>
					                <input type="button" class="btn btn-secondary" id="deleteBtn" value="삭제"/>
					                <a class="btn btn-light" href="<c:url value='/adminQnaList.do'/>">목록</a>
					            </c:otherwise>
					        </c:choose>
					    </div>
					</div>
        		</div>
        	</div>
        </div>
    <script type="text/javascript" src="<c:url value='/resources/js/admin/qnaView.js'/>"></script>
	</body>
</html>