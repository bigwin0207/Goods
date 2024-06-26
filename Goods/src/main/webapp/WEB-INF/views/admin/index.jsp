<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goods Shop</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="/css/admin/index.css">
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body>
	<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>

			<div id="layoutSidenav_content">
				<div class="container-fluid">
					<h1 class="mt-4">회원목록</h1>
			    	<!-- 목록 select -->
		    		<div class="row mt-4">
					    <div class="col">
					    	<select class="form-select w-25" name="selectAmount" id="selectAmount">
							  <option value="0" selected>목록 갯수</option>
							  <option value="10">10</option>
							  <option value="50">50</option>
							  <option value="100">100</option>
							</select>
					    </div>
					    
					    <div class="col d-flex justify-content-end">
					    	<select class="form-select w-25 me-1" name="search" id="search">
						  		<option value="userid" selected>아이디</option>
						  		<option value="name">이름</option>
						  		<option value="email">이메일</option>
							</select>
				      		<div class="d-flex">
					      		<input class="form-control me-2" name="keyword" id="keyword" type="text" placeholder="Search">
					    	</div>
					    </div>
					</div>
					
					<!-- memberList -->
					<div class="mt-4">
						<div>
							<ul>
		               			<li class="li-header">
		               				<div class="d-flex">
		               					<div>userID</div>
		               					<div>Grade</div>
		               					<div>Name</div>
		               					<div>Phone</div>
		               					<div>Email</div>
		               					<div class="small-col">Zip_Code</div>
		               					<div>Address</div>
		               					<div>Address2</div>
		               					<div>Detailed Address</div>
		               					<div>Indate</div>
		               					<div class="small-col">Y/N</div>
		               					<div class="small-col"><input class="form-check-input" type="checkbox" id="checkAll"></div>
		               				</div>
		               			</li>
		               		</ul>
		               	</div>
		               	<div>
		               		<ul id="member-list">
								<c:forEach var="vo" items="${memberList}">
									<li class="li-item">
										<div class="d-flex justify-content-center align-items-center">
											<div>${vo.userid}</div>
			               					<div>${vo.grade}</div>
			               					<div>${vo.name}</div>
			               					<div>${vo.phone}</div>
			               					<div>${vo.email}</div>
			               					<div class="small-col">${vo.zip_num}</div>
											<div>${vo.address1}</div>
											<div>${vo.address2}</div>
											<div>${vo.address3}</div>
											<div><fmt:formatDate value="${vo.indate}" type="both" pattern="yyyy-MM-dd" /></div>
			               					<div class="small-col">
			               						<c:choose>
													<c:when test="${vo.is_login eq 1}">Y</c:when>
													<c:otherwise>N</c:otherwise>
												</c:choose>
			               					</div>
			               					<div class="small-col"><input class="form-check-input" type="checkbox" name="check" value="${vo.userid}"></div>
		               					</div>
									</li>
								</c:forEach>
							</ul>
		               	</div>
               		</div>
               		<div class="d-flex col w-100 align-items-center mt-4">
		    			<!-- paging -->
				    	<jsp:include page="paging.jsp">
				    		<jsp:param value="${paging}" name=""/>
				    	</jsp:include>
				    	<span class="ms-3" id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
				    	<div class="d-flex col justify-content-end">
							<input type="button" name="switchBtn" id="switchBtn" value="회원 상태 변경"/>
							<input type="button" name="discardBtn" id="discardBtn" value="탈퇴 처리하기"/>
						</div>
					</div>
				</div>
			</div>
        </div>
        <script type="text/javascript" src="/script/admin/member.js"></script>
        <script type="text/javascript" src="/script/admin/fix.js"></script>
    </body>
</html>