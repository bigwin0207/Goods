<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="/css/admin.css">
	<link rel="stylesheet" href="/css/admin/admingoods.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

</head>
<body class="sb-nav-fixed">
<!-- header -->
<jsp:include page="../fix/admin/header.jsp"/>

<div id="layoutSidenav">
	<!-- side -->
	<jsp:include page="../fix/admin/sidemenu.jsp"/>
	<div id="layoutSidenav_content">
		<form name="goodsWriteForm" method="post" enctype="multipart/form-data">
			<div class="admin-goods-write-container">

				<c:choose>
				<c:when test="${empty updateGoods}">
				<!-- ----------------------- 상품 등록 페이지 ------------------------ -->
				<div id="hiddenFields"></div>
				<div class="admin-container-title">
					상품 등록 페이지
				</div>
				<div class="admin-goods-inner-container">
					<div class="input-label">
						<div class="labelfield">상품명</div>
						<div class="labelfield">원가</div>
						<div class="labelfield">판매가</div>
						<div class="labelfield">마진</div>
						<div class="labelfield">상세설명</div>
						<div class="labelfield">카테고리</div>
						<div class="labelfield">베스트YN</div>
						<div class="labelfield">판매중YN</div>
						<div class="labelfield">이미지 등록</div>
						<div class="labelfield">이미지 미리보기</div>
					</div>

					<div class="input-container">
						<div class="input-inner-container">
							<div class="inputfield">
								<input type="text" name="gname">
							</div>
							<div class="inputfield">
								<input id="prices" type="text" name="o_price">
							</div>
							<div class="inputfield">
								<input id="prices" type="text" name="s_price">
							</div>
							<div class="inputfield">
								<input id="prices" type="text" name="m_price">
							</div>
							<div class="inputfield">
								<input type="text" name="content">
							</div>
							<div class="inputfield">
								<select name="cgseq">
									<option value="0" selected="selected"> 카테고리 선택 </option>
									<c:forEach items="${categoryList}" var="cate" varStatus="stat">
									<option value="${cate.cgseq}"> ${cate.category}
										</c:forEach>
								</select>
							</div>
							<div class="inputfield">
								<input type="radio" name="bestyn" value="1" checked="checked">&nbsp; 사용 &nbsp;&nbsp;
								<input type="radio" name="bestyn" value="0">&nbsp;미사용
							</div>
							<div class="inputfield">
								<input type="radio" name="useyn" value="1" checked="checked">&nbsp;판매 &nbsp;&nbsp;
								<input type="radio" name="useyn" value="0">&nbsp;미판매
							</div>
							<div class="inputfield">
								<input type="text" id="fileInputButton" readonly="readonly" placeholder="파일 선택하기" style="cursor:pointer;">
							</div>
							<div class="imgfield">
								<div class="img-use-container">
									<div class="update-imgbox" id="prev-img">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="admin-btn">
				<input type="button" id="admingoods_insert" value="상품 등록">
			</div>
			</c:when>
			<c:otherwise>
			<!-- ----------------------- 상품 수정 페이지 ------------------------ -->
			<input type="hidden" name="gseq" value="${updateGoods.gseq}">
			<div class="admin-container-title">
				상품 등록 페이지
			</div>
			<div class="admin-goods-inner-container">
				<div class="input-label">
					<div class="labelfield">상품명</div>
					<div class="labelfield">원가</div>
					<div class="labelfield">판매가</div>
					<div class="labelfield">마진</div>
					<div class="labelfield">상세설명</div>
					<div class="labelfield">카테고리</div>
					<div class="labelfield">베스트YN</div>
					<div class="labelfield">판매중YN</div>
					<div class="labelfield">상품이미지</div>
					<div class="labelfield">기존이미지</div>
				</div>

				<div class="input-container">
					<div class="input-inner-container">
						<div class="inputfield">
							<input type="text" name="gname" value="${updateGoods.gname}">
						</div>
						<div class="inputfield">
							<input id="prices" type="text" name="o_price" value="${updateGoods.o_price}">
						</div>
						<div class="inputfield">
							<input id="prices" type="text" name="s_price" value="${updateGoods.s_price}">
						</div>
						<div class="inputfield">
							<input id="prices" type="text" name="m_price" value="${updateGoods.m_price}">
						</div>
						<div class="inputfield">
							<input type="text" name="content" value="${updateGoods.content}">
						</div>
						<div class="inputfield">
							<select name="cgseq">
								<c:forEach items="${categoryList}" var="cate">
								<c:choose>
								<c:when test="${cate.cgseq == updateGoods.cgseq}">
								<option value="${cate.cgseq}" selected="selected"> ${cate.category}
									</c:when>
									<c:otherwise>
								<option value="${cate.cgseq}"> ${cate.category}
									</c:otherwise>
									</c:choose>
									</c:forEach>
							</select>
						</div>
						<div class="inputfield">
							<c:choose>
								<c:when test='${updateGoods.bestyn==1}'>
									<input type="radio" name="bestyn" value="1" checked="checked">&nbsp;사용&nbsp;&nbsp;
									<input type="radio" name="bestyn" value="0">&nbsp;미사용&nbsp;&nbsp;
								</c:when>
								<c:otherwise>
									<input type="radio" name="bestyn" value="1">&nbsp;사용&nbsp;&nbsp;
									<input type="radio" name="bestyn" value="0" checked="checked">&nbsp;미사용&nbsp;&nbsp;
								</c:otherwise>
							</c:choose>
						</div>
						<div class="inputfield">
							<c:choose>
								<c:when test='${updateGoods.useyn==1}'>
									<input type="radio" name="useyn" value="1" checked="checked">&nbsp;판매&nbsp;&nbsp;
									<input type="radio" name="useyn" value="0">&nbsp;미판매&nbsp;&nbsp;
								</c:when>
								<c:otherwise>
									<input type="radio" name="useyn" value="1">&nbsp;판매&nbsp;&nbsp;
									<input type="radio" name="useyn" value="0" checked="checked">&nbsp;미판매&nbsp;&nbsp;
								</c:otherwise>
							</c:choose>
						</div>
						<div class="inputfield">
							<input type="file" name="image" multiple="multiple">
						</div>
						<div class="imgfield">
							<c:set var="imgcnt" value=""></c:set>
							<c:forEach items="${updateGoods.imageList}" var="img" varStatus="imgIdx">
								<div class="img-use-container">
									<div class="update-imgbox">
										<img src="/imageWrite?folder=${updateGoods.gseq}${updateGoods.gname}&realName=${img.realname}">
									</div>
									<div class="update-checkbox">
										<input type="checkbox" name="giseq" value="${img.giseq}">
										&nbsp; 사용하기
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

			<div class="admin-btn">
				<input type="button" id="admingoods_update" value="상품 수정">
			</div>
			</c:otherwise>
			</c:choose>
	</div>
	</form>
</div>
</div>
</div>

<div class="inputfield">
	<form name="fileUploadForm" id="fileUploadForm" method="post" enctype="multipart/form-data">
		<input type="file" name="image" multiple="multiple" id="fileInputHidden" style="display: none">
	</form>
</div>
<script type="text/javascript" src='script/admin/goodsWrite.js'></script>
</body>
</html>