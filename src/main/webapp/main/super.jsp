<%@page import="market.PaymentDTO"%>
<%@page import="utils.JSFunction"%>
<%@page import="market.ExpstudyDTO"%>
<%@page import="market.BlueCleaningDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="membership.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="utils.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
// 잘못된 접근일 경우에 대비해 슈퍼 계정권한이 있는지 확인한다.
if (!(session.getAttribute("UserGrade") != null && session.getAttribute("UserGrade").toString().equals("Super"))) {
	JSFunction.alertLocation("슈퍼 계정만 액세스할 수 있습니다.", "../member/login.jsp", out);
	// return이후의 문장은 실행되지 않는다.
	return;
}
List<MemberDTO> members = (ArrayList<MemberDTO>)request.getAttribute("members");
List<BlueCleaningDTO> bcList = (ArrayList<BlueCleaningDTO>)request.getAttribute("bcList");
List<ExpstudyDTO> exList = (ArrayList<ExpstudyDTO>)request.getAttribute("exList");
List<PaymentDTO> paList = (ArrayList<PaymentDTO>)request.getAttribute("paList");
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

$(function() {
	// 회원 방출
	$(".kick").click(function(e) {
		var id = $(e.target).parent().prev().prev().prev().text();
		var isKick = confirm(id + " 회원을 정말로 강제 퇴출 시키겠습니까?");
		if (isKick) {
			location.href = "../member/kick.jsp?id=" + id;
		}
	});
	
	// 블루클리닉 신청 접수 취소
	$(".bcCancel").click(function(e) {
		var num = $(e.target).parent().prev().prev().prev().prev().prev().prev().prev().text();
		var isAppCancel = confirm(num + "번 접수를 정말로 취소하시겠습니까?");
		if (isAppCancel) {
			location.href = "../market/bluecleaningCancel.jsp?num=" + num;
		}
	});
	
	// 체험학습신청 접수 취소
	$(".exCancel").click(function(e) {
		var num = $(e.target).parent().prev().prev().prev().prev().prev().prev().prev().text();
		var isAppCancel = confirm(num + "번 접수를 정말로 취소하시겠습니까?");
		if (isAppCancel) {
			location.href = "../market/expstudyCancel.jsp?num=" + num;
		}
	});
	
	// 결제 취소
	$(".paCancel").click(function(e) {
		var id = $(e.target).parent().prev().prev().prev().prev().prev().text();
		var isPaCancel = confirm(id + "회원의 결제 요청을 정말로 취소하시겠습니까?");
		if (isPaCancel) {
			location.href = "../market/paymentCancel.jsp?id=" + id;
		}
	});
});
</script>

</head>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>

		<!-- 회원정보 리스트 -->
		<div class="row container">
			<h5>※회원정보 리스트※</h5>
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
				<th class="text-center">이름</th>
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
				<td class="text-center"><%= dto.getId() %></td>
				<td class="text-center"><%= dto.getName() %></td>
				<td class="text-center"><%= dto.getEmail() %></td>
				<td class="text-center"><a href="javascript:void(0);" class="kick">퇴출</a></td>
			</tr>
<%
}
%>
			</tbody>
			</table>
		</div>
		
		<!-- 블루클리닝 신청 리스트 -->
		<div class="row container">
			<h5>※블루클리닝 신청 리스트※</h5>
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered table-hover">
			<%-- <colgroup>
				<col width="100px"/>
				<col width="120px"/>
				<col width="200px"/>
				<col width="80px"/>
			</colgroup> --%>
			
			<thead>
			<tr class="success">
				<th class="text-center">번호</th>
				<th class="text-center">아이디</th>
				<th class="text-center">고객명/회사명</th>
				<th class="text-center">청소종류</th>
				<th class="text-center">분양평수/등기평수</th>
				<th class="text-center">청소희망날짜</th>
				<th class="text-center">접수종류 구분</th>
				<th class="text-center">접수 취소</th>
			</tr>
			</thead>
			
			<tbody>
			<!-- 리스트반복 -->
<%
for (BlueCleaningDTO dto : bcList) {
%>
			<tr>
				<td class="text-center"><%= dto.getNum() %></td>
				<td class="text-center"><%= dto.getId() %></td>
				<td class="text-center"><%= dto.getName() %></td>
				<td class="text-center"><%= dto.getCleaning_type() %></td>
				<td class="text-center"><%= dto.getArea() %></td>
				<td class="text-center"><%= dto.getCleaning_date() %></td>
				<td class="text-center"><%= dto.getApplication_type() %></td>
				<td class="text-center"><a href="javascript:void(0);" class="bcCancel">취소</a></td>
			</tr>
<%
}
%>
			</tbody>
			</table>
		</div>
		
		<!-- 체험학습신청 리스트 -->
		<div class="row container">
			<h5>※체험학습신청 리스트※</h5>
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered table-hover">
			<%-- <colgroup>
				<col width="100px"/>
				<col width="120px"/>
				<col width="200px"/>
				<col width="80px"/>
			</colgroup> --%>
			
			<thead>
			<tr class="success">
				<th class="text-center">번호</th>
				<th class="text-center">아이디</th>
				<th class="text-center">고객명/회사명</th>
				<th class="text-center">케잌체험</th>
				<th class="text-center">쿠키체험</th>
				<th class="text-center">체험희망날짜</th>
				<th class="text-center">접수종류 구분</th>
				<th class="text-center">접수 취소</th>
			</tr>
			</thead>
			
			<tbody>
			<!-- 리스트반복 -->
<%
for (ExpstudyDTO dto : exList) {
%>
			<tr>
				<td class="text-center"><%= dto.getNum() %></td>
				<td class="text-center"><%= dto.getId() %></td>
				<td class="text-center"><%= dto.getName() %></td>
				<td class="text-center"><%= dto.getExp_cake() %></td>
				<td class="text-center"><%= dto.getExp_cookie() %></td>
				<td class="text-center"><%= dto.getExpstudy_date() %></td>
				<td class="text-center"><%= dto.getApplication_type() %></td>
				<td class="text-center"><a href="javascript:void(0);" class="exCancel">취소</a></td>
			</tr>
<%
}
%>
			</tbody>
			</table>
		</div>
		
		<!-- 결제 정보 리스트 -->
		<div class="row container">
			<h5>※결제 정보 리스트※</h5>
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered table-hover">
			<%-- <colgroup>
				<col width="100px"/>
				<col width="120px"/>
				<col width="200px"/>
				<col width="80px"/>
			</colgroup> --%>
			
			<thead>
			<tr class="success">
				<th class="text-center">아이디</th>
				<th class="text-center">성명</th>
				<th class="text-center">우편번호</th>
				<th class="text-center">결제금액</th>
				<th class="text-center">결제방식</th>
				<th class="text-center">결제 취소</th>
			</tr>
			</thead>
			
			<tbody>
			<!-- 리스트반복 -->
<%
for (PaymentDTO dto : paList) {
%>
			<tr>
				<td class="text-center"><%= dto.getId() %></td>
				<td class="text-center"><%= dto.getName() %></td>
				<td class="text-center"><%= dto.getZipcode() %></td>
				<td class="text-center"><%= dto.getPayment_amount() %></td>
				<td class="text-center"><%= dto.getPayment_type() %></td>
				<td class="text-center"><a href="javascript:void(0);" class="paCancel">결제 취소</a></td>
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