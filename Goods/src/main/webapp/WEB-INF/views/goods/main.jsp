<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>

</head>

<body>

	<c:choose>
		<c:when test="${empty loginUser}">
			<div>
				<h3>로그인하삼</h3>
				<button id="login"> 로그인ㄱㄱ </button>
			</div>
		</c:when>
		<c:otherwise>
			<div> ${loginUser.userid} ㅎㅇ </div>
			<div> 
				<button id="go_cart"> 장바구니 보기 </button>
				<button id="go_wishlist"> 찜목록 보기 </button>
			</div>
			<h3>하이</h3>			
		</c:otherwise>
	</c:choose>

	<div>
		<div> <h3>베스트 20</h3> </div>
		<c:forEach items="${bestlist}" var="gvo" varStatus="status">

			<div>				
				<div>
					<a href="goodsDetailView.do?gseq=${gvo.gseq}">
						<img alt="${gvo.thum}.png" src='<c:url value="/resources/image/goods/${gvo.thum}.png"/>'>	
					</a>
					<a href="goodsDetailView.do?gseq=${gvo.gseq}">
						${gvo.gname} - <fmt:formatNumber type="currency" value="${gvo.sprice}"></fmt:formatNumber>					
					</a>
				</div>
			</div>
		</c:forEach>	
	</div>
	<div>
		<div> <h3>신상품</h3> </div>
		<c:forEach items="${newlist}" var="gvo" varStatus="status">

			<div>				
				<div>
					<a href="goodsDetailView.do?gseq=${gvo.gseq}">
						<img alt="${gvo.thum}.png" src='<c:url value="/resources/image/goods/${gvo.thum}.png"/>'>	
					</a>		
					<a href="goodsDetailView.do?gseq=${gvo.gseq}">
						${gvo.gname} - <fmt:formatNumber type="currency" value="${gvo.sprice}"></fmt:formatNumber>					
					</a>		
				</div>
			</div>
		</c:forEach>	
	</div>

	<script type="text/javascript" src='<c:url value = "/resources/js/goods/main.js"/>'></script>
</body>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
</html>