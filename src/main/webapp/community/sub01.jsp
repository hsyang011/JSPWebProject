<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
//세션영역에 tname속성으로 테이블명 저장
session.setAttribute("tname", "staff_board");
session.setAttribute("seqname", "seq_staff_num");
%>
<script type="text/javascript">
$(function() {
	var chk = prompt("직원 전용 게시판입니다. 암호를 입력해주세요.");
	if (chk == "1234") {
		alert("직원 확인되었습니다. 게시판으로 이동합니다.");
		location.href = "../board/list.do";
	} else {
		alert("암호가 틀렸습니다.");
		location.href = "../main/main.do";
	}
});
</script>