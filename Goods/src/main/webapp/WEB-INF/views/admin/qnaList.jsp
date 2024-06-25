<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin/index.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
	<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>
        	
        	<div id="layoutSidenav_content">
        		<div class="container-fluid px-4">
                	<h1 class="mt-4">Q&A</h1> <!-- 제목 -->
					<div class="row w-100 mt-4">
				    	<div class="col d-flex"> <!-- 목록 선택 -->
				      		<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
						  		<option value=0 selected>목록</option>
						  		<option value=10>10</option>
						  		<option value=50>50</option>
						  		<option value=100>100</option>
							</select>
							<div class="btn-group">
				                <button type="button" class="btn btn-outline-secondary active" id="all"><i class="bi bi-list"></i></button>
				                <button type="button" class="btn btn-outline-secondary" id="notnull"><i class="bi bi-check-circle"></i></button>
				            	<button type="button" class="btn btn-outline-secondary" id="null"><i class="bi bi-x-circle"></i></button>
				            </div>
				    	</div>
				    	<div class="col d-flex justify-content-end"> <!-- 검색 폼 -->
				    		<select class="form-select w-25 me-1" name="search" id="search">
						  		<option value="subject" selected>제목</option>
						  		<option value="userid">작성자</option>
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
		               					<div class="small-col">처리상태</div>
		               					<div>제목</div>
		               					<div>내용</div>
		               					<div class="small-col">작성자</div>
		               					<div class="small-col">작성일</div>
		               					<div class="small-col"><input class="form-check-input" type="checkbox" id="checkAll"></div>
		               				</div>
		               			</li>
		               		</ul>
		               	</div>
		               	<div>
		               		<ul id="qna-list">
								<c:forEach var="qna" items="${qnaList}">
									<a class="link" href="<c:url value='/adminQnaView.do?qseq=${qna.qseq}'/>">
										<li class="li-item">
											<div class="d-flex justify-content-center align-items-center">
												${qna.reply}
												<div class="small-col">
													<c:choose>
							  							<c:when test="${empty qna.replyDate}">(미처리)</c:when>
							  							<c:otherwise>(답변완료)</c:otherwise>
							  						</c:choose>
												</div>
				               					<div>
				               						<c:choose>
														<c:when test="${fn:length(qna.subject) gt 30}">
															<c:out value="${fn:substring(qna.subject, 0, 29)}"/>...
														</c:when>
														<c:otherwise>
															<c:out value="${qna.subject}"/>
														</c:otherwise>
													</c:choose>
												</div>
				               					<div>
				               						<c:choose>
														<c:when test="${fn:length(qna.content) gt 30}">
															<c:out value="${fn:substring(qna.content, 0, 29)}"/>...
														</c:when>
														<c:otherwise>
															<c:out value="${qna.content}"/>
														</c:otherwise>
													</c:choose>
												</div>
				               					<div class="small-col">${qna.userid}</div>
												<div class="small-col"><fmt:formatDate value="${qna.indate}" type="both" pattern="yyyy-MM-dd" /></div>
				               					<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="${qna.qseq}"></div>
			               					</div>
										</li>
									</a>
								</c:forEach>
							</ul>
		               	</div>
               		</div>
					<div class="row w-100 mt-4">
						<div class="col d-flex align-items-center"> <!-- page 정보 출력 -->
							<input class="form-control w-25 me-3" type="text" name="quickMove" id="quickMove" placeholder="Page Num">
							<span id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
						</div>
						<div class="col d-flex justify-content-end">
							<!-- paging -->
							<jsp:include page="paging.jsp">
					    		<jsp:param value="${paging}" name=""/>
					    	</jsp:include>
					    	<input type="button" class="btn btn-secondary ms-3" id="deleteBtn" value="삭제"/>
						</div>
					</div>
            	</div>
        	</div>            
        </div>
	<script type="text/javascript" src="<c:url value='/resources/js/admin/qna.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/admin/fix.js'/>"></script>
    </body>
</html>