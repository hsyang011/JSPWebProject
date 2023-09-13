<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=y4y0ny6j1b&callback=initMap"></script>
<script type="text/javascript">
var map = null;

function initMap() {
    map = new naver.maps.Map('map', {
    	// 지도 중앙 위치 : 위도, 경도 설정
    	center : new naver.maps.LatLng( 37.480004, 127.148338 ),

    	// 줌 설정 : 1~14, 수치가 클수록 지도 확대(줌인), 이 옵션 생략시 기본값 9
    	zoom : 16,

    	// 줌 컨트롤 표시, 지정하지 않으면 false 가 기본값
    	zoomControl : true,

    	// 줌 컨트롤 오른쪽 위로 위치 설정
    	zoomControlOptions : {
    		position : naver.maps.Position.TOP_RIGHT // 오른쪽 위로 설정
    	},

    	// 일반ㆍ위성 지도보기 컨트롤 표시, 지정하지 않으면 false 가 기본값
    	mapTypeControl : true,
    });
    
    var position = new naver.maps.LatLng(37.480004, 127.148338);
    
    var markerOptions = {
    	    position: position,
    	    map: map,
    	    icon: {
    	        url: '../images/marker.png',
    	        size: new naver.maps.Size(44, 70),
    	        origin: new naver.maps.Point(0, 0),
    	        anchor: new naver.maps.Point(11, 35)
    	    }
    	};

   	var marker = new naver.maps.Marker(markerOptions);
   	
   	
   	var contentString = [
        '<div class="iw_inner" style="padding: 10px; margin-top: 10px">',
        '   <h6>위례동 스타필드</h6>',
        '   <p>경기도 하남시 위례대로 200<br />',
        '   </p>',
        '</div>'
    ].join('');

	var infowindow = new naver.maps.InfoWindow({
	    content: contentString
	});
	
	naver.maps.Event.addListener(marker, "click", function(e) {
	    if (infowindow.getMap()) {
	        infowindow.close();
	    } else {
	        infowindow.open(map, marker);
	    }
	});
	
	infowindow.open(map, marker);
	}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/center/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<img src="../images/center/left_title.gif" alt="센터소개 Center Introduction" class="left_title" />
				<%@ include file="../include/center_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/center/sub07_title.gif" alt="오시는길" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;센터소개&nbsp;>&nbsp;오시는길<p>
				</div>
				
				<div class="con_box">
					<p class="con_tit"><img src="../images/center/sub07_tit01.gif" alt="오시는길" /></p>
					
					<!-- 지도 api -->
					<div id="map" style="width:100%;height:400px;"></div><br /><br />
					<p class="con_tit"><img src="../images/center/sub07_tit02.gif" alt="자가용 오시는길" /></p>
					<div class="in_box">
						<p class="dot_tit">서울 송파구 오금동</p>
						<p style="margin-bottom:15px;">3호선 오금역 오금공원에서 성내천을 따라 성내천로 진입 → 성내천 5호선 개롱역과 거여역을 지나서 마천터널로 진입 → <br/> 위례대로를 타고 직진 </p>
						<p class="dot_tit">경기도 하남시 학암동</p>
						<p style="margin-bottom:15px;">8호선 복정역에서 복정역교차로 진입 → 헌릉로를 거쳐서 위례터널로 진입 → 위례터널에서 위례대로로 우회전 <br /> → 위례대로를 타고 직진 </p>
					</div>
					<p class="con_tit"><img src="../images/center/sub07_tit03.gif" alt="대중교통 이용시" /></p>
					<div class="in_box">
						<p class="dot_tit">버스</p>
						<p style="margin-bottom:15px;">3217번, 31번, 38번, 200번, 231번, 9202번 → 스타필드시티 위례 정류장에서 하차<br /></p>
						<p class="dot_tit">지하철</p>
						<p style="margin-bottom:15px;">5호선 거여역에서 하차 후 도보 20분&nbsp;&nbsp;3호선 가락시장역에서 하차 후 3217번, 3420번, 31번, 345번으로 환승<br />8호선 복정역에서 31번, 38번으로 환승<br /></p>
						<p class="dot_tit">마을버스</p>
						<p>위례-01번</p>
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
