<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/css/listView.css">
</head>
<body>

	<div class="view-container">
		<div class="container-title"> 주문하기 </div>
		<form method="post" name="orderpageform">

			<div class="titlerow">
				<div class="titlefield">상품</div>
				<div class="titlefield">상품명</div>
				<div class="titlefield">수량</div>
				<div class="titlefield">금액</div>
				<div class="titlefield">
					<input type="checkbox" id="checkAll">
				</div>
			</div>
			

			<c:choose>
				<c:when test="${empty orderProductList}">
					<div>
						상품이 존재하지 않습니다.
					</div>
				</c:when>
				<c:otherwise>
					<ul class="listbox">
						<c:forEach items="${orderProductList}" var="ovo">
							<li class="list-row">
								<div class="list-imgbox">
									<img src="imageWrite?folder=${ovo.gseq}${ovo.gname}&realName=${ovo.realname}">
								</div>
								<div class="listfield">${ovo.gname}</div>
								<div class="listfield">${ovo.quantity} 개</div>
								<div class="listfield"><fmt:formatNumber type="currency" value="${ovo.totalprice}"></fmt:formatNumber></div>
								<div class="listfield">
									<input type="checkbox" id="checkboxes" name="gseq" value="${ovo.gseq}" />
									<input type="hidden" name="quantity" value="${ovo.quantity}">
									<input type="hidden" name="totalprice" value="${ovo.totalprice}">
								</div>
							</li>
							<input type="hidden" name="gseq" value="${ovo.gseq}">
						</c:forEach>
					</ul>
				</c:otherwise>
			</c:choose>

			<div class="input-button">
				<input type="button" id="go_order" value="주문하기">
				<input type="hidden" name="numberOfGoods">
				<input type="hidden" name="orderTotalPrice">
			</div>
		</form>
	</div>	
	
	<script type="text/javascript" src='script/goods/order.js'></script>
</body>

<%@ include file="../footer.jsp"%>
</html>