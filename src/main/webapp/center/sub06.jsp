<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script type="text/javascript" src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=y4y0ny6j1b&callback=initMap"></script>
<script type="text/javascript">
var map = null;

function initMap() {
    map = new naver.maps.Map('map', {
    	// 지도 중앙 위치 : 위도, 경도 설정
    	center : new naver.maps.LatLng( 37.4977689, 127.1631099 ),

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
    
    var position = new naver.maps.LatLng(37.4977689, 127.1631099);
    
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
        '   <h6>우리집</h6>',
        '   <p>경기도 하남시 감일백제로 20 (포웰시티 푸르지오 라포레)<br />',
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
				
				<!-- 지도 api -->
				<div id="map" style="width:100%;height:400px;">
				
				</div>
				
				
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
