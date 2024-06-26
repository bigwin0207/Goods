<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Q&A 리스트</title>
<link rel="stylesheet" href="../index/bootstrap.min.css">
<link rel="stylesheet" href="../css/qna/qna.css">
</head>
<body>
<div class="row d-flex justify-content-center mb-5">
	<div class="col-lg-6 w-75">
		<div class="card">
        	<div class="card-body">
            	<h5 class="card-title">Q&A</h5>
				<ul class="nav nav-tabs">
					<li class="nav-item">
						<button class="nav-link active" id="all-tab">전체보기</button>
                	</li>
                	<c:if test="${not empty loginUser}">
	                <li class="nav-item">
	                	<button class="nav-link" id="my-tab">내 Q&A</button>
	                </li>
	                </c:if>
				</ul>
				<div class="tab-content pt-2">
					<div class="row w-100">
           				<div class="col d-flex">
              				<select class="form-select w-25 me-3" name="selectAmount" id="selectAmount">
						  		<option value=0 selected>목록</option>
						  		<option value=10>10</option>
						  		<option value=30>30</option>
						  		<option value=50>50</option>
							</select>
						</div>
						<div class="col d-flex justify-content-end">
				    		<select class="form-select w-25 me-1" name="search" id="search">
						  		<option value="sc" selected>제목 + 내용</option>
						  		<option value="subject">제목</option>
						  		<option value="content">내용</option>
							</select>
				      		<div class="d-flex">
					      		<input class="form-control me-2" name="keyword" id="keyword" type="text" placeholder="Search">
					    	</div>
				    	</div>
	            	</div>
					<!-- -------------------------------------------------------------------------------------------------------------------------------------------------- -->
              		<div class="tab-pane fade show active" id="allQna">
		            	<div>
	                  		<ul>
	                  			<li class="qna-header">
	                  				<div class="d-flex">
	                  					<div>번호</div>
	                  					<div>제목</div>
	                  					<div>내용</div>
	                  					<div>작성자</div>
	                  					<div>작성일자</div>
	                  					<div>답변일자</div>
	                  				</div>
	                  			</li>
                  			</ul>
                  		</div>
                  		<div>
                  			<ul id="qna-list">
							<c:forEach var="qna" items="${qnaList}">
							<a class="link" href="qnaView?qseq=${qna.qseq}">
								<li class="qna-item">
									<div class="d-flex justify-content-center align-items-center">
										<div>${qna.qseq}</div>
		               					<div>
		               						<c:choose>
												<c:when test="${fn:length(qna.subject) gt 10}">
													<c:out value="${fn:substring(qna.subject, 0, 9)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${qna.subject}"/>
												</c:otherwise>
											</c:choose>
		               					</div>
		               					<div>
		               						<c:choose>
												<c:when test="${fn:length(qna.content) gt 10}">
													<c:out value="${fn:substring(qna.content, 0, 9)}"/>...
												</c:when>
												<c:otherwise>
													<c:out value="${qna.content}"/>
												</c:otherwise>
											</c:choose>
		               					</div>
		               					<div>${qna.userid}</div>
		               					<div><fmt:formatDate value="${qna.indate}" type="both" pattern="yyyy-MM-dd" /></div>
		               					<div><fmt:formatDate value="${qna.replyDate}" type="both" pattern="yyyy-MM-dd" /></div>
	               					</div>
								</li>
							</a>
							</c:forEach>
							</ul>
						</div>
						<span id="pageInfo">${paging.currentPage} / ${paging.realEnd}</span>
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
					<div class="tab-pane fade" id="myQna">
		            	<div>
	                		<ul>
	                  			<li class="qna-header">
	                  				<div class="d-flex">
	                  					<div>번호</div>
	                  					<div>제목</div>
	                  					<div>내용</div>
	                  					<div>작성자</div>
	                  					<div>작성일자</div>
	                  					<div>답변일자</div>
	                  				</div>
	                  			</li>
	                  		</ul>
                  		</div>
                  		<div>
                  			<ul id="my-qna-list">
								<c:forEach var="qna" items="${qnaMyList}">
								<a class="link" href="qnaView?qseq=${qna.qseq}">
									<li class="qna-item">
										<div class="d-flex justify-content-center align-items-center">
											<div>${qna.qseq}</div>
			               					<div>
			               						<c:choose>
													<c:when test="${fn:length(qna.subject) gt 10}">
														<c:out value="${fn:substring(qna.subject, 0, 9)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${qna.subject}"/>
													</c:otherwise>
												</c:choose>
			               					</div>
			               					<div>
			               						<c:choose>
													<c:when test="${fn:length(qna.content) gt 10}">
														<c:out value="${fn:substring(qna.content, 0, 9)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${qna.content}"/>
													</c:otherwise>
												</c:choose>
			               					</div>
			               					<div>${qna.userid}</div>
			               					<div><fmt:formatDate value="${qna.indate}" type="both" pattern="yyyy-MM-dd" /></div>
			               					<div><fmt:formatDate value="${qna.replyDate}" type="both" pattern="yyyy-MM-dd" /></div>
		               					</div>
									</li>
								</a>
								</c:forEach>
							</ul>
						</div>
						<jsp:include page="../paging.jsp" >
							<jsp:param value="NoiceList" name=""/>
						</jsp:include>
                	</div>
              	</div>
              	<div class="d-flex justify-content-end">
	              	<c:if test="${not empty loginUser}">
							<a class="btn btn-secondary" href="qnaWriteForm">작성하기</a>
					</c:if>
				</div>
            </div>
    	</div>
	</div>
</div>
<script type="text/javascript" src="script/qna/qna.js"></script>
</body>
<%@ include file="../footer.jsp"%>
</html>