<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 상세정보</title>
<link rel="stylesheet"
	href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="<c:url value='/resources/css/goods.css'/>">
</head>
<body class="sb-nav-fixed">
	<!-- header -->
	<jsp:include page="../fix/admin/header.jsp" />

	<div id="layoutSidenav">
		<!-- side -->
		<jsp:include page="../fix/admin/sidemenu.jsp" />

		<div id="layoutSidenav_content">
			<div class="container-fluid px-4">
				<h1 class="mt-4"></h1><br /><!-- 제목 -->
				<div class="row w-100">


					<form name="adminOrderForm">
						<hr>
						<div>주문자 정보</div>
						<div>
							<div>주문번호 : ${orderDetailList[0].oseq}</div>
							<div>주문자성명: ${orderDetailList[0].name}</div>
							<div>주문주소 : ${orderDetailList[0].address}
								${orderDetailList[0].daddress}</div>
							<div>주문일시 : ${orderDetailList[0].indate}</div>
							<div>주문상태 : ${orderDetailList[0].status}</div>
						</div>

						<hr>
						<div>주문 상품 정보</div>
						<c:choose>
							<c:when test="${empty orderDetailList}">
								<h1>텅~</h1>
							</c:when>
							<c:otherwise>
								<c:forEach items="${orderDetailList}" var="ovo">
									<div>
										<div class="thumbnail">
											<img class="thumbnailimg" src="<c:url value='/imageWrite.do?folder=${ovo.gseq}${ovo.gname}&realName=${ovo.realname}'/>">
										</div>
										<div>상품별 주문번호 : ${ovo.odseq}</div>
										<div>상품명 : ${ovo.gname}</div>
										<div>수량 : ${ovo.quantity} 개</div>
										<div>금액 : ${ovo.totalprice} 원</div>
										<hr>
									</div>
								</c:forEach>
							</c:otherwise>
						</c:choose>

						<div class="col d-flex justify-content-start">
							<select class="form-select w-25 me-1" name="osseq" id="osseq">
								<option value="0" selected>주문상태 선택</option>
								<option value="1">주문완료</option>
								<option value="2">배송준비중</option>
								<option value="3">배송중</option>
								<option value="4">배송완료</option>
							</select> <input type="button" id="changeStat" value="변경">
						</div>
							
						<input type="hidden" name="oseq" value="${orderDetailList[0].oseq}">
					</form>
				</div>
			</div>
		</div>
	</div>

<script type="text/javascript" src="<c:url value='/resources/js/admin/adminOrder.js'/>"></script>
</body>
</html>