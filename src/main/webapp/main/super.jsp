<%@page import="java.util.ArrayList"%>
<%@page import="membership.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
List<MemberDTO> members = (ArrayList<MemberDTO>)request.getAttribute("members");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
<script type="text/javascript">
function formValidate(frm) {
	if (!frm.user_id.value) {
		alert("아이디를 입력하세요.");
		frm.user_id.focus();
		return false;
	}
	if (!frm.user_pw.value) {
		alert("패스워드를 입력하세요");
		frm.user_pw.focus();
		return false;
	}
}

// 회원 방출
function kick() {
	var kickId = document.getElementById("kickId").innerText;
	var isKick = confirm(kickId + " 회원을 정말로 강제 퇴출 시키겠습니까?");
	if (isKick) {
		location.href = "../member/kick.jsp?id=" + kickId;
	}
}
</script>

</head>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<div class="row container">
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered table-hover">
			<colgroup>
				<col width="100px"/>
				<col width="120px"/>
				<col width="200px"/>
				<col width="80px"/>
			</colgroup>
			
			<thead>
			<tr class="success">
				<th class="text-center">아이디</th>
				<th class="text-left">이름</th>
				<th class="text-center">이메일</th>
				<th class="text-center">강제 퇴출</th>
			</tr>
			</thead>
			
			<tbody>
			<!-- 리스트반복 -->
<%
for (MemberDTO dto : members) {
%>
			<tr>
				<td class="text-center" id="kickId"><%= dto.getId() %></td>
				<td class="text-left"><%= dto.getName() %></td>
				<td class="text-center"><%= dto.getEmail() %></td>
				<td class="text-center"><a href="javascript:void(0);" onclick="kick();">퇴출</a></td>
			</tr>
<%
}
%>
			</tbody>
			</table>
		</div>
		
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>