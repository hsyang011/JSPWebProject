<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>
<style>
	.day:hover { background-color: #E2E2E2; cursor: pointer; }
</style>
<script type="text/javascript">
$(function() {
	$(".day").click(function() {
		alert("안녕");
	});
});
</script>
<%
String tname = request.getParameter("tname");
String pYear = request.getParameter("year");
String pMonth = request.getParameter("month");

// 캘린더 클래스의 객체 가져오기
Calendar calendar = Calendar.getInstance();
// 날짜와 월을 오늘 날짜로 초기화한다.
int year = calendar.get(Calendar.YEAR);
int month = calendar.get(Calendar.MONTH) + 1;
// 파라미터로 들어온 값이 있다면 그 값으로 초기화한다.
if (pYear != null) {
	year = calendar.get(Calendar.YEAR);
}
if (pMonth != null) {
	month = calendar.get(Calendar.MONTH) + 1;
}

calendar.set(year, month - 1, 1);

// 해당 달의 마지막 일자(DATE) 얻기
int lastDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

// 해당 달의 시작 요일 얻기
// 1: 일요일 2: 월요일, 3: 화요일 ....
int startDay = calendar.get(Calendar.DAY_OF_WEEK);

System.out.println(year + "년" + month + "월 \n");
System.out.println("일\t월\t화\t수\t목\t금\t토");
int currentDay = 1;

// 달력 렌더링
/* for (int i = 0; i <= 42; i++) {
    if (i < startDay) {
        System.out.print("\t");
    } else {
        System.out.printf("%02d\t", currentDay);
        currentDay++;
    }

    if (i % 7 == 0) {
        System.out.println();
    }

    if (currentDay > lastDay) {
        break;
    }
} */

%>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>

<div class="row">
		<!-- 회원정보 리스트 -->
		<div class="row container">
			<!-- 게시판리스트부분 -->
			<table class="table table-bordered">
			
			<thead>
			<tr class="success">
				<th class="text-center">일</th>
				<th class="text-center">월</th>
				<th class="text-center">화</th>
				<th class="text-center">수</th>
				<th class="text-center">목</th>
				<th class="text-center">금</th>
				<th class="text-center">토</th>
			</tr>
			</thead>
			
			<tbody>
			<!-- 달력 렌더링 -->

			<tr height="100">
<%
for (int i=1; i<=42; i++) {
    if (i < startDay) {
%>
       			<td class="text-left day"></td>
<%
    } else {
%>
       			<td class="text-left day"><%= currentDay %></td>
<%
        currentDay++;
    }

    if (i%7 == 0) {
%>
       		</tr>
       		<tr height="100">
<%  	
    }

    if (currentDay > lastDay) {
		break;
    }
}
%>
			</tr>
			</tbody>
			</table>
		</div>
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>