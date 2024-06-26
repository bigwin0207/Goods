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
		<div class="container-title"> 상세 주문 조회 </div>

		<div class="inner-container">
			<div class="container-inner-title">주문자 정보</div>	
			<div class="titlerow">
				<div class="titlefield">주문번호 </div>
				<div class="titlefield">주문자성명</div>
				<div class="titlefield">주문주소</div>
				<div class="titlefield">주문일시 </div>
				<div class="titlefield">주문상태 </div> 
			</div>

			<div class="listbox">
				<div class="list-row">
					<div class="titlefield"> ${orderDetailList[0].oseq}</div>
					<div class="titlefield"> ${orderDetailList[0].name}</div>
					<div class="titlefield"> ${orderDetailList[0].address1} ${orderDetailList[0].address2} ${orderDetailList[0].address3} </div>
					<div class="titlefield"> ${orderDetailList[0].indate}</div>
					<div class="titlefield"> ${orderDetailList[0].status}</div> 
				</div>
			</div>
		</div>

		<div class="inner-container">
			<div class="container-inner-title">주문상품 정보</div>
			<c:forEach items="${orderDetailList}" var="ovo">
				<div class="titlerow">
					<div class="titlefield">상품별 주문번호</div>
					<div class="titlefield">상품명</div>
					<div class="titlefield">수량</div>
					<div class="titlefield">금액</div>
				</div>
				<div class="listbox">
					<div class="list-row">
						<div class="titlefield"> ${ovo.odseq}</div>
						<div class="titlefield"> ${ovo.gname}</div>
						<div class="titlefield"> ${ovo.quantity} 개</div>
						<div class="titlefield"> <fmt:formatNumber value="${ovo.totalprice}"></fmt:formatNumber> </div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<%@ include file="../footer.jsp"%>
</body>
</html>