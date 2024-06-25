<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="d-flex">
	<nav class="d-flex">
	  <ul class="pagination justify-content-center" id="pagination">
	  	<!-- 이전 버튼 -->
	  	<c:choose>
	  		<c:when test="${paging.prev}">
	  			<li class="page-item">
	  				<a class="page-link" data-value="prev">Prev</a>
	  			</li>
	  		</c:when>
	  		<c:otherwise>
	  			<li class="page-item disabled">
	  				<a class="page-link">Prev</a>
	  			</li>
	  		</c:otherwise>
	  	</c:choose>
	  	<!-- 페이지 번호 -->
	  	<c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
	  		<c:if test="${num == paging.currentPage}">
	  			<li class="page-item active"><a class="page-link" data-value="${num}">${num}</a></li>
	  		</c:if>
	  		<c:if test="${num != paging.currentPage}">
	  			<li class="page-item"><a class="page-link" data-value="${num}">${num}</a></li>
	  		</c:if>
	  	</c:forEach>
	    <!-- 다음 버튼 -->
	    <c:choose>
	  		<c:when test="${paging.next}">
	  			<li class="page-item">
	  				<a class="page-link" data-value="next">Next</a>
	  			</li>
	  		</c:when>
	  		<c:otherwise>
	  			<li class="page-item disabled">
	  				<a class="page-link">Next</a>
	  			</li>
	  		</c:otherwise>
	  	</c:choose>
	  </ul>
	</nav>
</div>