<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/index/index.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
    <div id="container">
		<div class="section">
			<div class="section-title"> New </div>
			<div class="product-row">
			<c:forEach items="${newlist}" var="gvo" varStatus="status">
				<div class="product-box">
					<div class="product-info">
						<a href="goodsDetailView?gseq=${gvo.gseq}">
							<div class="product-image">
								<c:forEach var="image" items="${gvo.imageList}">
					                <c:set var="key" value="${gvo.gseq}${gvo.gname}${image.realname}"/>
					                <img alt="${image.realname}" src="data:image/jpeg;base64,${imageMap[key]}"/>
					            </c:forEach>
							</div>
							${gvo.gname} - <fmt:formatNumber type="currency" value="${gvo.sprice}"></fmt:formatNumber>
						</a>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		
		<div class="section">
			<div class="section-title"> Best 20 </div>
			<div class="product-row">
				<c:forEach items="${bestlist}" var="gvo" varStatus="status">
					<c:if test="${status.index < 8}">
						<div class="product-box">
							<div class="product-info">
								<a href="goodsDetailView?gseq=${gvo.gseq}">
									<div class="product-image">
										<c:forEach var="image" items="${gvo.imageList}">
							                <c:set var="key" value="${gvo.gseq}${gvo.gname}${image.realname}"/>
							                <img alt="${image.realname}" src="data:image/jpeg;base64,${imageMap[key]}"/>
							            </c:forEach>
									</div>
									${gvo.gname} - <fmt:formatNumber type="currency" value="${gvo.sprice}"></fmt:formatNumber>
								</a>
							</div>
						</div>
					</c:if>
				</c:forEach>
			</div>
			<br><br>
			<div class="view-all">
				<a href="viewCategory.do?cgseq=0">전체보기</a>
			</div>
			<br><br><br><br>
		</div>
			
		<!-- 공지사항 -->
		<div class="card w-100 mt-3">
		 	<div class="card-header d-flex justify-content-between">
				<div>공지사항</div>
				<div>
					<a href="noticeList"><i class="bi bi-plus-circle"></i> 전체보기</a>
				</div>
		  	</div>
			<ul class="list-group list-group-flush">
				<c:forEach var="notice" items="${noticeList}">
					<a class="link" href="noticeView?nseq=${notice.nseq}">
						<li class="list-group-item list-group-item-action d-flex li-item">
							<div class="small-col">${notice.nseq}</div>
				        	<div class="small-col">${notice.adminId}</div>
				        	<div>
				           		<c:choose>
									<c:when test="${fn:length(notice.subject) gt 26}">
										<c:out value="${fn:substring(notice.subject, 0, 25)}"/>...
									</c:when>
									<c:otherwise>
										<c:out value="${notice.subject}"/>
									</c:otherwise>
								</c:choose>
							</div>
							<div>
				         		<c:choose>
				              		<c:when test="${fn:length(notice.content) gt 26}">
				                 		<c:out value="${fn:substring(notice.content, 0, 25)}"/>...
				              		</c:when>
				              		<c:otherwise>
				                 		<c:out value="${notice.content}"/>
				              		</c:otherwise>
				        		 </c:choose>
				      		</div>
				      		<div class="small-col"><fmt:formatDate value="${notice.indate}" type="both" pattern="yyyy-MM-dd" /></div>
						</li>
					</a>
		     	</c:forEach>
		  	</ul>
		</div>

		<div class="d-flex col mt-3 justify-content-between">
			<!-- Q&A -->
			<div class="card w-50 me-2">
				<div class="card-header d-flex justify-content-between">
			  		<div>Q&A</div>
					<div>
			    		<a href="qnaList"><i class="bi bi-plus-circle"></i> 전체보기</a>
					</div>
			  	</div>
			  	<ul class="list-group list-group-flush">
			  		<c:forEach var="qna" items="${qnaList}">
				  		<a class="link" href="qnaView?qseq=${qna.qseq}">
					  		<li class="list-group-item list-group-item-action d-flex li-item">
					  			<div class="small-col">${qna.qseq}</div>
					  			<div>
						  				<c:choose>
							        		<c:when test="${fn:length(qna.subject) gt 26}">
							        			<c:out value="${fn:substring(qna.subject, 0, 25)}"/>...
							        		</c:when>
							        		<c:otherwise>
							        			<c:out value="${qna.subject}"/>
							        		</c:otherwise>
										</c:choose>
										<c:if test="${not empty qna.replyDate}"><i class="bi bi-clipboard-check"></i></c:if>
								</div>
								<div class="small-col">${qna.userid}</div>
								<div class="small-col"><fmt:formatDate value="${qna.indate}" type="both" pattern="yyyy-MM-dd" /></div>
							</li>
						</a>
			  		</c:forEach>
				</ul>
			</div>
	
			<!-- review -->
			<div class="card w-50 ms-2">
				<div class="card-header d-flex justify-content-between">
					<div>Review</div>
					<div>
						<a href="reviewList.do"><i class="bi bi-plus-circle"></i> 전체보기</a>
					</div>
				</div>
				<ul class="list-group list-group-flush">
			  		<c:forEach var="rev" items="${reviewList}">
				  		<a class="link" href="goodsDetailView?gseq=${rev.gseq}">
							<li class="list-group-item list-group-item-action d-flex li-item">
								<div>
									<c:choose>
							        	<c:when test="${fn:length(rev.gname) gt 16}">
							        		<c:out value="${fn:substring(rev.gname, 0, 15)}"/>...
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
								<div class="small-col">${rev.userid}</div>
								<div class="middle-col"><fmt:formatDate value="${rev.indate}" type="both" pattern="yyyy-MM-dd" /></div>
							</li>
						</a>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
<script type="text/javascript" src="../goods/main.js"/></script>
</body>
<%@ include file="../footer.jsp"%>
</html>