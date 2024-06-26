<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="../index/bootstrap.min.css'/>">
<link rel="stylesheet" href="../notice/notice.css"/>
</head>
<body>
 		<div class="row d-flex justify-content-center mt-2 mb-5">
 			<div class="col-lg-6 w-75">
 				<div class="card">
	         		<h1 class="">공지사항</h1> <!-- 제목 -->
	            	<div class="row w-100 mt-3">
						<div class="col d-flex">
							<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
								<option value=0 selected>목록</option>
								<option value=10>10</option>
								<option value=30>30</option>
								<option value=50>50</option>
							</select>
						</div>
						<div class="col d-flex justify-content-end">
							<select class="form-select w-25 me-1" name="search" id="search">
								<option value="sc" selected>제목 + 내용</option>
								<option value="subject">제목</option>
								<option value="content">내용</option>
							</select>
	                     	<div class="d-flex">
	                        	<input class="form-control me-2" name="keyword" id="keyword" type="text" placeholder="Search">
							</div>
						</div>
					</div>
					<div class="mt-3">
						<ul>
				            <li class="notice-header">
				               <div class="d-flex">
				                  <div class="small-col">번호</div>
				                  <div class="small-col">작성자</div>
				                  <div>제목</div>
				                  <div>내용</div>
				                  <div class="small-col">작성일자</div>
				               </div>
				            </li>
						</ul>
					</div>								
					<div class="mb-3">
					   	<ul id="notice-list">
							<c:forEach var="notice" items="${noticeList}">
								<a class="link" href="noticeView?nseq=${notice.nseq}">
									<li class="notice-item">
										<div class="small-col">${notice.nseq}</div>
								        <div class="small-col">${notice.adminId}</div>
								        <div>
								        	<c:choose>
												<c:when test="${fn:length(notice.subject) gt 20}">
													<c:out value="${fn:substring(notice.subject, 0, 19)}">...</c:out>
												</c:when>
												<c:otherwise>
													<c:out value="${notice.subject}"/>
												</c:otherwise>
											</c:choose>
										</div>
								        <div>
								        	<c:choose>
												<c:when test="${fn:length(notice.content) gt 20}">
													<c:out value="${fn:substring(notice.content, 0, 19)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${notice.content}"/>
												</c:otherwise>
											</c:choose>
								        </div>
										<div class="small-col">
											<fmt:formatDate value="${notice.indate}" type="both" pattern="yyyy-MM-dd" />
										</div>
									</li>
					           	</a>
							</c:forEach>
					   	</ul>
					</div>
					<div class="d-flex justify-content-end">
               			<span id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
               		</div>
	               	<div class="d-flex col justify-content-center align-items-center">
	               		<jsp:include page="paging.jsp">
				    		<jsp:param value="${paging}" name=""/>
				    	</jsp:include>
	               	</div>
				</div>
			</div>
		</div>
	</div>
<%--<script type="text/javascript" src="script/notice/notice.js"></script>--%>
</body>
<%@ include file="../footer.jsp"%>
</html>