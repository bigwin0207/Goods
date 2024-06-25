<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>category</title>
<link rel="stylesheet" href="/css/index/index.css">
</head>
<body>

	<div id="container">
		<div class="section">
			<div class="product-row">
				<c:forEach items="${categoryList}" var="gvo">
					<div class="product-box">			
						<div class="product-info">
							<a href="goodsDetailView?gseq=${gvo.gseq}">
								<div class="category-image">									
									<img alt="${gvo.imageList[0].realname}" src="imageWrite?folder=${gvo.gseq}${gvo.gname}&realName=${gvo.imageList[0].realname}">
								</div>		
								${gvo.gname} - <fmt:formatNumber type="currency" value="${gvo.sprice}"></fmt:formatNumber>				
							</a>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>


	<div class="page-container" id="pagination">
		<div class="page-row">
		<c:if test="${paging.totalCount > paging.displayRow}">
			<!-- 이전 버튼 -->
			<c:if test="${paging.prev}">
				<div class="page-item">
					<div class="page-link"
						onclick="pageClick(${paging.beginPage-1}, ${url})">prev</div>
				</div>
			</c:if>
			<!-- 페이지 번호 -->
			<c:forEach var="num" begin="${paging.beginPage}"
				end="${paging.endPage}">

				<c:if test="${num == paging.page}">
					<div class="page-item-active">
						<div class="page-link" onclick="pageClick(${num}, '${url}')"
							data-value="${num}">${num}</div>
					</div>
				</c:if>
				<c:if test="${num != paging.page}">
					<div class="page-item" id="nextbtn">
						<div class="page-link" onclick="pageClick(${num}, '${url}')"
							data-value="${num}">${num}</div>
					</div>
				</c:if>
			</c:forEach>
			<!-- 다음 버튼 -->
			<c:if test="${paging.next}">
				<div class="page-item">
					<div class="page-link"
						onclick="pageClick(${paging.endPage+1}, ${url})">next</div>
				</div>
			</c:if>
		</c:if>
		</div>
	</div>

</body>
<%@ include file="../footer.jsp"%>
</html>