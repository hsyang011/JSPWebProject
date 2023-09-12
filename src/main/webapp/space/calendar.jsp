<%@page import="java.util.ArrayList"%>
<%@page import="board.CalendarDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.CalendarDAO"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ include file="../include/global_head.jsp" %>
<style>
	.day:hover { background-color: #E2E2E2; cursor: pointer; }
</style>

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
if (pYear!=null && !pYear.equals("")) {
	year = Integer.parseInt(pYear);
}
if (pMonth!= null && !pMonth.equals("")) {
	month = Integer.parseInt(pMonth);
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






// 캘린더 일정 가져오기
CalendarDAO dao = new CalendarDAO();
List<CalendarDTO> scList = dao.allSchedule(Integer.toString(year), (month<10 ? "0"+month : ""+month));
dao.close();
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

<script type="text/javascript">
function insertSch(day) {
	var schedule = prompt(day + "일에 추가할 일정을 입력해주세요.");
	if (schedule != null) {			
		document.scheduleFrm.schedule.value = schedule;
		document.scheduleFrm.day.value = day;
		document.scheduleFrm.submit();
	}
}
</script>
<style>
td{border:1px solid lightgray;}
</style>
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
<!-- 서블릿으로 전송할 폼값을 post방식으로 전송한다. -->
<form method="post" action="../board/calendar.do" name="scheduleFrm">
	<input type="hidden" name="schedule" value="" />
	<input type="hidden" name="year" value="<%= year %>" />
	<input type="hidden" name="month" value="<%= month %>" />
	<input type="hidden" name="day" value="" />
</form>

<!-- 달력 페이지 -->
<form>
	<input class="border" style="border-radius: 5px;" type="text" name="year" />년&nbsp;
	<input class="border" style="border-radius: 5px;" type="text" name="month" />월&nbsp;
	<input class="border" type="submit" value="이동" style="margin-bottom: 2px;" />
</form>
<br />
<div class="row">
		<!-- 회원정보 리스트 -->
		<div class="row container">
			<!-- 게시판리스트부분 -->
			<table class="table" style="border:1px solid lightgray; margin-left: 12px">
			<colgroup>
			    <col width="100px" />
			    <col width="100px" />
			    <col width="100px" />
			    <col width="100px" />
			    <col width="100px" />
			    <col width="100px" />
			    <col width="100px" />
			</colgroup>
			
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
       			<td class="text-left day" style="font-size: 10px" onclick="insertSch(<%= currentDay %>);"><%= currentDay %>
<%
		for (CalendarDTO dto : scList) {
			String _day = Integer.parseInt(dto.getScheduleDate().split("-")[2])<10 ? dto.getScheduleDate().split("-")[2].substring(1) : dto.getScheduleDate().split("-")[2];
			int day = Integer.parseInt(_day);
			if (day == currentDay) {
%>
				<p>※ <%= dto.getName() %> <br /> - <%= dto.getSchedule() %></p>
<%
			}
		}
        currentDay++;
%>
				</td>
<%
    }

    if (currentDay > lastDay) {
		break;
    }

    if (i%7 == 0) {
%>
       		</tr>
       		<tr height="100">
<%  	
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