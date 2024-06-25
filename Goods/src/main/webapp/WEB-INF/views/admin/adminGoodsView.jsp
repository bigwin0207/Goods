<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Goods</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin/admingoods.css'/>">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

</head>
<body class="sb-nav-fixed">

	<!-- header -->
	<jsp:include page="../fix/admin/header.jsp" />

	<div id="layoutSidenav">
		<!-- side -->
		<jsp:include page="../fix/admin/sidemenu.jsp" />
	<form name="goodsViewForm" id="goodsViewForm">
		<div id="layoutSidenav_content">
			<div class="admin-goods-container">
				<div class="container-title">
					상품 목록
				</div>
				

				<div class="search-row">
					<div class="search-select"> <!-- 목록 선택 -->
				      		<select class="" name="selectCategory" id="selectCategory">
				      			<c:choose>
				      				<c:when test="${not empty categoryList}">
										<option value="0">카테고리별</option>
										<c:forEach var="ct" items="${categoryList}">
											<c:choose>
												<c:when test="${ct.cgseq == cgseq}">
													<option value="${ct.cgseq}" selected="selected">
														${ct.category}</option>
												</c:when>
												<c:otherwise>
													<option value="${ct.cgseq}">${ct.category}</option>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<option value=0 selected>카테고리별</option>
										<option value=1>목걸이</option>
										<option value=2>반지</option>
										<option value=3>팔찌</option>
										<option value=4>귀걸이</option>
										<option value=5>키링</option>
										<option value=6>인형</option>
										<option value=7>기타</option>
									
									</c:otherwise>
								</c:choose>
						</select>
				    </div>
					<div class="search-form">
						<!-- 검색 폼 -->
							<c:choose>
								<c:when test="${not empty key}">
									<div class="search-button">
										<input class="" name="searchKey" id="searchKey"
											type="text" placeholder="상품명을 입력하세요">
										<input type="hidden" name="searchKeySave" value="${key}">								
									</div>
								</c:when>
								<c:otherwise>
									<div class="search-button">
										<input class="" name="searchKey" id="searchKey"
											type="text" placeholder="상품명을 입력하세요">
										<input type="hidden" name="searchKeySave" value="">
									</div>														
								</c:otherwise>
							</c:choose>
						<div class="search-button" id="goSearch">
							<input type="button" value="검색" onclick="pageClick(1, 'adminGoodsSearch.do')">
						</div>						
					</div>
				</div>


				<div class="admin-goods-box">
					<div class="titlerow">
						<div class="titlefield">상품번호</div>
						<div class="titlefield">상품명</div>
						<div class="titlefield">이미지</div>
						<div class="titlefield">원가</div>
						<div class="titlefield">판매가</div>
						<div class="titlefield">마진</div>
						<div class="titlefield">등록일</div>
						<div class="titlefield">카테고리</div>
						<div class="titlefield">베스트YN</div>
						<div class="titlefield">판매중YN</div>
						<div class="titlefield"> <input type="checkbox" id=checkAll> </div>
					</div>

					<div class="listbox">
						<c:choose>
							<c:when test="${empty adminGoodsList}">
								<div class="list-row">
									<div>등록된 상품이 없습니다</div>
								</div>
							</c:when>
							<c:otherwise>
								<c:forEach items="${adminGoodsList}" var="agvo">
									<div class="list-row">					
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.gseq}</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.gname}</div>
										<div class="admin-goods-thumbnail" onclick="viewGoodsDetail(${agvo.gseq})" >
											<img src="<c:url value='/imageWrite.do?folder=${agvo.gseq}${agvo.gname}&realName=${agvo.realname}'/>">
										</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.oprice}</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.sprice}</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.mprice}</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.indate}</div>
										<div class="listfield" onclick="viewGoodsDetail(${agvo.gseq})">${agvo.category}</div>
										<c:choose>
											<c:when test="${agvo.bestyn == 1}">
												<div class="listfield">Y</div>
											</c:when>
											<c:otherwise>
												<div class="listfield">N</div>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${agvo.useyn == 1}">
												<div class="listfield">Y</div>
											</c:when>
											<c:otherwise>
												<div class="listfield">N</div>
											</c:otherwise>
										</c:choose>
										<div class="listfield"> 
											<input type="checkbox" id="checkboxes" name="gseq" value="${agvo.gseq}" />
										</div>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</div>
				</div>
			
				<div class="input-button">
					<input type="button" id="bestToggle" value="베스트 상품 변경">
					<input type="button" id="useynToggle" value="상품 판매여부 변경">
					<input type="button" id="deleteGoods" value="상품 삭제">
				</div>
			

				<ul class="pagination justify-content-center" id="pagination">
		 			<c:if test="${paging.totalCount > paging.displayRow}">		
					<!-- 이전 버튼 -->
						<c:if test="${paging.prev}">
							<li class="page-item">
								<div class="page-link" onclick="pageClick(${paging.beginPage-1}, ${url})">prev</div>
							</li>
						</c:if>
					<!-- 페이지 번호 -->
					<c:forEach var="num" begin="${paging.beginPage}" end="${paging.endPage}">
						
						<c:if test="${num == paging.page}">
							<li class="page-item active">
								<div class="page-link" onclick="pageClick(${num}, '${url}')" data-value="${num}">
									${num}
								</div>
							</li>
						</c:if>
						<c:if test="${num != paging.page}">
							<li class="page-item" id="nextbtn">
								<div class="page-link" onclick="pageClick(${num}, '${url}')" data-value="${num}">
									${num}
								</div>
							</li>
						</c:if>
					</c:forEach>
					<!-- 다음 버튼 -->
						<c:if test="${paging.next}">
							<li class="page-item">
								<div class="page-link" onclick="pageClick(${paging.endPage+1}, ${url})">next</div>
							</li>
						</c:if>
					</c:if>
				</ul>
			</div>
		</div>
	</form>
	</div>
<script type="text/javascript" src="<c:url value='/resources/js/admin/goodsView.js'/>"></script>
</body>
</html>