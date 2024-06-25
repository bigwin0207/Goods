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
	<div class="container-title"> 장바구니 보기 </div>
	<form name="cartlistform" method="post">
		<c:choose>
			<c:when test="${empty cartlist}">
				<div>
					상품이 존재하지 않습니다.
				</div>
			</c:when>
            <c:otherwise>

		<div class="titlerow">
            <div class="titlefield">상품</div>
            <div class="titlefield">상품명</div>
            <div class="titlefield">수량</div>
            <div class="titlefield">금액</div>
            <div class="titlefield">
                <input type="checkbox" id="checkAll">
            </div>
        </div>

                <ul class="listbox">
                    <c:forEach items="${cartlist}" var="cvo">
                        <li class="list-row">
                            <div class="list-imgbox">
                                <img src="<c:url value='/imageWrite.do?folder=${cvo.gseq}${cvo.goodsname}&realName=${cvo.realname}'/>">
                            </div>
                            <div class="listfield">${cvo.goodsname}</div>
                            <div class="listfield">${cvo.quantity} 개</div>
                            <div class="listfield"><fmt:formatNumber type="currency" value="${cvo.totalprice}"></fmt:formatNumber></div>
                            <div class="listfield">
                                <input type="checkbox" id="checkboxes" name="gseq" value="${cvo.gseq}" />
                                <input type="hidden" name="quantity" value="${cvo.quantity}">
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </c:otherwise>
		</c:choose>

        <div class="input-button">
            <input id="go_main" type="button" value="메인으로"> 
            <input id="cart_delete" type="button" value="선택상품 삭제">
            <input id="cart_order" type="button" value="선택상품 주문">
        </div>
	</form>
</div>	
	
	
<script type="text/javascript" src='<c:url value="/resources/js/goods/cartlist.js"/>'></script>
</body>
<%@ include file="../footer.jsp"%>
</html>