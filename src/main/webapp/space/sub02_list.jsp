<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<%
// 세션영역에 tname속성으로 테이블명 저장
session.setAttribute("tname", "calendar_board");
session.setAttribute("seqname", "seq_calendar_num");
%>
<!-- common_list.jsp 파일 포함하기 -->
<%@ include file="./common_list.jsp" %>

<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dayjs/1.10.7/dayjs.min.js"></script>
<script>
window.onload = async function() {
    console.log("");
    console.log("=========================================");
    console.log("[window onload] : [start]");
    console.log("=========================================");
    console.log(""); 


    // [현재 날짜 및 시간 확인]
    var korea_date = dayjs(new Date().toLocaleString("en-US", {timeZone: "Asia/Seoul"}));
    var format = "YYYY-MM-DDTHH:mm:ss"; // 포맷 타입
    var koreaNow = korea_date.format(format);


    // [calendar 객체 지정]
    var calendarElement = document.getElementById("calendar");


    // [full-calendar 생성]
    var calendar = new FullCalendar.Calendar(calendarElement, {
        
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '00:00', // 캘린더에서 일정 시작 시간
        slotMaxTime: '23:59', // 캘린더에서 일정 종료 시간

        // 해더에 표시할 툴바
        headerToolbar: {
            left: 'prev,next', // 이전, 다음
            //left: 'prev,next,today', // 이전, 다음, 오늘
            center: 'title', // 중앙 타이틀
            right: 'dayGridMonth,timeGridDay' // 월, 일
            //right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek' // 월, 주, 일, 일정목록
        },

        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면 (기본 설정: 달)
        
        //initialDate: '2023-08-06', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        
        editable: true, // 수정 가능 여부
        
        selectable: true, // 달력 일자 드래그 설정가능
        
        nowIndicator: true, // 현재 시간 마크
        
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        
        locale: 'ko', // 한국어 설정

        selectLongPressDelay:300, // 선택 클릭 발동 시간 
        
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
            console.log("");
            console.log("=========================================");
            console.log("[window onload] : [eventAdd]");
            console.log("-----------------------------------------");
            console.log("[eventAdd] : " + JSON.stringify(obj));
            console.log("=========================================");
            console.log(""); 
        },
        
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
            console.log("");
            console.log("=========================================");
            console.log("[window onload] : [eventChange]");
            console.log("-----------------------------------------");
            console.log("[eventChange] : " + JSON.stringify(obj));
            console.log("=========================================");
            console.log(""); 
        },
        
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
            console.log("");
            console.log("=========================================");
            console.log("[window onload] : [eventRemove]");
            console.log("-----------------------------------------");
            console.log("[eventRemove] : " + JSON.stringify(obj));
            console.log("=========================================");
            console.log(""); 
        },

        //*
        eventClick : function(info) { // 등록된 일정 클릭 이벤트
            console.log("");
            console.log("=========================================");
            console.log("[window onload] : [eventClick]");
            console.log("-----------------------------------------");
            /* console.log("[eventClick] : " + JSON.stringify(info)); */
            console.log("=========================================");
            console.log(""); 

             // 캘린더에서 해당 일정 삭제
            info.event.remove();

        },
        // */
        
        select: function(arg) { // 캘린더에서 특정 일자 선택 및 드래그로 일정 등록
            console.log("");
            console.log("=========================================");
            console.log("[window onload] : [select]");
            console.log("-----------------------------------------");
            /* console.log("[arg] : " + JSON.stringify(arg)); */
            console.log("=========================================");
            console.log(""); 

            var title = prompt('새로운 일정을 추가해주세요');
            if (title) {
                calendar.addEvent({
                    title: title,
                    start: arg.start,
                    end: arg.end,
                    allDay: arg.allDay
                })
            }
            calendar.unselect()
        },

        // 이벤트 일정 등록
        events: [
            { title: '투케이 공부', start: koreaNow, end: koreaNow }
        ]
    });
    

    // [캘린더 랜더링]
    calendar.render();            

};
</script>

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
				<div id="calendar">
				
				
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>