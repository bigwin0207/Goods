<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="<c:url value='/resources/css/listView.css'/>">
</head>

<body>
	<div class="view-container">
		<div class="container-title"> Wishlist </div>


			<form name="wishlistform" method="post">


				<c:choose>
					<c:when test="${empty wishlist}">
						<div>
							상품이 존재하지 않습니다.
						</div>
					</c:when>
				
					<c:otherwise>
						<div class="titlerow">
							<div class="titlefield">상품</div>
							<div class="titlefield">상품명</div>
							<div class="titlefield">가격</div>
							<div class="titlefield">
								<input type="checkbox" id="checkAll">
							</div>
						</div>

						<ul class="listbox">
							<c:forEach items="${wishlist}" var="cvo">
								<li class="list-row">
									<div class="list-imgbox">
										<img src="<c:url value='/imageWrite.do?folder=${cvo.gseq}${cvo.goodsname}&realName=${cvo.realname}'/>">
									</div>
									<div class="listfield">${cvo.goodsname}</div>
									<div class="listfield"><fmt:formatNumber type="currency" value="${cvo.sprice}"></fmt:formatNumber></div>
									<div class="listfield">
										<input type="checkbox" id="checkboxes" name="gseq" value="${cvo.gseq}" />
									</div>
								</li>
							</c:forEach>
						</ul>

						<div class="input-button">
							<input id="wish_delete" type="button" value="선택상품 삭제">
							<input id="wish_to_cart" type="button" value="장바구니로 이동">
						</div>
					</c:otherwise>
				</c:choose>

			</form>
		</div>
	</div>
<script type="text/javascript" src='<c:url value="/resources/js/goods/wishlist.js"/>'></script>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp" %>
</html>