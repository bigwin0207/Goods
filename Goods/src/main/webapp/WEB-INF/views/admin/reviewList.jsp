<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
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
       			<h1 class="mt-4">리뷰</h1>
       			<div class="row w-100 justify-content-between mt-4">
			    	<div class="col d-flex"> <!-- 목록 선택 -->
			      		<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
					  		<option value=0 selected>목록</option>
					  		<option value=10>10</option>
					  		<option value=50>50</option>
					  		<option value=100>100</option>
						</select>
			    	</div>
			    	<div class="col d-flex">
				    	<div class="btn-group">
							<input type="checkbox" class="btn-check" id="목걸이">
							<label class="btn btn-outline-secondary" for="목걸이">목걸이</label>
							<input type="checkbox" class="btn-check" id="반지">
							<label class="btn btn-outline-secondary" for="반지">반지</label>
							<input type="checkbox" class="btn-check" id="팔찌">
							<label class="btn btn-outline-secondary" for="팔찌">팔찌</label>
							<input type="checkbox" class="btn-check" id="귀걸이">
							<label class="btn btn-outline-secondary" for="귀걸이">귀걸이</label>
							<input type="checkbox" class="btn-check" id="키링">
							<label class="btn btn-outline-secondary" for="키링">키링</label>
							<input type="checkbox" class="btn-check" id="인형">
							<label class="btn btn-outline-secondary" for="인형">인형</label>
							<input type="checkbox" class="btn-check" id="기타">
							<label class="btn btn-outline-secondary" for="기타">기타</label>
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
       			<div class="row w-100 mt-4">
       				<div>
						<ul>
							<li class="li-header">
								<div class="d-flex">
									<div class="small-col">번호</div>
									<div>사진</div>
									<div class="small-col">카테고리</div>
									<div>굿즈명</div>
									<div>리뷰제목</div>
									<div>구매자</div>
									<div>리뷰작성일자</div>
									<div class="small-col"><input class="form-check-input" type="checkbox" id="checkAll"></div>
								</div>
							</li>
						</ul>
					</div>
					<div>
						<ul id="review-list">
							<c:forEach var="rev" items="${reviewList}">
							<a class="link" href="<c:url value='/goodsDetailView.do?gseq=${rev.gseq}'/>">
								<li class="li-item">
									<div class="d-flex justify-content-center align-items-center">
										<div class="small-col">${rev.rseq}</div>
		               					<div><img src="<c:url value='/imageWrite.do?folder=${rev.gseq}${rev.gname}&realName=${rev.realName}'/>"></div>
		               					<div class="small-col">[${rev.category}]</div>
		               					<div>
		               						<c:choose>
												<c:when test="${fn:length(rev.gname) gt 18}">
													<c:out value="${fn:substring(rev.gname, 0, 17)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${rev.gname}"/>
												</c:otherwise>
											</c:choose>
										</div>
		               					<div>
		               						<c:choose>
												<c:when test="${fn:length(rev.subject) gt 18}">
													<c:out value="${fn:substring(rev.subject, 0, 17)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${rev.subject}"/>
												</c:otherwise>
											</c:choose>
										</div>
		               					<div><img id="badge" src="<c:url value='/resources/image/badge/${rev.grade}.png'/>"> ${rev.userid}</div>
		               					<div><fmt:formatDate value="${rev.indate}" type="both" pattern="yyyy-MM-dd" /></div>
		               					<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="${rev.rseq}"></div>
	               					</div>
								</li>
							</a>
							</c:forEach>
						</ul>
					</div>
       			</div>
       			<div class="d-flex col align-items-center mt-4 mb-5">
               		<jsp:include page="paging.jsp">
			    		<jsp:param value="${paging}" name=""/>
			    	</jsp:include>
			    	<span class="ms-3" id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
			    	<div class="col d-flex justify-content-end me-4">
				    	<input type="button" class="btn btn-secondary" id="deleteBtn" value="삭제"/>
			    	</div>
               	</div>
			</div>
       	</div>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/admin/review.js'/>"></script>
<script type="text/javascript" src="<c:url value='/resources/js/admin/fix.js'/>"></script>
</body>
</html>