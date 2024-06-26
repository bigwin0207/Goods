<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/admin.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
	<body class="sb-nav-fixed">
        <!-- header -->
        <jsp:include page="../fix/admin/header.jsp"/>
        
        <div id="layoutSidenav">
        	<!-- side -->
        	<jsp:include page="../fix/admin/sidemenu.jsp"/>
        	
        	<div id="layoutSidenav_content">
        		<div class="w-100 vh-100 d-flex justify-content-center align-items-center">
	        		<div class="card w-50">
			            <div class="card-body">
			              	<h5 class="card-title">Login Form</h5>
			              	
			              	<form method="post" action="/adminLogin">
			                	<div class="row mb-3">
			                  		<label for="inputEmail3" class="col-sm-2 col-form-label">Admin ID</label>
			                  		<div class="col-sm-10">
			                    		<input type="text" class="form-control" name="adminID">
			                  		</div>
			                	</div>
			                	<div class="row mb-3">
			                  		<label for="inputPassword3" class="col-sm-2 col-form-label">Password</label>
			                  		<div class="col-sm-10">
			                    		<input type="password" class="form-control" name="pwd">
			                  		</div>
			                	</div>
			                	<div class="text-center">
			                  		<button type="submit" class="btn btn-primary">로그인</button>
			                  		<button type="reset" class="btn btn-secondary">리셋</button>
			                	</div>
			              	</form>
			           	</div>
					</div>
				</div>
        	</div>
        </div>
	</body>
</html>