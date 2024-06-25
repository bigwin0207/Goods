<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문목록</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/admin.css'/>">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet" href="<c:url value='/resources/css/goods.css'/>">
</head>
<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>
        	
	      	<form name="adminOrderForm" id="adminOrderForm" method="post">
        	<div id="layoutSidenav_content">
        		<div class="container-fluid px-4">
                	<h1 class="mt-4">  </h1><br/> <!-- 제목 -->
					<div class="row w-100">
				    	<div class="col d-flex justify-content-end"> <!-- 검색 폼 -->
				    	
 				    		<select class="form-select w-25 me-1" name="searchBy" id="searchBy">
 				    		
				      			<c:choose>
				      				<c:when test="${not empty searchBy}">
											<c:choose>
												<c:when test="${searchBy == 'gname'}">
											  		<option value="gname" selected>상품명</option>
											  		<option value="userid">주문인 ID</option>
											  		<option value="name">주문인 성명</option>											  		
												</c:when>
												<c:when test="${searchBy == 'userid'}">
											  		<option value="gname" >상품명</option>
											  		<option value="userid" selected>주문인 ID</option>
											  		<option value="name">주문인 성명</option>											  		
												</c:when>												
												<c:otherwise>
											  		<option value="gname" >상품명</option>
											  		<option value="userid" >주문인 ID</option>
											  		<option value="name" selected>주문인 성명</option>		
												</c:otherwise>
											</c:choose>
									</c:when>
									<c:otherwise>
							  		<option value="gname" selected>상품명</option>
							  		<option value="userid">주문인 ID</option>
							  		<option value="name">주문인 성명</option>	
									</c:otherwise>
								</c:choose> 				    		
							</select>
				      		<div class="d-flex">
					      		<c:choose>
						      		<c:when test="${not empty key}">
						      			<input class="form-control me-2" name="searchKey" type="text" value="${key}">
						      		</c:when>
						      		<c:otherwise>					      		
										<input class="form-control me-2" name="searchKey" type="text" placeholder="search">						      		
						      		</c:otherwise>
						      	</c:choose>
					    	</div>
						<div class="d-flex" id="goSearch">
							<input type="button" value="검색">
						</div>					    	
				    	</div>
					</div>
					<br/>
					
					<div class="row w-100"> <!--  목록 테이블 -->
				  		<table class="table table-hover">
				  			<thead class="text-center table-light">
				  				<tr>
				  					<th>주문번호</th>
				  					<th>주문인ID</th>
				  					<th>주문인성명</th>
				  					<th>주문상품</th>
				  					<th>주문일시</th>
				  					<th>주문총액</th>
				  					<th>처리상태</th>
				  					<th><input type="checkbox" id=checkAll></th>
				  				</tr>
				  			</thead>
				  			<tbody id="infoTable">
				  				<c:forEach var="ord" items="${orderList}">
				  					<tr>
				  						<td>
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								${ord.oseq}
				  							</a>
				  						</td>
				  						<td class="text-center">
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								${ord.userid}
				  							</a>				  						
				  						</td>
				  						<td class="text-center">
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								${ord.name}
				  							</a>				  						
				  						</td>				  						
				  						<td class="text-center">
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								${ord.gname} 포함 ${ord.quantity} 건
				  							</a>
				  						</td>
				  						<td class="text-center">
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								${ord.indate}
				  							</a>
				  						</td>
				  						<td class="text-center">
				  							<a href="<c:url value='/adminOrderDetailView.do?oseq=${ord.oseq}'/>">
				  								<fmt:formatNumber type="currency" value="${ord.totalprice}"></fmt:formatNumber>
				  							</a>
				  						</td>
				  						<td class="text-center">
											${ord.status}
				  						</td>
										<td>
											<input type="checkbox" id="checkboxes" name="oseq"
											value="${ord.oseq}" />
										</td>
								</tr>
				  				</c:forEach>
				  			</tbody>
				  		</table>
					<div class="col d-flex justify-content-end">
						<select class="form-select w-25 me-1" name="osseq"
							id="osseq">
							<option value="0" selected> 주문상태 선택 </option>
							<option value="1" >주문완료</option>
							<option value="2">배송준비중</option>
							<option value="3">배송중</option>
							<option value="4">배송완료</option>
						</select> <input type="button" id="changeStat" value="변경"> 
					</div>
				</div>


				
			<c:if test="${paging.totalCount > paging.displayRow}">				
				<ul class="pagination justify-content-center" id="pagination">
					<!-- 이전 버튼 -->
						<c:if test="${paging.prev}">
							<li class="page-item">
								<div class="page-link" onclick="pageClick(${paging.beginPage-1}, ${url})">prev</div>
							</li>
						</c:if>
					<!-- 페이지 번호 -->
					<c:forEach var="num" begin="${paging.beginPage}"
						end="${paging.endPage}">
						
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
				</ul>
			</c:if>

			</div>
        	</div>   
        	 </form>         
        </div>
       
	<script type="text/javascript" src="<c:url value='/resources/js/admin/admin.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/resources/js/admin/adminOrder.js'/>"></script>
    </body>
</html>