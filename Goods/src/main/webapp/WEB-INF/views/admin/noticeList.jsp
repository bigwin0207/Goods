<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin/index.css'/>">
</head>
<body class="sb-nav-fixed">
<!-- header -->
	<jsp:include page="../fix/admin/header.jsp"/>
 
	<div id="layoutSidenav">
 		<!-- side -->
 		<jsp:include page="../fix/admin/sidemenu.jsp"/>
 	
 		<div id="layoutSidenav_content">
 			<div class="container-fluid px-4">
         		<h1 class="mt-4">공지사항</h1> <!-- 제목 -->
            	<div class="row w-100 mt-4">
					<div class="col d-flex">
						<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
							<option value=0 selected>목록</option>
							<option value=10>10</option>
							<option value=30>30</option>
							<option value=50>50</option>
						</select>
						<input type="button" class="btn btn-outline-secondary" name="noticeInsert" value="공지사항 등록" onClick="return insertNotice();"/>
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
				<div class="mt-4">
					<div>
						<ul>
		                    <li class="li-header">
		                       <div class="d-flex">
		                          <div class="small-col">번호</div>
		                          <div class="small-col">작성자</div>
		                          <div>제목</div>
		                          <div>내용</div>
		                          <div class="small-col">작성일자</div>
		                          <div class="small-col"><input class="form-check-input" type="checkbox" id="checkAll"></div>
		                       </div>
		                    </li>
						</ul>
					</div>								
				</div>
               	<div>
               		<ul id="notice-list">
						<c:forEach var="notice" items="${noticeList}">
							<a class="link" href="<c:url value='/adminNoticeView.do?nseq=${notice.nseq}'/>">
								<li class="li-item">
									<div class="d-flex justify-content-center align-items-center">
										<div class="small-col">${notice.nseq}</div>
								        <div class="small-col">${notice.adminId}</div>
								        <div>
								        	<c:choose>
												<c:when test="${fn:length(notice.subject) gt 35}">
													<c:out value="${fn:substring(notice.subject, 0, 34)}">...</c:out>
												</c:when>
												<c:otherwise>
													<c:out value="${notice.subject}"/>
												</c:otherwise>
											</c:choose>
										</div>
								        <div>
									        <c:choose>
												<c:when test="${fn:length(notice.content) gt 35}">
													<c:out value="${fn:substring(notice.content, 0, 34)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${notice.content}"/>
												</c:otherwise>
											</c:choose>
										</div>
										<div class="small-col">
											<fmt:formatDate value="${notice.indate}" type="both" pattern="yyyy-MM-dd" />
										</div>
										<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="${notice.nseq}"></div>
									</div>
								</li>
				           	</a>
						</c:forEach>
               		</ul>
               	</div>
               	<div class="d-flex col align-items-center mt-4">
               		<jsp:include page="paging.jsp">
			    		<jsp:param value="${paging}" name=""/>
			    	</jsp:include>
			    	<span class="ms-3" id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
			    	<div class="col d-flex justify-content-end" style="width:50px;">
				    	<input type="button" class="btn btn-secondary me-3" id="deleteBtn" value="삭제"/>
			    	</div>
               	</div>
			</div>
		</div>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/admin/notice.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/admin/fix.js'/>"></script>
</body>
</html>