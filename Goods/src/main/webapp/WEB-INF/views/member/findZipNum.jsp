<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="resources/css/member.css">
<title>Insert title here</title>
</head>
<body>
<div id="popup">
	<h2>주소 검색</h2>
   <form method="post" name="formm" action="findZipnum.do" style="width:100%; margin-bottom: 15px;">
      동 이름 입력 : <input name="dong" type="text" style="height: 25px;">
      <input type="submit" value="찾기" id="search" class="submit">
      
   </form>
  <table id="zipcode" border="1" style="width: 70%; margin: 0 auto;">
      <tr><th width="100">우편번호</th><th>주소</th></tr>
      <c:forEach items="${addressList}" var="add">
         <tr>
            <td>
               <a href="#" onclick="addressOK('${add.zip_num}', '${add.sido}', '${add.gugun}', '${add.dong}')">
                  ${add.zip_num}
               </a>
            </td>
            <td>
               <a href="#" onclick="addressOK('${add.zip_num}', '${add.sido}', '${add.gugun}', '${add.dong}')">
                  ${add.sido} ${add.gugun} ${add.dong} 
               </a>
            </td>
         </tr>
      </c:forEach>
   </table>
</div>
<script src="<c:url value='/resources/js/member/newID.js'/>"></script>
</body>
</html>