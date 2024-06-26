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
		<div class="container-title"> 주문내역 </div>


		<c:choose>
			<c:when test="${empty orderList}">
				<div>
					상품이 존재하지 않습니다.
				</div>
			</c:when>
			<c:otherwise>
				<div class="titlerow">
					<div class="titlefield">주문번호</div>
					<div class="titlefield">주문상품</div>
					<div class="titlefield">주문일시</div>
					<div class="titlefield">주문금액</div>
					<div class="titlefield">주문상태</div>
				</div>

				<ul class="listbox">			
					<c:forEach items="${orderList}" var="ovo">
						<a href="orderDetailView?oseq=${ovo.oseq}">
							<li class="list-row">
									<div class="listfield">${ovo.oseq}</div>
									<div class="listfield">${ovo.gname} 포함 ${ovo.quantity} 개</div>
									<div class="listfield">${ovo.indate}</div>
									<div class="listfield"> <fmt:formatNumber value="${ovo.totalprice}"></fmt:formatNumber> </div>
									<div class="listfield">${ovo.status}</div>

									<input type="hidden" name="oseq" value="${ovo.oseq}">
							</li>
						</a>
					</c:forEach>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
	
	<div class="page-container" id="pagination">
		<div class="page-row">
		<c:if test="${paging.totalCount > paging.displayRow}">
			<!-- 이전 버튼 -->
			<c:if test="${paging.prev}">
				<div class="page-item">
					<a href="viewOrderList?page=${paging.beginPage-1}">
						prev
					</a>
				</div>
			</c:if>
			<!-- 페이지 번호 -->
			<c:forEach var="num" begin="${paging.beginPage}"
				end="${paging.endPage}">

				<c:if test="${num == paging.page}">
					<div class="page-item-active">
						<a href="viewOrderList?page=${num}">
							${num}
						</a>
					</div>
				</c:if>
				<c:if test="${num != paging.page}">
					<div class="page-item">
						<a href="viewOrderList?page=${num}">
							${num}
						</a>
					</div>
				</c:if>
			</c:forEach>
			<!-- 다음 버튼 -->
			<c:if test="${paging.next}">
				<div class="page-item">
					<a href="viewOrderList?page=${paging.endPage+1}">
							next
					</a>
				</div>
			</c:if>
		</c:if>
		</div>
	</div>

<%@ include file="../footer.jsp"%>
