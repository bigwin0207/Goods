<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="/WEB-INF/jsp/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰</title>
<link rel="stylesheet" href="<c:url value='/resources/css/bootstrap.min.css'/>">
<link rel="stylesheet" href="<c:url value='/resources/css/review/review.css'/>">
</head>
<body>
<div class="row d-flex justify-content-center mb-4">
	<div class="col-lg-6 w-75">
		<div class="card">
        	<div class="card-body">
            	<h5 class="card-title">리뷰</h5>
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<button class="nav-link active" id="all-tab">전체보기</button>
                	</li>
                	<c:if test="${not empty loginUser}">
	                <li class="nav-item">
	                	<button class="nav-link" id="my-tab">내 리뷰</button>
	                </li>
	                </c:if>
				</ul>
				<div class="tab-content pt-2">
					<div class="row w-100">
           				<div class="col d-flex">
              				<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
						  		<option value=0 selected>목록</option>
						  		<option value=5>5</option>
						  		<option value=10>10</option>
						  		<option value=20>20</option>
							</select>
						</div>
						<div class="col d-flex justify-content-end">
				    		<select class="form-select w-25 me-1" name="search" id="search">
						  		<option value="gname" selected>굿즈명</option>
						  		<option value="subject">제목</option>
							</select>
				      		<div class="d-flex">
					      		<input class="form-control me-2" name="keyword" id="keyword" type="text" placeholder="Search">
					    	</div>
				    	</div>
	            	</div>
					<!-- -------------------------------------------------------------------------------------------------------------------------------------------------- -->
              		<div class="tab-pane fade show active" id="allReview">
		            	<div>
	                  		<ul>
	                  			<li class="review-header">
	                  				<div class="d-flex">
	                  					<div class="small-col">번호</div>
	                  					<div>사진</div>
	                  					<div class="small-col">카테고리</div>
	                  					<div>굿즈명</div>
	                  					<div>리뷰제목</div>
	                  					<div>구매자</div>
	                  					<div>리뷰작성일자</div>
	                  				</div>
	                  			</li>
	                  		</ul>
                  		</div>
                  		<div>
	                  		<ul id="review-list">
								<c:forEach var="rev" items="${reviewList}">
								<a class="link" href="<c:url value='/goodsDetailView.do?gseq=${rev.gseq}'/>">
									<li class="review-item">
										<div class="d-flex justify-content-center align-items-center">
											<div class="small-col">${rev.rseq}</div>
			               					<div><img src="<c:url value='imageWrite.do?folder=${rev.gseq}${rev.gname}&realName=${rev.realName}'/>"></div>
			               					<div class="small-col">[${rev.category}]</div>
			               					<div>
			               						<c:choose>
													<c:when test="${fn:length(rev.gname) gt 10}">
														<c:out value="${fn:substring(rev.gname, 0, 9)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${rev.gname}"/>
													</c:otherwise>
												</c:choose>
			               					</div>
			               					<div>
			               						<c:choose>
													<c:when test="${fn:length(rev.subject) gt 18}">
														<c:out value="${fn:substring(rev.subject, 0, 17)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${rev.subject}"/>
													</c:otherwise>
												</c:choose>
			               					</div>
			               					<div><img id="badge" src="<c:url value='/resources/image/badge/${rev.grade}.png'/>"> ${rev.userid}</div>
			               					<div><fmt:formatDate value="${rev.indate}" type="both" pattern="yyyy-MM-dd" /></div>
		               					</div>
									</li>
								</a>
								</c:forEach>
							</ul>
						</div>
						<span id="pagdInfo">${paging.currentPage} / ${paging.realEnd}</span>
						<nav>
							<ul class="pagination justify-content-center" id="pagination">
						  	<!-- 이전 버튼 -->
						  	<c:choose>
						  		<c:when test="${paging.prev}">
						  			<li class="page-item">
						  				<a class="page-link all-page-link" data-value="prev">Prev</a>
						  			</li>
						  		</c:when>
						  		<c:otherwise>
						  			<li class="page-item disabled">
						  				<a class="page-link all-page-link">Prev</a>
						  			</li>
						  		</c:otherwise>
						  	</c:choose>
						  	<!-- 페이지 번호 -->
						  	<c:forEach var="num" begin="${paging.startPage}" end="${paging.endPage}">
						  		<c:if test="${num == paging.currentPage}">
						  			<li class="page-item active"><a class="page-link all-page-link" data-value="${num}">${num}</a></li>
						  		</c:if>
						  		<c:if test="${num != paging.currentPage}">
						  			<li class="page-item"><a class="page-link all-page-link" data-value="${num}">${num}</a></li>
						  		</c:if>
						  	</c:forEach>
						    <!-- 다음 버튼 -->
						    <c:choose>
						  		<c:when test="${paging.next}">
						  			<li class="page-item">
						  				<a class="page-link all-page-link" data-value="next">Next</a>
						  			</li>
						  		</c:when>
						  		<c:otherwise>
						  			<li class="page-item disabled">
						  				<a class="page-link all-page-link">Next</a>
						  			</li>
						  		</c:otherwise>
						  	</c:choose>
						  	</ul>
						</nav>
                  	</div>
                  	<!-- -------------------------------------------------------------------------------------------------------------------------------------------------- -->
                  	<div class="tab-pane fade" id="myReview">
	                  	<c:choose>
	                  		<c:when test="${not empty loginUser}">
								<div>
			                		<ul>
			                  			<li class="review-header">
			                  				<div class="d-flex">
			                  					<div class="small-col">번호</div>
			                  					<div>사진</div>
			                  					<div class="small-col">카테고리</div>
			                  					<div>굿즈명</div>
			                  					<div>리뷰제목</div>
			                  					<div>구매자</div>
			                  					<div>리뷰작성일자</div>
			                  				</div>
			                  			</li>
			                  		</ul>
		                  		</div>
		                  		<div>
			                  		<ul id="my-review-list">
										<c:forEach var="rev" items="${reviewMyList}">
										<a class="link" href="<c:url value='/goodsDetailView.do?gseq=${rev.gseq}'/>">
											<li class="review-item">
												<div class="d-flex justify-content-center align-items-center">
													<div class="small-col">${rev.rseq}</div>
					               					<div><img src="<c:url value='/imageWrite.do?folder=${rev.gseq}${rev.gname}&realName=${rev.realName}'/>"></div>
					               					<div class="small-col">[${rev.category}]</div>
					               					<div>
					               						<c:choose>
															<c:when test="${fn:length(rev.gname) gt 10}">
																<c:out value="${fn:substring(rev.gname, 0, 9)}"/>...
															</c:when>
															<c:otherwise>
																<c:out value="${rev.gname}"/>
															</c:otherwise>
														</c:choose>
					               					</div>
					               					<div>
					               						<c:choose>
															<c:when test="${fn:length(rev.subject) gt 18}">
																<c:out value="${fn:substring(rev.subject, 0, 17)}"/>...
															</c:when>
															<c:otherwise>
																<c:out value="${rev.subject}"/>
															</c:otherwise>
														</c:choose>
					               					</div>
					               					<div><img id="badge" src="<c:url value='/resources/image/badge/${rev.grade}.png'/>"> ${rev.userid}
					               					</div>
					               					<div><fmt:formatDate value="${rev.indate}" type="both" pattern="yyyy-MM-dd" /></div>
				               					</div>
											</li>
										</a>
										</c:forEach>
									</ul>
								</div>
								<span id="myPagdInfo">${myPaging.currentPage} / ${myPaging.realEnd}</span>
								<nav>
									<ul class="pagination justify-content-center" id="myPagination">
								  	<!-- 이전 버튼 -->
								  	<c:choose>
								  		<c:when test="${myPaging.prev}">
								  			<li class="page-item">
								  				<a class="page-link my-page-link" data-value="prev">Prev</a>
								  			</li>
								  		</c:when>
								  		<c:otherwise>
								  			<li class="page-item disabled">
								  				<a class="page-link my-page-link">Prev</a>
								  			</li>
								  		</c:otherwise>
								  	</c:choose>
								  	<!-- 페이지 번호 -->
								  	<c:forEach var="num" begin="${myPaging.startPage}" end="${myPaging.endPage}">
								  		<c:if test="${num == myPaging.currentPage}">
								  			<li class="page-item active"><a class="page-link my-page-link" data-value="${num}">${num}</a></li>
								  		</c:if>
								  		<c:if test="${num != myPaging.currentPage}">
								  			<li class="page-item"><a class="page-link my-page-link" data-value="${num}">${num}</a></li>
								  		</c:if>
								  	</c:forEach>
								    <!-- 다음 버튼 -->
								    <c:choose>
								  		<c:when test="${myPaging.next}">
								  			<li class="page-item">
								  				<a class="page-link my-page-link" data-value="next">Next</a>
								  			</li>
								  		</c:when>
								  		<c:otherwise>
								  			<li class="page-item disabled">
								  				<a class="page-link my-page-link">Next</a>
								  			</li>
								  		</c:otherwise>
								  	</c:choose>
								  	</ul>
								</nav>
								</c:when>
	                  		<c:otherwise>
	                  			로그인 해주세요
	                  		</c:otherwise>
	                  	</c:choose>
                	</div>
              	</div>
            </div>
    	</div>
	</div>
</div>
<script type="text/javascript" src="<c:url value='/resources/js/review/review.js'/>"></script>
</body>
<%@ include file="/WEB-INF/jsp/footer.jsp"%>
</html>